import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart';
import 'package:provider/provider.dart';
import 'package:test_site_web/models/waypoint.dart';
import 'package:test_site_web/providers/directionsDisplay_provider.dart';

class GoogleMapWidget extends StatelessWidget {
  const GoogleMapWidget({Key? key, this.wayPoints}) : super(key: key);
  final List<Waypoint>? wayPoints;
  @override
  Widget build(BuildContext context) {
    String htmlId = "7";
    DirectionsRenderer directionsDisplay =
        Provider.of<DirectionsDisplayProvider>(context).directionsDisplay;

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      final myLatlng = LatLng(1.3521, 103.8198);

      final mapOptions = MapOptions()
        ..zoom = 10
        ..center = LatLng(48.58880900972407, 3.6430982692609986);

      final elem = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = 'none';

      final map = GMap(elem, mapOptions);

      directionsDisplay.map = map;

      Marker(MarkerOptions()
        ..position = myLatlng
        ..map = map
        ..title = 'Hello World!');

      return elem;
    });

    if (wayPoints != null) {
      Provider.of<DirectionsDisplayProvider>(context).calcRoute(wayPoints!);
    } else {}

    return HtmlElementView(viewType: htmlId);
  }
}
