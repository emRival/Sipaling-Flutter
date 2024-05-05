import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference notes =
      FirebaseFirestore.instance.collection("Notes");

//CREATE
  Future<void> addNote(String title, String content, int color_id) {
    return notes.add({
      "color_id": color_id,
      "creation_date": DateTime.now(),
      "updated_date": null,
      "note_title": title,
      "note_content": content
    });
  }

  // Future<void> updateNote(String docId, String title, String content) {
  //   return notes.doc(docId).update({
  //     "creation_date": DateTime.now(),
  //     "note_title": title,
  //     "note_content": content
  //   });
  // }

  //READ
  Stream<QuerySnapshot> getNotesStream() {
    final notesStream =
        notes.orderBy("creation_date", descending: true).snapshots();

    return notesStream;
  }

  //DELETE
  Future<void> deleteNote(String docId) {
    return notes.doc(docId).delete();
  }

//search
  Stream<QuerySnapshot> searchNotes(String query) {
    return notes.where('note_title', isGreaterThanOrEqualTo: query).snapshots();
  }
}
