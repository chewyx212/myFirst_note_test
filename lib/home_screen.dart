import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_exam/controller/noteController.dart';
import 'package:get/get.dart';
import 'package:map_exam/note.dart';

class HomeScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const HomeScreen());
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    NoteController noteControl = Get.find<NoteController>();

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () async {
              noteControl.closeStream();
              await FirebaseAuth.instance.signOut();
            },
            child: const Text('My Notes')),
        actions: [
          GetX<NoteController>(
              init: NoteController(),
              builder: (NoteController noteController) {
                return CircleAvatar(
                  backgroundColor: Colors.blue.shade200,
                  child: Text(
                    noteControl.notes.length.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                  ),
                );
              }),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: GetX<NoteController>(
        init: NoteController(),
        builder: (NoteController noteController) {
          if (noteController != null && noteController.notes != null) {
            return ListView.separated(
              itemCount: noteController.notes.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.blueGrey,
              ),
              itemBuilder: (context, index) => NoteTile(index: index),
            );
          } else {
            return Text("loading...");
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GetX<NoteController>(
              init:
                  NoteController(), // use it only first time on each controller
              builder: (_) {
                return FloatingActionButton(
                  child: _.hideContent
                      ? Icon(Icons.menu)
                      : Icon(Icons.compare_arrows),
                  tooltip: 'Show less. Hide notes content',
                  onPressed: () {
                    _.toggleHideContent();
                  },
                );
              }),
          /* Notes: for the "Show More" icon use: Icons.menu */

          FloatingActionButton(
            child: const Icon(Icons.add),
            tooltip: 'Add a new note',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class NoteTile extends StatelessWidget {
  const NoteTile({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    return GetX<NoteController>(
      init: NoteController(),
      builder: (noteController) {
        Note data = noteController.notes[index];
        return ListTile(
          trailing: noteController.selected == data.id
              ? SizedBox(
                  width: 110.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.blue,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              : null,
          title: Text(data.title),
          subtitle: noteController.hideContent ? null : Text(data.content),
          onTap: () {},
          onLongPress: () {
            noteController.toggleEdit(data.id);
          },
        );
      },
    );
  }
}
