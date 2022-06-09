import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:google_maps/google_maps.dart';

import 'firebase_file.dart';
import 'waypoint.dart';

class Balade {
  String name;
  String description;
  String distance;
  String duration;
  List<Waypoint>? wayPointsLst;
  Balade({
    this.name = '',
    this.description = '',
    this.distance = '',
    this.duration = '',
    this.wayPointsLst,
  });

  Balade copyWith({
    String? name,
    String? description,
    String? distance,
    String? duration,
    List<Waypoint>? wayPointsLst,
  }) {
    return Balade(
      name: name ?? this.name,
      description: description ?? this.description,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      wayPointsLst: wayPointsLst ?? this.wayPointsLst,
    );
  }
/*
factory User.fromJson(Map<String, dynamic> map) {
    print('json recup $map');
    List<ContactModel> contacts = [];
    if (map['contacts'] != null) {
      var lst = map['contacts'] as List;
      contacts = lst.map((i) => ContactModel.fromMap(i)).toList();
    }
    DateTime? dateTime;
    if (map['date'] != "" || map['date'] == null) {
      dateTime = DateTime.parse(map['date']);
    } else {
      dateTime = null;
    }
    return User(
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        role: map['role'],
        uid: map['uid'],
        phone: map['phone'],
        date: dateTime,
        contacts: contacts);
  }
*/

  factory Balade.fromMap(Map<String, dynamic> map) {
    print('json recup $map');
    List<Waypoint> wp = [];
    if (map['wayPoints'] != null) {
      var lst = map['wayPoints'] as List;
      wp = lst.map((i) => Waypoint.fromMap(i)).toList();
    }
    return Balade(
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        distance: map['distance'] ?? '',
        duration: map['duration'] ?? '',
        wayPointsLst: wp);
  }

  factory Balade.fromJson(String source) => Balade.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Balade(name: $name, description: $description, distance: $distance, duration: $duration, wayPointsLst: $wayPointsLst)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Balade &&
        other.name == name &&
        other.description == description &&
        other.distance == distance &&
        other.duration == duration &&
        listEquals(other.wayPointsLst, wayPointsLst);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        distance.hashCode ^
        duration.hashCode ^
        wayPointsLst.hashCode;
  }

  static void addWayPointImagesToBalade(
      Balade balade, List<FirebaseFile> firebaseFile) {
    List<Waypoint> wplst = [];
    for (int i = 0; i < balade.wayPointsLst!.length; i++) {
      wplst.add(Waypoint(
          coordinates: LatLng(balade.wayPointsLst![i].coordinates.lat,
              balade.wayPointsLst![i].coordinates.lng),
          description: balade.wayPointsLst![i].description,
          title: balade.wayPointsLst![i].title,
          firebaseFile: firebaseFile[i]));
    }
    balade.wayPointsLst = wplst;
  }
}
