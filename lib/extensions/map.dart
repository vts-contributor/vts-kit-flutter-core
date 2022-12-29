extension MapX on Map<String, String>? {
  String valueOrKey(String key) => this?[key] ?? key;
}