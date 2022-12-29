import 'package:flutter_core/extensions/extensions.dart';
import 'package:flutter_core/models/maps_api/maps_api.dart';

class NearbyPlace extends Place {
  final String? adrAddress;
  final String? formattedAddress;
  final Geometry? geometry;
  final String? icon;
  final String? name;
  final OpeningHours? openingHours;
  final PlusCode? plusCode;
  final int? priceLevel;
  final double? rating;
  final List<String>? types;
  final int? userRatingTotal;
  final String? vicinity;

  NearbyPlace(String id, {
    this.adrAddress,
    this.formattedAddress,
    this.geometry,
    this.icon,
    this.name,
    this.openingHours,
    this.plusCode,
    this.priceLevel,
    this.rating,
    this.types,
    this.userRatingTotal,
    this.vicinity,
  }) : super(id);

  factory NearbyPlace.fromJson(Map<String, dynamic> json) {
    final String id = json['place_id'] ?? '';
    final String? adrAddress = json['adr_address'];
    final String? formattedAddress = json['formatted_address'];
    final Geometry? geometry = Geometry.fromJson(json['geometry']);
    final String? icon = json['icon'];
    final String? name = json['name'];
    final OpeningHours? openingHours =
    OpeningHours.fromJson(json['opening_hours']);
    final PlusCode? plusCode = PlusCode.fromJson(json['plus_code']);
    final int? priceLevel = json['price_level'];
    final double? rating = json['rating'];
    final List<String>? types = (json['types'] as List?)?.asListOf<String>();
    final int? userRatingTotal = json['user_rating_total'];
    final String? vicinity = json['vicinity'];
    return NearbyPlace(id, adrAddress: adrAddress,
      formattedAddress: formattedAddress,
      geometry: geometry,
      icon: icon,
      name: name,
      openingHours: openingHours,
      plusCode: plusCode,
      priceLevel: priceLevel,
      rating: rating,
      types: types,
      userRatingTotal: userRatingTotal,
      vicinity: vicinity,
    );
  }
}
