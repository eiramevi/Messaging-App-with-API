import 'dart:io' as io;
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:messagingapp/messageScreen/Messages.dart';
import 'package:messagingapp/profile_settings/addData.dart';
import 'package:messagingapp/profile_settings/profUtil.dart';
import 'package:messagingapp/user_authentication/chat_service.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserName;
  final String receiverUserID;

  const ChatPage(
      {super.key,
      required this.receiverUserName,
      required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Uint8List? _image;
  //File? _docsFile;
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void sendMessage() async {
    //if there is something to send
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: messageAppBar(),
      body: Column(
        children: [
          //messages
          Expanded(
            child: _buildMessageList(),
          ),
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
          BackButton(),
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
                widget.receiverUserName,
                style: TextStyle(fontSize: 16),
              ),
            ],
          )
        ],
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.local_phone)),
        IconButton(onPressed: () {}, icon: Icon(Icons.videocam_rounded))
      ],
    );
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiverUserID, _auth.currentUser!.uid),
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
    DateTime? _previousDate;
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    if (data == null) {
      return Container();
    }

    var alignment = (data['senderId'] == _auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    Timestamp timestamp = data['timestamp'] as Timestamp;
    DateTime dateTime = timestamp.toDate();

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text(
        // Format date and time
        '${DateFormat('MMMM dd yyyy').format(dateTime)}',
        style: TextStyle(
          fontSize: 12, // Adjust font size as needed
          color: Colors.grey, // Optionally, change text color
        ),
        textAlign: TextAlign.center,
      ),
      Container(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: (data['senderId'] == _auth.currentUser!.uid)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: (data['senderId'] == _auth.currentUser!.uid)
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              // Text(data['senderName'] ?? ''),
              Text(
                // Format date and time
                '${DateFormat('hh:mm a').format(dateTime)}',
                style: TextStyle(
                  fontSize: 12, // Adjust font size as needed
                  color: Colors.grey, // Optionally, change text color
                ),
                textAlign: TextAlign.center,
              ),
              Messages(message: data['message'] ?? ''),
            ],
          ),
        ),
      )
    ]);
  }

//message input
  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xF087949).withOpacity(0.08))
      ]),
      child: SafeArea(
          child: Row(
        children: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.add_circle_outline_rounded)),
          SizedBox(width: 2),
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
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.only(bottom: 2),
                      onPressed: sendMessage,
                      icon: const Icon(Icons.send),
                    )
                  ],
                ),
              ),
            ),
          )),
          IconButton(onPressed: () {}, icon: Icon(Icons.file_present_outlined)),
          SizedBox(width: 8),
          IconButton(
              onPressed: () {
                selectImage();
              },
              icon: Icon(Icons.photo_library_outlined))
        ],
      )),
    );
  }
}
