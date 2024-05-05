import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteReaderScreen extends StatefulWidget {
  final QueryDocumentSnapshot doc;

  NoteReaderScreen({required this.doc, Key? key}) : super(key: key);

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.doc['note_title']);
    _contentController =
        TextEditingController(text: widget.doc['note_content']);
  }

  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColors[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColors[color_id],
        title: StreamBuilder(
          stream: widget.doc.reference.snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              var docData = snapshot.data!.data() as Map<String, dynamic>;
              return Text(docData['note_title']);
            } else {
              return Text('Loading...');
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              style: AppStyle.mainTitle,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Title Note",
              ),
              onChanged: (value) {
                // Update the title of the document when the text field value changes
                widget.doc.reference.update({'note_title': value});
                widget.doc.reference.update({'updated_date': DateTime.now()});
              },
            ),
            const SizedBox(
              height: 4,
            ),
            StreamBuilder(
              stream: widget.doc.reference.snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  var docData = snapshot.data!.data() as Map<String, dynamic>;
                  DateTime? displayDate = docData['updated_date'] != null
                      ? docData['updated_date'].toDate()
                      : docData['creation_date'].toDate();
                  String displayText = docData['updated_date'] != null
                      ? 'Last updated at '
                      : ''; // Tambahkan teks "Last updated at" jika updated_date tidak null
                  return Text(
                    '$displayText${DateFormat('dd/MM/yy hh:mm a').format(displayDate!)}',
                    style: AppStyle.dateTitle,
                  );
                } else {
                  return Text('Loading...');
                }
              },
            ),
            const SizedBox(
              height: 28,
            ),
            TextField(
              controller: _contentController,
              style: AppStyle.mainContent,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Note Content",
              ),
              maxLines: null, // Allows unlimited lines of text
              onChanged: (value) {
                // Update the content of the document when the text field value changes
                widget.doc.reference.update({'note_content': value});
                widget.doc.reference.update({'updated_date': DateTime.now()});
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
