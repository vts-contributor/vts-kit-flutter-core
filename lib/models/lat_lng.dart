import 'package:google_maps_flutter/google_maps_flutter.dart' as Google;
// import 'package:vtmap_gl/vtmap_gl.dart' as Viettel;

class CoreLatLng {
  late final double lat;
  late final double lng;
  late final bool isValid;
  int? _receiveTimestamp;
  final bool isDefault;

  int? get receiveTimestamp => _receiveTimestamp;

  /// The [lat] from -90.0 to +90.0.
  ///
  /// The [lng] from -180.0 to +180.0.
  CoreLatLng(double lat, double lng,
      {bool receiveNow: false, this.isDefault: false}) {
    if (-90 > lat || lat > 90 || -180 > lng || lng > 180) {
      isValid = false;
      this.lat = 0.0;
      this.lng = 0.0;
    } else {
      isValid = true;
      this.lat = lat;
      this.lng = lng;
    }
    if (receiveNow) {
      _receiveTimestamp = DateTime.now().millisecondsSinceEpoch;
    }
  }

  Google.LatLng toGoogleLatLng() {
    return Google.LatLng(this.lat, this.lng);
  }

  // Viettel.LatLng toViettelLatLng() {
  //   return Viettel.LatLng(this.lat, this.lng);
  // }

  /// The [latLngMap] structured {lat: ..., lng: ...}
  ///
  /// The [lat] from -90.0 to +90.0.
  ///
  /// The [lng] from -180.0 to +180.0.
  factory CoreLatLng.fromMap(Map latLngMap, {bool receiveNow: false}) {
    try {
      return CoreLatLng(latLngMap['lat'], latLngMap['lng'], receiveNow: receiveNow);
    } catch (err) {
      print('Parse CoreLatLng from Map $latLngMap failed because $err');
      return CoreLatLng.defaultInvalid();
    }
  }

  factory CoreLatLng.defaultInvalid() {
    //constructor will set lat=0.0, lng=0.0
    return CoreLatLng(-91, -181);
  }

  factory CoreLatLng.fromGoogleLatLng(Google.LatLng latLng,
      {bool receiveNow: false}) =>
      CoreLatLng(latLng.latitude, latLng.longitude, receiveNow: receiveNow);

  // factory CoreLatLng.fromViettelLatLng(Viettel.LatLng latLng,
  //     {bool receiveNow: false}) =>
  //     CoreLatLng(latLng.latitude, latLng.longitude, receiveNow: receiveNow);

  static CoreLatLng? fromMapsAPIJson(Map<String, dynamic>? json) {
    final double? lat = json?['lat'];
    final double? lng = json?['lng'];
    if (lat != null && lng != null) {
      return CoreLatLng(lat, lng);
    }
    return null;
  }

  @override
  String toString() => '{lat:$lat, lng:$lng}';
}
