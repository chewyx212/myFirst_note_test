import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final dynamic id;
  String title;
  String content;

  Note({this.id = 0, this.title = '', this.content = ''});

  Note.fromJson(Map<String, dynamic> json)
      : this(id: json['id'], title: json['title'], content: json['content']);

  Note.fromDocumentSnapshot(DocumentSnapshot documentSnapshot)
      : this(
            id: documentSnapshot.id,
            title: documentSnapshot['title'],
            content: documentSnapshot['content']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'content': content};
}
