import 'package:flutter/material.dart';
import '../map.dart';

import '../models/balade.dart';

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
        child: const Text(
          "Débuter la balade",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      )
    ],
  );
}
