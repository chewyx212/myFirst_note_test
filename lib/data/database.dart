import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_exam/note.dart';

class Database {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Stream<List<Note>> noteStream() {
    return _db
        .collection("notes")
        .where("user", isEqualTo: user!.email)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Note> retVal = [];
      query.docs.forEach((element) {
        retVal.add(Note.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }
}
