import 'package:flutter/material.dart';
import 'package:flutter_core/plugins/argument.dart';
import 'package:flutter_core/plugins/configuration.dart';
import 'package:flutter_core/plugins/screen.dart';

abstract class Plugin<T extends PluginArgument> {
  abstract final String name;
  abstract final Map<String, WidgetBuilder> routes;
  abstract final List<LocalizationsDelegate> localizationsDelegate;
  final PluginConfiguration config;
  final T argument;

  Plugin(this.config, this.argument);

  PluginScreen firstScreen({dynamic args});

  PluginScreen createScreen(String screenCode, {dynamic args});

  @protected
  Widget notFoundPage() {
    return Scaffold(
      body: Center(
        child: Text('Not found screen'),
      ),
    );
  }
}
