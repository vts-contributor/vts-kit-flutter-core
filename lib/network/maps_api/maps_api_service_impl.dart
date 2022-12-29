import 'package:flutter/foundation.dart';
import 'package:flutter_core/bases/bases.dart';
import 'package:flutter_core/extensions/map.dart';
import 'package:flutter_core/models/maps_api/maps_api.dart';
import 'package:flutter_core/network/custom_cancel_token.dart';
import 'package:flutter_core/network/maps_api/maps_api.dart';

class MapsAPIServiceImpl extends MapsAPIService {
  static MapsAPIAbstractService? _instance;

  @protected
  @override
  MapsAPIResponseParser jsonParser = MapsAPIResponseParser.link([
    MapsAPIGeocodingParser(),
    MapsAPIAutocompleteSearchParser(),
    MapsAPIPlaceDetailParser(),
    MapsAPIDirectionsParser(),
  ]);

  @protected
  @override
  late MapAPIConfig config;

  MapsAPIServiceImpl._();

  MapsAPIServiceImpl setConfig(MapAPIConfig config) {
    final currentKey = this.config.key;
    if (config.key == null && currentKey != null) {
      config.key = currentKey;
    }
    this.config = config;
    return this;
  }

  factory MapsAPIServiceImpl({String? key}) {
    if (_instance == null) {
      _instance = MapsAPIServiceImpl._();
      _instance?.config = MapAPIConfig();
    }
    if (key != null) {
      _instance?.config.key = key;
    }
    return _instance as MapsAPIServiceImpl;
  }

  @override
  Future<List<GeocodingPlace>> geocode({
    double? lat,
    double? lng,
    String? placeId,
    String? address,
    String? bounds,
    Map<String, String>? paramsKeyMapper,
    CustomCancelToken? cancelToken,
  }) async {
    final keyLatLng = paramsKeyMapper.valueOrKey(MapsAPIConst.kLatLng);
    final keyPlaceId = paramsKeyMapper.valueOrKey(MapsAPIConst.kPlaceId);
    final keyAddress = paramsKeyMapper.valueOrKey(MapsAPIConst.kAddress);
    final keyBounds = paramsKeyMapper.valueOrKey(MapsAPIConst.kBounds);
    final params = {
      keyLatLng: '$lat,$lng',
      keyPlaceId: placeId,
      keyAddress: address,
      keyBounds: bounds,
    };
    final response = await get<PlaceListingResponse>(
      config.geocodePath,
      params: params,
      cancelToken: cancelToken,
    );
    final result =
        response.list?.map((e) => GeocodingPlace.fromJson(e)).toList() ?? [];
    return result;
  }

  @override
  Future<DetailPlace> placeDetail({
    String? placeId,
    List<String>? fields,
    Map<String, String>? paramsKeyMapper,
    CustomCancelToken? cancelToken,
  }) async {
    final keyPlaceId = paramsKeyMapper.valueOrKey(MapsAPIConst.kPlaceId);
    final keyFields = paramsKeyMapper.valueOrKey(MapsAPIConst.kFields);
    final params = {
      keyPlaceId: placeId,
      keyFields: fields,
    };
    final response = await get<PlaceResponse>(
      config.placeDetailPath,
      params: params,
      cancelToken: cancelToken,
    );
    if (response.content is Map<String, dynamic>) {
      return DetailPlace.fromJson(response.content as Map<String, dynamic>);
    } else
      throw ImplicitServerResponseError(
        rootCause: Exception('API Maps details response content is null'),
      );
  }

  @override
  Future<PlaceList<AutocompletePlace>> autocomplete({
    String? input,
    String? origin,
    String? location,
    String? radius,
    Map<String, String>? paramsKeyMapper,
    CustomCancelToken? cancelToken,
  }) async {
    final keyInput = paramsKeyMapper.valueOrKey(MapsAPIConst.kInput);
    final keyOrigin = paramsKeyMapper.valueOrKey(MapsAPIConst.kOrigin);
    final keyLocation = paramsKeyMapper.valueOrKey(MapsAPIConst.kLocation);
    final keyRadius = paramsKeyMapper.valueOrKey(MapsAPIConst.kRadius);
    final params = {
      keyInput: input,
      keyOrigin: origin,
      keyLocation: location,
      keyRadius: radius,
    };
    final response = await get<PlaceListingResponse>(
      config.autocompleteSearchPath,
      params: params,
      cancelToken: cancelToken,
    );
    final result = PlaceList.fromResponse(
        response, (json) => AutocompletePlace.fromJson(json));
    return result;
  }

  @override
  Future<PlaceList<NearbyPlace>> nearbySearch({
    String? keyword,
    double? lat,
    double? lng,
    int? radius,
    String? rankBy,
    String? nextPageToken,
    Map<String, String>? paramsKeyMapper,
    CustomCancelToken? cancelToken,
  }) async {
    final keyKeyword = paramsKeyMapper.valueOrKey(MapsAPIConst.kKeyword);
    final keyLocation = paramsKeyMapper.valueOrKey(MapsAPIConst.kLocation);
    final keyRadius = paramsKeyMapper.valueOrKey(MapsAPIConst.kRadius);
    final keyRankBy = paramsKeyMapper.valueOrKey(MapsAPIConst.kRankBy);
    final keyNextPageToken =
        paramsKeyMapper.valueOrKey(MapsAPIConst.kNextPageToken);
    final params = {
      keyKeyword: keyword,
      keyLocation: '$lat,$lng',
      keyRadius: radius,
      keyRankBy: rankBy,
      keyNextPageToken: nextPageToken,
    };
    final response = await get<PlaceListingResponse>(
      config.nearbySearchPath,
      params: params,
      cancelToken: cancelToken,
    );
    final result = PlaceList.fromResponse(
      response,
      (json) => NearbyPlace.fromJson(json),
    );
    return result;
  }

  //[routePointsSkipStep]: skip every [routePointsSkipStep] route points if routes contains many points.
  @override
  Future<Directions> direction({
    required double originLat,
    required double originLng,
    required double destLat,
    required double destLng,
    bool alternatives = false,
    String? mode,
    Map<String, String>? paramsKeyMapper,
    int? routePointsSkipStep,
    CustomCancelToken? cancelToken,
  }) async {
    final keyOrigin = paramsKeyMapper.valueOrKey(MapsAPIConst.kOrigin);
    final keyDestination =
        paramsKeyMapper.valueOrKey(MapsAPIConst.kDestination);
    final keyAlternatives =
        paramsKeyMapper.valueOrKey(MapsAPIConst.kAlternatives);
    final keyMode = paramsKeyMapper.valueOrKey(MapsAPIConst.kMode);
    final params = {
      keyOrigin: '$originLat,$originLng',
      keyDestination: '$destLat,$destLng',
      keyAlternatives: alternatives,
      keyMode: mode
    };
    final response = await get<PlaceResponse>(
      config.directionPath,
      params: params,
      cancelToken: cancelToken,
    );
    if (response.content is Map<String, dynamic>) {
      final result = Directions.fromJson(
        response.content as Map<String, dynamic>,
        routePointsSkipStep: routePointsSkipStep,
      );
      return result;
    } else
      throw ImplicitServerResponseError(
        rootCause: Exception('API Maps directions response content is null'),
      );
  }
}
