import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class USerName extends StatelessWidget {
  final String documentId;
  USerName({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference groupChatRef =
        FirebaseFirestore.instance.collection('group_chats');

    CollectionReference users =
        FirebaseFirestore.instance.collection('group_chats');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text('Name: ${data['members']}');
          }
          return Text('loadding');
        }));
  }
}
