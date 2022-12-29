export 'plugin.dart';
export 'argument.dart';
export 'configuration.dart';
export 'fragment_manager.dart';
export 'route_translator.dart';
export 'screen.dart';
export 'core.dart';
import 'plugin.dart';

import 'package:flutter/material.dart';

class PluginMap {
  final Map<String, Plugin> _pluginMap = {};

  void add(final String name, final Plugin plugin) {
    if (_pluginMap.containsKey(name)) {
      throw Exception('Can not add exist plugin: $name, $plugin');
    }
    _pluginMap[name] = plugin;
  }

  void remove(final String name) {
    if (_pluginMap.containsKey(name)) {
      _pluginMap.remove(name);
    }
  }

  Plugin? get(final String name) {
    return _pluginMap[name];
  }

  Map<String, WidgetBuilder> get pluginRoutes {
    if (_pluginMap.isEmpty || _pluginMap.values.isEmpty) {
      return {};
    }
    return _pluginMap.values
        .map((plugin) => plugin.routes)
        .reduce((value, element) => value..addAll(element));
  }

  List<LocalizationsDelegate> get pluginLocalizationDelegates {
    if (_pluginMap.isEmpty || _pluginMap.values.isEmpty) {
      return [];
    }
    return _pluginMap.values
        .map((plugin) => plugin.localizationsDelegate)
        .reduce((value, element) => value..addAll(element));
  }
}
