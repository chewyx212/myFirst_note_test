import 'package:map_exam/data/database.dart';
import 'package:get/get.dart';
import 'package:map_exam/note.dart';

class NoteController extends GetxController {
  Rx<List<Note>> _notes = Rx<List<Note>>([]);

  List<Note> get notes => _notes.value;

  @override
  void onInit() {
    
    _notes.bindStream(Database().noteStream()); //stream coming from firebase
  }
}


