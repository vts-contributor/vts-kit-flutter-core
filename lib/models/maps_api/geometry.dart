import 'package:flutter_core/models/lat_lng.dart';
import 'package:flutter_core/models/maps_api/maps_api.dart';

class Geometry {
  final CoreLatLng? location;
  final String? locationType;
  final ViewPort? viewPort;

  Geometry({
    this.location,
    this.locationType,
    this.viewPort,
  });

  factory Geometry.fromJson(Map<String, dynamic>? json) {
    final CoreLatLng? location = CoreLatLng.fromMapsAPIJson(json?['location']);
    final String? locationType = json?['location_type'];
    final ViewPort? viewPort = ViewPort.fromJson(json?['viewport']);
    return Geometry(
      location: location,
      locationType: locationType,
      viewPort: viewPort,
    );
  }
}
