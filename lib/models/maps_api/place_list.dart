import 'package:flutter_core/models/maps_api/maps_api.dart';

class PlaceList<T extends Place> {
  final List<T> values;
  final String? nextPageToken;

  PlaceList({
    required this.values,
    this.nextPageToken,
  });

  factory PlaceList.fromResponse(
      PlaceListingResponse response, T map(Map<String, dynamic> json)) {
    final result = response.list?.map((json) => map(json)).toList() ?? [];
    return PlaceList(
      values: result,
      nextPageToken: response.nextPageToken,
    );
  }
}
