import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/messageScreen/Messages.dart';
import 'package:messagingapp/messageScreen/group_messages.dart';
import 'package:messagingapp/messageScreen/message.dart';

class GroupChatService extends ChangeNotifier {
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
        await _firestore.collection('group_chats').doc(currenUserId).get();
    String currentUserName = currentUserDoc.get('fullname');
    //create a new MESSAGE
    GroupChat newMessage = GroupChat(
      senderId: currenUserId,
      senderName: currentUserName,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    //construct chatroom id from current user id and receiver id(soreted to ensure uniquness)
    List<String> ids = [currenUserId, receiverID];
    ids.sort();
    String groupchatId = ids.join("_");
    //add new message to database
    await _firestore
        .collection('group_chats')
        .doc(groupchatId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //GET MESSAGE
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String groupchatId = ids.join("_");
    return _firestore
        .collection('group_chats')
        .doc(groupchatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getGroupChatMessages(String groupchatId) {
    return _firestore
        .collection('group_chats')
        .doc(groupchatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
