import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_core/bases/bases.dart';
import 'package:flutter_core/models/maps_api/response/response.dart';

abstract class MapsAPIResponseParser {
  @protected
  MapsAPIResponseParser? next;

  bool assertSuccessOrThrowException(Response response) {
    final Map<String, dynamic> bodyJson = response.data;
    if (bodyJson.containsKey('status')) {
      final status = bodyJson['status'];
      if (status != MapsAPIResponseStatus.kOk &&
          status != MapsAPIResponseStatus.kZeroResults) {
        final errorMessage = bodyJson['error_message'];
        throw ImplicitServerResponseError(
          rootCause: Exception('status: $status, message: $errorMessage'),
        );
      }
    }
    return true;
  }

  MapsAPIResponse parse(Response response);

  @protected
  MapsAPIResponse nextParse(Response response) {
    return next?.parse(response) ??
        (throw ImplicitServerResponseError(
          rootCause: Exception(
              'All Map response parsers can not parse this $response'),
        ));
  }

  static MapsAPIResponseParser link(List<MapsAPIResponseParser> chain) {
    if (chain.isEmpty) {
      return MapsAPIDefaultParser();
    }
    MapsAPIResponseParser? head;
    for (var nextInChain in chain) {
      if (head != null) {
        head.next = nextInChain;
        head = nextInChain;
      } else {
        head = nextInChain;
      }
    }
    return chain.first;
  }
}

class MapsAPIDefaultParser extends MapsAPIResponseParser {
  @override
  MapsAPIResponse parse(Response response) {
    return MapsAPIResponse();
  }
}

class MapsAPIGeocodingParser extends MapsAPIResponseParser {
  @override
  MapsAPIResponse parse(Response response) {
    assertSuccessOrThrowException(response);
    final Map<String, dynamic> bodyJson = response.data;
    final String? status;
    if (bodyJson.containsKey('status')) {
      status = bodyJson['status'];
    } else {
      status = null;
    }
    if (bodyJson.containsKey('results')) {
      return PlaceListingResponse(
        list: bodyJson['results'],
        errorCode: response.statusCode,
        status: status,
        nextPageToken: bodyJson['next_page_token'],
      );
    }
    return nextParse(response);
  }
}

class MapsAPIPlaceDetailParser extends MapsAPIResponseParser {
  @override
  MapsAPIResponse parse(Response response) {
    assertSuccessOrThrowException(response);
    final Map<String, dynamic> bodyJson = response.data;
    final String? status;
    if (bodyJson.containsKey('status')) {
      status = bodyJson['status'];
    } else {
      status = null;
    }
    if (bodyJson.containsKey('result')) {
      return PlaceResponse(
        content: bodyJson['result'],
        errorCode: response.statusCode,
        status: status,
      );
    }
    return nextParse(response);
  }
}

class MapsAPIAutocompleteSearchParser extends MapsAPIResponseParser {
  @override
  MapsAPIResponse parse(Response response) {
    assertSuccessOrThrowException(response);
    final Map<String, dynamic> bodyJson = response.data;
    final String? status;
    if (bodyJson.containsKey('status')) {
      status = bodyJson['status'];
    } else {
      status = null;
    }
    if (bodyJson.containsKey('predictions')) {
      return PlaceListingResponse(
        list: bodyJson['predictions'],
        errorCode: response.statusCode,
        status: status,
      );
    }
    return nextParse(response);
  }
}

class MapsAPIDirectionsParser extends MapsAPIResponseParser {
  @override
  MapsAPIResponse parse(Response response) {
    final Map<String, dynamic> bodyJson = response.data;
    final String? status;
    if (bodyJson.containsKey('status')) {
      status = bodyJson['status'];
    } else {
      status = null;
    }
    if (bodyJson.containsKey('routes')) {
      return PlaceResponse(
        content: bodyJson,
        errorCode: response.statusCode,
        status: status,
      );
    }
    return nextParse(response);
  }
}
