import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

Widget noteCard(BuildContext context, Function()? onTap,
    QueryDocumentSnapshot doc, Function()? onDelete) {
  return Slidable(
    key: Key(doc.id),
    endActionPane: ActionPane(
      motion: const StretchMotion(),
      children: [
        SlidableAction(
          autoClose: true,
          borderRadius: BorderRadius.circular(8),
          onPressed: (context) {
            onDelete!();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Catatan dihapus"),
              ),
            );
          },
          backgroundColor: Colors.red,
          icon: Icons.delete,
        )
      ],
    ),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: EdgeInsets.all(8),
        width: double.infinity, // Menambahkan margin horizontal
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: AppStyle.cardsColors[doc['color_id']],
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doc['note_title'],
              style: AppStyle.mainTitle,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              DateFormat('dd/MM/yy hh:mm a')
                  .format(doc['creation_date'].toDate()),
              style: AppStyle.dateTitle,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              doc['note_content'],
              style: AppStyle.mainContent,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ],
        ),
      ),
    ),
  );
}
