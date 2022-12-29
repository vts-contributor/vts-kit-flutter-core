import 'package:flutter_core/models/maps_api/maps_api.dart';
import 'package:flutter_core/network/custom_cancel_token.dart';
import 'package:flutter_core/network/maps_api/maps_api.dart';

abstract class MapsAPIService extends MapsAPIAbstractService {
  Future<List<GeocodingPlace>> geocode({
    double? lat,
    double? lng,
    String? placeId,
    String? address,
    String? bounds,
    Map<String, String>? paramsKeyMapper,
    CustomCancelToken? cancelToken,
  });

  Future<DetailPlace> placeDetail({
    String? placeId,
    List<String>? fields,
    Map<String, String>? paramsKeyMapper,
    CustomCancelToken? cancelToken,
  });

  Future<PlaceList<AutocompletePlace>> autocomplete({
    String? input,
    String? origin,
    String? location,
    String? radius,
    Map<String, String>? paramsKeyMapper,
    CustomCancelToken? cancelToken,
  });


  Future<PlaceList<NearbyPlace>> nearbySearch({
    String? keyword,
    double? lat,
    double? lng,
    int? radius,
    String? rankBy,
    Map<String, String>? paramsKeyMapper,
    CustomCancelToken? cancelToken,
  });

  Future<Directions> direction({
    required double originLat,
    required double originLng,
    required double destLat,
    required double destLng,
    bool alternatives = false,
    Map<String, String>? paramsKeyMapper,
    int? routePointsSkipStep,
    CustomCancelToken? cancelToken,
  });
}
