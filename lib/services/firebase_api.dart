import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_site_web/models/balade.dart';

import '../models/firebase_file.dart';
import 'firestore_api.dart';

class FirebaseApi {
  static var db = FirebaseFirestore.instance;

  Future<List<Balade>> getBalade() async {
    //get Balades data from firebase
    List<Balade> baladesList = await db
        .collection('balades')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Balade.fromMap(doc.data())).toList())
        .first;

    //get images from firestore and add it to the balades
    List<FirebaseFile> firebaseFiles;
    for (int i = 0; i < baladesList.length; i++) {
      firebaseFiles =
          await FirestoreApi.listAll("balade" + (i + 1).toString() + "/");
      Balade.addWayPointImagesToBalade(baladesList[i], firebaseFiles);
    }

    return baladesList;
  }
}
