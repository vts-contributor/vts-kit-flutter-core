import 'package:flutter/material.dart';

class PluginScreen<T extends Widget> {
  final String route;
  final dynamic args;
  T Function(dynamic args) lazyCreate;

  PluginScreen(this.route, this.args, this.lazyCreate);

  T newWidget() => lazyCreate.call(args);
}
