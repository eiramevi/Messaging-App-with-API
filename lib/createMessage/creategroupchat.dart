import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/chat_page.dart';
import 'package:messagingapp/chat_screen.dart';
import 'package:messagingapp/createMessage/groupchatpage.dart';

import 'package:messagingapp/user_authentication/firestore.dart';

class creategroupchat extends StatefulWidget {
  const creategroupchat({super.key});

  @override
  State<creategroupchat> createState() => _creategroupchatState();
}

class _creategroupchatState extends State<creategroupchat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService firestoreService = FirestoreService();
  String _searchQuery = '';
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9BB8CD),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('New Message'),
      ),
      backgroundColor: Color(0xFF9BB8CD),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Expanded(
            child: ListView(children: [
          // Your list tile for Group Chat
          ListTile(
            title: Text('Group Chat'),
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade400,
              child: Icon(Icons.group),
            ),
            onTap: () {
              // Navigate to a new page when Group Chat is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      groupchatpage(), // Replace with the actual page for Group Chat
                ),
              );
            },
          ),
          // Your list tile for Suggested
          ListTile(
            title: Text("Suggested"),
          ),
          _userList(),
        ]))
      ]),
    );
  }

  Widget _userList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }
          return Column(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserList(doc))
                .toList(),
          );
        });
  }

  Widget _buildUserList(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (data == null || data['email'] == null || data['userID'] == null) {
      return Container();
    }

    if (_auth.currentUser!.email != data['email']) {
      return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                          receiverUserName: data['fullname'],
                          receiverUserID: data['userID'],
                        )));
          },
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Row(children: [
                Stack(
                  children: [
                    //PROFILE AVATAR
                    CircleAvatar(
                      radius: 24,
                      //backgroundImage: AssetImage(chatsData[index].image),
                    ),
                  ],
                ),
                //CHAT NAME & LAST MESSAge
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['fullname'],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ])))
              ])));
    } else {
      return Container();
    }
  }
}
