class StructuredFormatting {
  final String? mainText;
  final String? secondaryText;

  StructuredFormatting({
    this.mainText,
    this.secondaryText,
  });

  factory StructuredFormatting.fromJson(Map<String, dynamic>? json) {
    final mainText = json?['main_text'];
    final secondaryText = json?['secondary_text'];
    return StructuredFormatting(
      mainText: mainText,
      secondaryText: secondaryText,
    );
  }
}
