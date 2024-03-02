import 'package:cloud_firestore/cloud_firestore.dart';

class GroupChat {
  final String senderId;
  final String senderName;
  final String receiverID;
  final String message;
  final Timestamp timestamp;

  GroupChat({
    required this.senderId,
    required this.senderName,
    required this.receiverID,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverID,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
