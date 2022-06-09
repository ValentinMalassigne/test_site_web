import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart';
import '../map.dart';
import 'dart:html' as html;
import '../models/balade.dart';
import '../models/waypoint.dart';

Widget mapSection(
  double marginRight,
  double marginLeft,
  Balade balade,
  //void Function() onBtnClick,
) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(right: marginRight, left: marginLeft),
        width: 320,
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(255, 185, 185, 185), width: 1.0),
          color: const Color.fromARGB(255, 245, 245, 245),
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(2, 5))
          ],
        ),
        child: GoogleMapWidget(wayPoints: balade.wayPointsLst!),
      ),
      const SizedBox(height: 10),
      Container(
        margin: EdgeInsets.only(right: marginRight, left: marginLeft),
        width: 320,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(255, 185, 185, 185), width: 1.0),
          color: const Color.fromARGB(255, 245, 245, 245),
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(2, 5))
          ],
        ),
        child: ElevatedButton(
          onPressed: ((() => startGoogleMapNavigation(balade.wayPointsLst!))),
          child: const Text(
            "Débuter la balade",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      )
    ],
  );
}

startGoogleMapNavigation(List<Waypoint> wayPoints) async {
  String baseURL = "https://www.google.com/maps/dir/?api=1";
  String origin = "&origin=";
  String destination = "&destination=";
  String travelMode = "&travelmode=bicycling";
  String wayPointsString = "&waypoints=";
  print("Nombre de waypoints : " + wayPoints.length.toString());
  for (int i = 1; i < wayPoints.length - 1; i++) {
    wayPointsString += wayPoints[i].coordinates.lat.toString() +
        "%2C" +
        wayPoints[i].coordinates.lng.toString() +
        "%7C";
  }
  //on supprime le dernier %7C qui pose problème parfois
  wayPointsString = wayPointsString.substring(0, wayPointsString.length - 3);
  origin += wayPoints.first.coordinates.lat.toString() +
      "%2C" +
      wayPoints.first.coordinates.lng.toString();
  destination += wayPoints.last.coordinates.lat.toString() +
      "%2C" +
      wayPoints.last.coordinates.lng.toString();
  print(baseURL + origin + destination + travelMode + wayPointsString);
  html.window.open(
      baseURL + origin + destination + travelMode + wayPointsString, "_blank");
}
