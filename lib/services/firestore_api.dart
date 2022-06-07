import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_site_web/models/balade.dart';

class FirestoreApi {
  static var db = FirebaseFirestore.instance;

  Future<List<Balade>> getBalade() async {
    /*
    Balade balade1 = await db
        .collection('balades')
        .doc('balade1')
        .get()
        .then((snapshot) => Balade.fromMap(snapshot.data()!));
    Balade balade2 = await db
        .collection('balades')
        .doc('balade2')
        .get()
        .then((snapshot) => Balade.fromMap(snapshot.data()!));*/

    return await db
        .collection('balades')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Balade.fromMap(doc.data())).toList())
        .first;
  }
}
