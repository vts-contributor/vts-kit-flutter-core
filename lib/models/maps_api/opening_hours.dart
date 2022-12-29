class OpeningHours {
  final bool openingNow;

  OpeningHours({
    this.openingNow = false,
  });

  factory OpeningHours.fromJson(Map<String, dynamic>? json) {
    final bool? openingNow = json?['opening_now'];
    return OpeningHours(openingNow: openingNow ?? false);
  }
}
