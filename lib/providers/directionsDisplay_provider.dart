import 'package:flutter/cupertino.dart';
import 'package:google_maps/google_maps.dart';

import '../models/waypoint.dart';

class DirectionsDisplayProvider extends ChangeNotifier {
  DirectionsRenderer directionsDisplay = DirectionsRenderer();
  DirectionsDisplayProvider({
    required this.directionsDisplay,
  });

  void updateDirections(List<Waypoint> wayPoints) {
    calcRoute(wayPoints);
    notifyListeners();
  }

  void calcRoute(List<Waypoint> wayPoints) {
    final directionsService = DirectionsService();
    final start = wayPoints.first.coordinates;
    final end = wayPoints.last.coordinates;
    final waypts = <DirectionsWaypoint>[];
    for (int i = 1; i < wayPoints.length - 1; i++) {
      waypts.add(DirectionsWaypoint()
        ..location = wayPoints[i].coordinates
        ..stopover = true);
    }

    final request = DirectionsRequest()
      ..origin = start
      ..waypoints = waypts
      ..destination = end
      ..travelMode = TravelMode.BICYCLING;
    directionsService.route(request, (response, status) {
      if (status == DirectionsStatus.OK) {
        directionsDisplay.directions = response;
      }
    });
  }
}
