import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_exam/data/database.dart';
import 'package:get/get.dart';
import 'package:map_exam/note.dart';

class NoteController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<bool> _hideContent = Rx<bool>(false);
  Rx<String> _selected = Rx<String>('');
  Rx<List<Note>> _notes = Rx<List<Note>>([]);

  List<Note> get notes => _notes.value;
  bool get hideContent => _hideContent.value;
  String get selected => _selected.value;

  void toggleHideContent() {
    _hideContent.value = !_hideContent.value;
  }

  void toggleEdit(String id) {
    if (_selected.value == id) {
      _selected.value = '';
    } else {
      _selected.value = id;
    }
  }

  void startStream(String email) {
    _notes.bindStream(Database().noteStream());
  }

  void closeStream() {
    _notes = Rx<List<Note>>([]);
  }

  @override
  void onInit() {
    _notes.bindStream(Database().noteStream());
    super.onInit();
  }
}
