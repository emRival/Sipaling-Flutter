import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/screens/note_create_screen.dart';
import 'package:firebase_app/screens/note_reader_screen.dart';
import 'package:firebase_app/style/app_style.dart';
import 'package:firebase_app/widget/note_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/firestore_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService firestoreService = FirestoreService();
  bool isGridView = true;
  late String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
        title: const Text(
          "FireNotes",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoSearchTextField(
              prefixIcon: Icon(Icons.search),
              placeholder: "Cari Catatan",
              style: TextStyle(color: Colors.white),
              onSubmitted: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Text(
              "Catatan Terbaru Anda",
              textAlign: TextAlign.center, // Menambahkan TextAlign
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: searchQuery.isEmpty
                  ? firestoreService.getNotesStream()
                  : firestoreService.searchNotes(searchQuery),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}",
                      style: GoogleFonts.nunito(color: Colors.white));
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  List noteList = snapshot.data!.docs;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: isGridView
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1 /
                                  1.2, // Mengatur rasio aspek card agar lebih tinggi
                            ),
                            itemCount: noteList.length,
                            itemBuilder: (context, index) {
                              return noteCard(
                                  context,
                                  () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NoteReaderScreen(
                                            doc: noteList[index]),
                                      ),
                                    );
                                  },
                                  noteList[index],
                                  () {
                                    firestoreService
                                        .deleteNote(noteList[index].id);
                                    setState(() {});
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Catatan dihapus"),
                                      ),
                                    );
                                  });
                            },
                          )
                        : ListView.builder(
                            itemCount: noteList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width:
                                    double.infinity, // Membuat card full width

                                child: noteCard(
                                    context,
                                    () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              NoteReaderScreen(
                                                  doc: noteList[index]),
                                        ),
                                      );
                                    },
                                    noteList[index],
                                    () {
                                      firestoreService
                                          .deleteNote(noteList[index].id);
                                      setState(() {});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("Catatan dihapus"),
                                        ),
                                      );
                                    }),
                              );
                            },
                          ),
                  );
                } else {
                  return Text("Tidak ada Catatan",
                      style: GoogleFonts.nunito(color: Colors.white));
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NoteCreateScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
