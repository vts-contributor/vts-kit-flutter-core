import 'package:flutter_core/extensions/extension_functions.dart';


class AddressComponent {
  final List<String>? types;
  final String? longName;
  final String? shortName;
  final String? areaCode;

  AddressComponent({
    this.types,
    this.longName,
    this.shortName,
    this.areaCode,
  });


  factory AddressComponent.fromJson(Map<String, dynamic>? json) {
    final List? rawTypes = json?['types'] as List?;
    final List<String>? types = rawTypes?.asListOf<String>();
    final String? longName = json?['long_name'];
    final String? shortName = json?['short_name'];
    final String? areaCode = json?['area_code'];
    return AddressComponent(
        types: types,
        longName: longName,
        shortName: shortName,
        areaCode: areaCode);
  }
}
