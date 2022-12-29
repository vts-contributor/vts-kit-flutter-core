import 'package:flutter_core/extensions/extension_functions.dart';
import 'package:flutter_core/models/maps_api/maps_api.dart';

class AutocompletePlace extends Place {
  final String? description;
  final StructuredFormatting? structuredFormatting;
  final List<Term>? terms;
  final List<String>? types;

  AutocompletePlace(
    String placeId, {
    this.description,
    this.structuredFormatting,
    this.terms,
    this.types,
  }) : super(placeId);

  factory AutocompletePlace.fromJson(Map<String, dynamic> json) {
    final String id = json['place_id'] ?? '';
    final String? description = json['description'];
    final StructuredFormatting? structuredFormatting =
        StructuredFormatting.fromJson(json['structured_formatting']);
    final List<Term>? terms = (json['terms'] as List?)?.map((e) {
      final json = e as Map<String, dynamic>;
      return Term.fromJson(json);
    }).toList();
    final List<String>? types = (json['types'] as List?)?.asListOf<String>();
    return AutocompletePlace(
      id,
      description: description,
      structuredFormatting: structuredFormatting,
      terms: terms,
      types: types,
    );
  }
}
