import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messagingapp/group_chat/gcpage.dart';
import 'package:messagingapp/groupchat_home.dart';
import 'package:messagingapp/messageScreen/Messages.dart';
import 'package:messagingapp/navbar.dart';
import 'package:messagingapp/user_authentication/chat_service.dart';
import 'package:messagingapp/user_authentication/firestore.dart';
import 'package:messagingapp/user_authentication/groupchat_service.dart';
import 'package:intl/intl.dart';

class GroupChatPage extends StatefulWidget {
  final String groupName, groupId;

  const GroupChatPage(
      {required this.groupName, required this.groupId, Key? key})
      : super(key: key);

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  // File? _imageFile;
  //File? _docsFile;
  final TextEditingController _messageController = TextEditingController();
  final GroupChatService _groupchatService = GroupChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService firestoreService = FirestoreService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
  }

  /*void sendMessage() async {
    //if there is something to send
    if (_messageController.text.isNotEmpty) {
      await _groupchatService.sendMessage(
          widget.groupName, _messageController.text);
      _messageController.clear();
    }
  }*/
  void onSendMessage() async {
    final String currenUserId = _auth.currentUser!.uid;
    DocumentSnapshot currentUserDoc =
        await _firestore.collection('users').doc(currenUserId).get();
    String currentUserName = currentUserDoc.get('fullname');
    if (_messageController.text.isNotEmpty) {
      Map<String, dynamic> chatData = {
        'sendBy': _auth.currentUser!.uid,
        'senderName': currentUserName,
        'message': _messageController.text,
        'type': 'text',
        'time': Timestamp.now()
      };
      _messageController.clear();

      await _firestore
          .collection('group_chats')
          .doc(widget.groupId)
          .collection('chats')
          .add(chatData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: messageAppBar(),
      body: Column(
        children: [
          //messages
          Expanded(child: _buildMessageList()),
          //user input
          _buildMessageInput(),
        ],
      ),
    );
  }

  AppBar messageAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF9BB8CD),
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => NavBar()));
              },
              icon: Icon(Icons.arrow_back)),
          CircleAvatar(
              //  backgroundImage: AssetImage(""),

              ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.groupName,
                //widget.receiverUserEmail,

                style: TextStyle(fontSize: 16),
              ),
            ],
          )
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroupChatSetting(
                    groupName: widget.groupName,
                    groupId: widget.groupId,
                  ),
                ),
              );
            },
            icon: Icon(Icons.more_vert_rounded)),
      ],
    );
  }

  Widget body() {
    return Container();
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('group_chats')
          .doc(widget.groupId)
          .collection('chats')
          .orderBy('time')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

//message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    if (data == null) {
      return Container();
    }

    var alignment = (data['sendBy'] == _auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (data['sendBy'] == _auth.currentUser!.uid)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderBy'] == _auth.currentUser!.uid)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Text(data['senderName'] ?? ''),
            Messages(message: data['message'] ?? ''),
          ],
        ),
      ),
    );
  }

//message input
  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xF087949).withOpacity(0.08))
      ]),
      child: SafeArea(
          child: Row(
        children: [
          Icon(Icons.add_circle_outline),
          SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(48)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                              hintText: "Message ...",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 10)
                              /*  prefixIcon: _imageFile != null
                                  ? Container(
                                      width: 40,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: FileImage(_imageFile!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : null),*/
                              ),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.only(bottom: 2),
                        onPressed: onSendMessage,
                        icon: const Icon(Icons.send),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.file_present_outlined)),
          SizedBox(width: 8),
          IconButton(
              onPressed: () {
                _getImage();
              },
              icon: Icon(Icons.photo_library_outlined))
        ],
      )),
    );
  }
}
