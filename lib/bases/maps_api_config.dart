class MapAPIConfig {
  final String placeHost;
  final String routeHost;
  final String geocodePath;
  final String placeDetailPath;
  final String autocompleteSearchPath;
  final String nearbySearchPath;
  final String directionPath;
  String? key;

  String hostOf(String path) {
    if (path == directionPath) {
      return routeHost;
    } else {
      return placeHost;
    }
  }

  MapAPIConfig({
    this.placeHost =
        'https://api-maps.viettel.vn/gateway/placeapi/v2/place-api',
    this.routeHost = 'https://api-maps.viettel.vn/gateway/routing/v2',
    this.key,
    this.geocodePath = 'geocode',
    this.placeDetailPath = 'details',
    this.autocompleteSearchPath = 'autocomplete',
    this.nearbySearchPath = 'nearbysearch',
    this.directionPath = 'directions',
  });
}
