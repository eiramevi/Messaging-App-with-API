import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/group_chat/listmembers/GetUserName.dart';
import 'package:messagingapp/group_chat/listmembers/member_body.dart';

class Members extends StatefulWidget {
  const Members({super.key});

  @override
  State<Members> createState() => _membersState();
}

class _membersState extends State<Members> {
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
                      title: GetUSerName(documentId: docIDs[index]),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MemberBody(
                                      groupId: docIDs[index],
                                    )));
                      },
                    );
                  });
            }));
  }
}

/* return ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: GetUSerName(documentId: docIDs[index]),
                    );
                  });*/