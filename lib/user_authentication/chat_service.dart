import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/messageScreen/message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverID, String message) async {
    //get current user info
    final String currenUserId = _auth.currentUser!.uid;
    // final String currentUserName = _auth.currentUser!.email.toString();
    final String currentUserEmail = _auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    //User? user = _auth.currentUser;
    DocumentSnapshot currentUserDoc =
        await _firestore.collection('users').doc(currenUserId).get();
    String currentUserName = currentUserDoc.get('fullname');
    //create a new MESSAGE
    Message newMessage = Message(
      senderId: currenUserId,
      senderName: currentUserName,
      receiverID: receiverID,
      message: message,
      //    imageUrl: imageUrl,
      timestamp: timestamp,
    );

    //construct chatroom id from current user id and receiver id(soreted to ensure uniquness)
    List<String> ids = [currenUserId, receiverID];
    ids.sort();
    String chatRoomId = ids.join("_");
    //add new message to database
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //GET MESSAGE
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
