import 'package:flutter/material.dart';
import 'package:flutter_core/extensions/extensions.dart';
import 'package:flutter_core/localizations/generated/core.dart';
import 'package:flutter_core/plugins/app_bar_data.dart';
import 'package:flutter_core/plugins/plugins.dart';
import 'package:rxdart/subjects.dart';

import 'screen.dart';

class FragmentManager {
  static FragmentManager? _manager;

  // ko dung BehaviorSubject vi chia nhieu` kenh -> phai luu last value cua moi kenh,
  // con` BehaviorSubject chi ghi nho 1 last value
  final _fragmentSubject = PublishSubject<_Fragment>();
  final _appBarSubject = PublishSubject<AppBarData>();

  final Map<String, List<PluginScreen>> _screenMap = {};

  FragmentManager._();

  Stream<PluginScreen> getStream(String channel) => _fragmentSubject
      .where((f) => f.channel == channel && f.notifyChange)
      .map((f) => f.screen);

  Stream<PluginScreen> get stream => _fragmentSubject.map((f) => f.screen);

  Stream<AppBarData> get appBarDataStream => _appBarSubject.stream;

  PluginScreen replaceLast(
      {required String channel,
      required PluginScreen screen,
      notifyChange = true}) {
    _screenMap[channel]?.takeIf((it) => it.isNotEmpty)?.removeLast();
    return add(channel: channel, screen: screen, notifyChange: notifyChange);
  }

  PluginScreen replaceAll(
      {required String channel,
      required PluginScreen screen,
      notifyChange = true}) {
    _screenMap[channel]?.takeIf((it) => it.isNotEmpty)?.clear();
    return add(channel: channel, screen: screen, notifyChange: notifyChange);
  }

  PluginScreen add(
      {required String channel,
      required PluginScreen screen,
      notifyChange = true}) {
    if (_screenMap[channel] == null) {
      _screenMap[channel] = [];
    }
    _screenMap[channel]?.let((it) {
      it.add(screen);
      _fragmentSubject
          .add(_Fragment(channel, screen, notifyChange: notifyChange));
    });
    return screen;
  }

  void _notifyLastItemChange(String channel) {
    _screenMap[channel]?.let((it) {
      _fragmentSubject.add(_Fragment(channel, it.last));
    });
  }

  bool isEmptyChannel({required String channel}) {
    return _screenMap[channel]?.isEmpty ?? true;
  }

  int remainScreens({required String channel}) {
    return _screenMap[channel]?.length ?? 0;
  }

  void setAppTitle(String title, {args}) {
    _appBarSubject.add(AppBarData(title: title, args: args));
  }

  bool back({required String channel}) {
    final existChannel = _screenMap.containsKey(channel);
    if (!existChannel) {
      print('Maybe wrong channel when click back with \'$channel\' channel');
    }
    final keepAppAlive =
        _screenMap[channel]?.takeIf((it) => it.length > 1)?.let<bool>((it) {
              it.removeLast();
              final routes = it.map((screen) => screen.route).join(',');
              print('Channel $channel: back to ${it.last.route}, '
                  'count: ${it.length}, '
                  'remains: $routes');
              _fragmentSubject.add(_Fragment(channel, it.last));
              return true;
            }) ??
            false;
    return keepAppAlive;
  }

  static FragmentManager get instance {
    FragmentManager? manager = _manager;
    if (manager == null) {
      manager = FragmentManager._();
      _manager = manager;
    }
    return manager;
  }
}

class _Fragment {
  final String channel;
  final PluginScreen screen;
  final notifyChange;

  _Fragment(this.channel, this.screen, {this.notifyChange = true});
}

class FragmentStream extends StreamBuilder<PluginScreen> {
  final String channel;
  final Widget Function(BuildContext context)? emptyChannel;
  final Widget Function(BuildContext context)? notFoundPage;
  final WillPopCallback? onWillPop;
  final Widget Function(BuildContext context, Widget widget)? widgetBuilder;

  FragmentStream(
      {Key? key,
      required this.channel,
      PluginScreen? initial,
      this.onWillPop,
      this.emptyChannel,
      this.widgetBuilder,
      this.notFoundPage})
      : super(
          key: key,
          initialData: initial,
          stream: FragmentManager.instance.getStream(channel),
          builder: (context, snapshot) {
            final Widget child;
            if (channel.isEmpty) {
              child =
                  emptyChannel?.call(context) ?? _defaultEmptyChannel(context);
            } else {
              switch (snapshot.connectionState) {
                //initial data
                case ConnectionState.waiting:
                  final screenList =
                      FragmentManager.instance._screenMap[channel];
                  final haveChildScreen =
                      screenList?.let((it) => it.length > 1) ?? false;
                  final childReplaceParent = screenList?.let(
                        (it) =>
                            it.length == 1 &&
                            it.last.route != snapshot.data?.route,
                      ) ??
                      false;
                  if (haveChildScreen || childReplaceParent) {
                    child = Container(); //screenList.last.newWidget();
                    FragmentManager.instance._notifyLastItemChange(channel);
                  } else {
                    child = (snapshot.data)?.newWidget() ??
                        notFoundPage?.call(context) ??
                        _defaultNotFoundScreen(context);
                  }
                  break;
                //FragmentManager add, replace,...
                case ConnectionState.active:
                  child = (snapshot.data as PluginScreen).newWidget();
                  break;
                default:
                  child = Container();
              }
            }
            return WillPopScope(
              onWillPop: onWillPop ??
                  () async {
                    return !FragmentManager.instance.back(channel: channel);
                  },
              child: widgetBuilder?.call(context, child) ?? child,
            );
          },
        ) {
    if (initial != null) {
      final notExistFragment =
          FragmentManager.instance.isEmptyChannel(channel: channel);
      if (notExistFragment) {
        FragmentManager.instance
            .add(channel: channel, screen: initial, notifyChange: false);
      } else {
        FragmentManager.instance._fragmentSubject
            .add(_Fragment(channel, initial, notifyChange: false));
      }
    }
  }

  static Widget _defaultNotFoundScreen(BuildContext context) {
    final localizations = CoreLocalizations.of(context);
    return Center(
      child: Text(
        localizations?.notFoundPageInStreamChannel ?? '',
      ),
    );
  }

  static Widget _defaultEmptyChannel(BuildContext context) {
    final localizations = CoreLocalizations.of(context);
    return Center(
      child: Text(
        localizations?.emptyStreamChannel ?? '',
      ),
    );
  }
}
