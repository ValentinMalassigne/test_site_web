import 'dart:convert';

import 'package:google_maps/google_maps.dart';

class Waypoint {
  LatLng coordinates;
  String description;
  String title;
  Waypoint({
    required this.coordinates,
    required this.description,
    required this.title,
  });

  Waypoint copyWith({
    LatLng? coordinates,
    String? description,
    String? title,
  }) {
    return Waypoint(
      coordinates: coordinates ?? this.coordinates,
      description: description ?? this.description,
      title: title ?? this.title,
    );
  }

  factory Waypoint.fromMap(Map<String, dynamic> map) {
    return Waypoint(
      coordinates:
          LatLng(map['coordinates'].latitude, map['coordinates'].longitude),
      description: map['description'] ?? '',
      title: map['title'] ?? '',
    );
  }

  factory Waypoint.fromJson(String source) =>
      Waypoint.fromMap(json.decode(source));

  @override
  String toString() =>
      'Waypoint(coordinates: $coordinates, description: $description, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Waypoint &&
        other.coordinates == coordinates &&
        other.description == description &&
        other.title == title;
  }

  @override
  int get hashCode =>
      coordinates.hashCode ^ description.hashCode ^ title.hashCode;
}
