import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_exam/data/database.dart';
import 'package:map_exam/note.dart';

class EditScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => EditScreen());

  EditScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  dynamic argumentData = Get.arguments;
  String mode = 'View';

  void initState() {
    mode = argumentData[0]['mode'];
    if (argumentData[1]['data'] != null) {
      Note data = argumentData[1]['data'];
      _titleController.text = data.title;
      _descriptionController.text = data.content;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> addNote() async {
      await Database().addNote(
          title: _titleController.text.trim(),
          content: _descriptionController.text.trim());
      Get.back();
    }

    Future<void> editNote() async {}

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: Text("${mode} Note"),
        actions: [
          mode == 'View'
              ? const SizedBox()
              : IconButton(
                  icon: const Icon(
                    Icons.check_circle,
                    size: 30,
                  ),
                  onPressed: () {
                    if (mode == 'Add') {
                      addNote();
                    }
                    if (mode == 'Edit') {
                      editNote();
                    }
                  },
                ),
          IconButton(
              icon: const Icon(
                Icons.cancel_sharp,
                size: 30,
              ),
              onPressed: () {
                Get.back();
              }),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              initialValue: null,
              enabled: true,
              decoration: const InputDecoration(
                hintText: 'Type the title here',
              ),
              readOnly: mode == 'View',
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: TextFormField(
                controller: _descriptionController,
                enabled: true,
                initialValue: null,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  hintText: 'Type the description',
                ),
                readOnly: mode == 'View',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
