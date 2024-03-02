import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class membersGC extends StatefulWidget {
  final String groupId;
  membersGC({Key? key, required this.groupId}) : super(key: key);
  @override
  State<membersGC> createState() => _membersGCState();
}

class _membersGCState extends State<membersGC> {
  List membersList = [];
  List<String> docIDs = [];
  bool isLoading = true;

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('group_chats')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
            }));
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    getGroupDetails();
  }

  Future<void> getGroupDetails() async {
    try {
      final chatMap =
          await _firestore.collection('group_chats').doc(widget.groupId).get();
      if (chatMap.exists) {
        setState(() {
          membersList = List<Map<String, dynamic>>.from(chatMap['members']);
          isLoading = false;
        });
      } else {
        // Handle case where document doesn't exist
      }
    } catch (e) {
      // Handle error
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: const Color(0xFF9BB8CD),
        appBar: AppBar(
          backgroundColor: const Color(0xFF9BB8CD),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 35),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Members',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Members'),
              Tab(text: 'Admins'),
            ],
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: membersList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text(
                      membersList[index]['fullname'],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: Text(
                'Admins Tab Content',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
