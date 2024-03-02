import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderName;
  final String receiverID;
  final String message;
  // final String imageUrl;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.senderName,
    required this.receiverID,
    required this.message,
    //  required this.imageUrl,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverID,
      'message': message,
      //   'imageUrl': imageUrl,
      'timestamp': timestamp,
    };
  }
}
