
import 'package:flutter_core/models/maps_api/response/response.dart';

class PlaceResponse extends MapsAPIResponse {
  final String? status;

  PlaceResponse({
    Map<String, dynamic>? content,
    String? message,
    int? errorCode,
    this.status,
  }) : super(
          content: content,
          message: message,
          errorCode: errorCode,
        );
}
