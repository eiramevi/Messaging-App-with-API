import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/group_chat/listmembers/GetUserName.dart';
import 'package:messagingapp/group_chat/listmembers/userName.dart';

class MemberBody extends StatefulWidget {
  final String groupId;
  MemberBody({super.key, required this.groupId});

  @override
  State<MemberBody> createState() => _MemberBodyState();
}

class _MemberBodyState extends State<MemberBody> {
  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('group_chats')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('hello'),
        ),
        body: FutureBuilder(
            future: getDocId(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: USerName(documentId: docIDs[index]),
                    );
                  });
            }));
  }
}
