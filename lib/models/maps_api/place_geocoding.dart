import 'package:flutter_core/extensions/extensions.dart';
import 'package:flutter_core/models/maps_api/maps_api.dart';

class GeocodingPlace extends Place {
  final PlusCode? plusCode;
  final List<String>? types;
  final Geometry? geometry;
  final String? formattedAddress;
  final List<AddressComponent>? addressComponents;

  GeocodingPlace(
    String id, {
    this.plusCode,
    this.types,
    this.geometry,
    this.formattedAddress,
    this.addressComponents,
  }) : super(id);

  @override
  String toString() {
    return '$plusCode';
  }

  factory GeocodingPlace.fromJson(Map<String, dynamic> json) {
    final String id = json['place_id'] ?? '';
    final PlusCode? plusCode = PlusCode.fromJson(json['plusCode']);
    final List<String>? types = (json['types'] as List?)?.asListOf<String>();
    final Geometry? geometry = Geometry.fromJson(json['geometry']);
    final String? formattedAddress = json['formatted_address'];
    final List<AddressComponent>? addressComponents =
        (json['address_components'] as List?)?.map((e) {
      final json = e as Map<String, dynamic>;
      return AddressComponent.fromJson(json);
    }).toList();
    return GeocodingPlace(
      id,
      plusCode: plusCode,
      types: types,
      geometry: geometry,
      formattedAddress: formattedAddress,
      addressComponents: addressComponents,
    );
  }
}
