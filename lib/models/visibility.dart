import 'package:flutter_core/models/abstract.dart';

class WidgetVisibility extends AbstractModel{
  final Map<String, dynamic> _map;

  WidgetVisibility(this._map);

  static WidgetVisibility fromJson(Map<String, dynamic>? json,
      {String rootKey: 'controls'}) {
    var map = json?[rootKey] as Map<String, dynamic>;
    return WidgetVisibility(map);
  }

  bool isVisible(String route, String key, {defaultValue = true}) {
    return _map['$route/$key'] ?? defaultValue;
  }
}
