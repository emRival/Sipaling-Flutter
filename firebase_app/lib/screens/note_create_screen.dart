import 'dart:math';

import 'package:firebase_app/services/firestore_service.dart';
import 'package:firebase_app/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteCreateScreen extends StatefulWidget {
  const NoteCreateScreen({super.key});

  @override
  State<NoteCreateScreen> createState() => _NoteCreateScreenState();
}

class _NoteCreateScreenState extends State<NoteCreateScreen> {
  final FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    int color_id = Random().nextInt(AppStyle.cardsColors.length);
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _contentController = TextEditingController();
    return Scaffold(
      backgroundColor: AppStyle.cardsColors[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColors[color_id],
        title: Text(
          "Create New Note",
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  style: AppStyle.mainTitle,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title Note",
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                TextField(
                  style: AppStyle.mainContent,
                  maxLines: null,
                  controller: _contentController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Content Note",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.save),
          label: Text('Simpan'),
          onPressed: () async {
            if (_titleController.text.isNotEmpty) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 20),
                        Text("Menyimpan..."),
                      ],
                    ),
                  ),
                ),
              );

              try {
                await firestoreService.addNote(
                    _titleController.text, _contentController.text, color_id);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Gagal menyimpan catatan')),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Title tidak boleh kosong')));
            }

            // Tutup dialog loading

            // Kembali ke halaman sebelumnya
          }),
    );
  }
}
