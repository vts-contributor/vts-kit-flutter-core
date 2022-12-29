import 'package:flutter_core/models/models.dart';

class ViewPort {
  final CoreLatLng? northeast;
  final CoreLatLng? southwest;

  ViewPort({this.northeast, this.southwest});

  factory ViewPort.fromJson(Map<String, dynamic>? json) {
    final CoreLatLng? northeast =
        CoreLatLng.fromMapsAPIJson(json?['northeast']);
    final CoreLatLng? southwest =
        CoreLatLng.fromMapsAPIJson(json?['southwest']);
    return ViewPort(northeast: northeast, southwest: southwest);
  }
}
