import 'package:flutter_core/models/models.dart';
import 'package:flutter_core/extensions/extensions.dart';

class Route {
  final ViewPort? bounds;
  final String? copyrights;
  final List<CoreLatLng>? points;
  final String? summary;
  final List<String>? warning;
  final List<String>? waypointOrder;

  List<CoreLatLng>? shortenedPoints(int step) {
    return points?.whereIndexed((point, i) => i % step == 0).toList();
  }

  Route({
    this.bounds,
    this.copyrights,
    this.points,
    this.summary,
    this.warning,
    this.waypointOrder,
  });

  factory Route.fromJson(Map<String, dynamic>? json, {int? pointsSkipStep}) {
    final ViewPort? bounds = ViewPort.fromJson(json?['bounds']);
    final String? copyrights = json?['copyrights'];
    final String? encodedPoints = json?['overview_polyline']?['points'];
    final List<CoreLatLng>? points = _decodePolyline(encodedPoints ?? '', skipStep: pointsSkipStep);
    final String? summary = json?['summary'];
    return Route(
      bounds: bounds,
      copyrights: copyrights,
      points: points,
      summary: summary,
    );
  }

  static List<CoreLatLng> _decodePolyline(String encoded, {int? skipStep}) {
    final poly = encoded;
    int len = poly.length;
    int index = 0;
    List<CoreLatLng> decoded = [];
    int lat = 0;
    int lng = 0;
    int i=0;
    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;
      do {
        b = (poly[index++]).codeUnitAt(0) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dLat = ((result & 1) != 0
          ? (result >> 1).toReversed8Bit().toSignedInt()
          : (result >> 1));
      lat += dLat;
      shift = 0;
      result = 0;
      do {
        b = (poly[index++]).codeUnitAt(0) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dLng = ((result & 1) != 0
          ? (result >> 1).toReversed8Bit().toSignedInt()
          : (result >> 1));
      lng += dLng;
      if (skipStep == null || skipStep <= 1 || i % skipStep == 0) {
        decoded.add(new CoreLatLng(lat / 100000.0, lng / 100000.0));
      }
      i++;
    }
    return decoded;
  }
}
