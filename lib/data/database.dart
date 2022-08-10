import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_exam/note.dart';

class Database {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User? _user = FirebaseAuth.instance.currentUser;

  Stream<List<Note>> noteStream() {
    return _db
        .collection("notes")
        .where("user", isEqualTo: _user?.email ?? 'null')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Note> retVal = [];
      query.docs.forEach((element) {
        retVal.add(Note.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Future<void> deleteNote(String noteId) async {
    try {
      _db.collection("notes").doc(noteId).delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
