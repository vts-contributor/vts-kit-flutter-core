import 'package:flutter_core/models/maps_api/maps_api.dart';

class Directions {
  final List<Place>? geocodedWaypoints;
  final List<Route>? routes;

  Directions({
    this.geocodedWaypoints,
    this.routes,
  });

  factory Directions.fromJson(Map<String, dynamic> json, {int? routePointsSkipStep}) {
    final List<GeocodingPlace>? geocodedWaypoints =
        (json['geocoded_waypoints'] as List<dynamic>?)
            ?.map((e) => GeocodingPlace.fromJson(e))
            .toList();
    final List<Route>? routes = (json['routes'] as List<dynamic>?)
        ?.map((e) => Route.fromJson(e, pointsSkipStep: routePointsSkipStep))
        .toList();
    return Directions(
      geocodedWaypoints: geocodedWaypoints,
      routes: routes,
    );
  }
}
