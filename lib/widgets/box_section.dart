import 'package:flutter/material.dart';
import '../models/waypoint.dart';

import '../models/balade.dart';

Widget boxListSection(
  int index,
  double marginRight,
  double marginLeft,
  Waypoint? waypoint,
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
          image: boxListSelectionBackGroundImage(waypoint!.firebaseFile!.url),
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
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: Colors.grey.withOpacity(0.4),
            onTap: () {
              //onBtnClick();
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                index == 0
                    ? Positioned(
                        top: 10,
                        right: 15,
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 236, 219, 62),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.timeline,
                                size: 25.0,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(balade.distance.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
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
        child: Text(
          waypoint.description,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      )
    ],
  );
}

DecorationImage? boxListSelectionBackGroundImage(String url) {
  return DecorationImage(
    alignment: Alignment.topCenter,
    fit: BoxFit.fitWidth,
    image: NetworkImage(url),
  );
}
