import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/chat_page.dart';
import 'package:messagingapp/groupchat_page.dart';
import 'package:messagingapp/user_authentication/firestore.dart';
import 'package:uuid/uuid.dart';

class groupchatpage extends StatefulWidget {
  const groupchatpage({super.key});

  @override
  State<groupchatpage> createState() => _groupchatpageState();
}

class _groupchatpageState extends State<groupchatpage> {
  final TextEditingController _groupnameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService firestoreService = FirestoreService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9BB8CD),
        title: Text("New Message"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context); // Navigate back when the back arrow is pressed
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              String groupName = _groupnameController.text
                  .trim(); // Retrieve the group name from the text field
              createGroupChat(); // Pass the group name to createGroupChat function
            },
            child: Text(
              "CREATE",
              style: TextStyle(
                color: Colors.black, // Set text color to white
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
      backgroundColor:
          Color(0xFF9BB8CD), // Set the background color of the entire Scaffold
      body: Column(children: [
        ListTile(
          title: TextField(
            controller: _groupnameController,
            decoration: InputDecoration(
              hintText: 'Group Name',
            ),
          ),
        ),
        SizedBox(height: 8),
        Column(
          children: [
            Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            )
          ],
        ),
        ListTile(
          title: Text("Suggested"),
        ),
        _userList(),
        // Display suggested items with checkboxes
      ]),
      // Add other widgets or components here
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
      bool isSelected = selectedItems.contains(data['fullname']);
      return InkWell(
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
                            ]))),
                Spacer(),
                Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          selectedItems.add(data['fullname']);
                        } else {
                          selectedItems.remove(data['fullname']);
                        }
                      });
                    })
              ])));
    } else {
      return Container();
    }
  }

  void createGroupChat() async {
    // Get the name of the group from the text field
    String groupName = _groupnameController.text.trim();
    String groupId = Uuid().v1();
    // Ensure at least one user is selected and a group name is provided
    if (selectedItems.isNotEmpty && groupName.isNotEmpty) {
      // Get the current user's ID
      String currentUserId = _auth.currentUser!.uid;
      DocumentSnapshot currentUserDoc =
          await _firestore.collection('users').doc(currentUserId).get();
      String currentUserName = currentUserDoc.get('fullname');

      // Add the current user's ID to the list of selected users
      selectedItems.add(currentUserName);

      // Sort the list of selected user IDs to ensure uniqueness
      selectedItems.sort();

      // Create a document in the "group_chats" collection with the group name
      DocumentReference groupChatRef = await FirebaseFirestore.instance
          .collection('group_chats')
          .add(
              {'name': groupName, 'member': selectedItems, 'groupId': groupId});

      // Get the ID of the newly created group chat
      String groupChatId = groupChatRef.id;

      // Add the selected users to the "members" subcollection of the group chat document

      /*   await _firestore
          .collection('group_chats')
          .doc(groupId)
          .collection('chats')
          .add({
        "message": "${_auth.currentUser!.uid} Created This Group.",
        "type": "notify",
      });*/

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GroupChatPage(
                    groupName: groupName,
                    groupId: groupId,
                    //  receiverID: '',
                  )));

      // Optionally, you can navigate to the group chat screen or perform any other actions here
    } else {
      // Show an error message if no users are selected or no group name is provided
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Please select at least one user and provide a group name.'),
        ),
      );
    }
  }
}
