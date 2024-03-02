import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//DISPLAY CONTACT
  Stream<String> displayUser() {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        return FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .snapshots()
            .map((snapshot) {
          return snapshot['fullname'];
        });
      } else {
        // Handle the case where the user is not authenticated
        return Stream<String>.empty();
      }
    } catch (e, stackTrace) {
      // Handle the exception
      print('Error getting user display name stream: $e');
      print(stackTrace);
      return Stream<String>.empty();
    }
  }

//DISPLAY USER WHO LOG IN
  Stream<Map<String, dynamic>> displayProfile() {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        return FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .snapshots()
            .map((snapshot) {
          return {
            'fullname': snapshot['fullname'],
            'imageLink': snapshot[
                'imageLink'], // Assuming 'imageLink' is the field storing the image URL
          };
        });
      } else {
        // Handle the case where the user is not authenticated
        return Stream<Map<String, dynamic>>.empty();
      }
    } catch (e, stackTrace) {
      // Handle the exception
      print('Error getting user data stream: $e');
      print(stackTrace);
      return Stream<Map<String, dynamic>>.empty();
    }
  }

  Stream<QuerySnapshot> getUsersStream(String searchQuery) {
    if (searchQuery.isEmpty) {
      // If the search query is empty, return all users
      return FirebaseFirestore.instance.collection('users').snapshots();
    } else {
      // If there's a search query, filter users based on it
      return FirebaseFirestore.instance
          .collection('users')
          .where('fullname', isGreaterThanOrEqualTo: searchQuery)
          .snapshots();
    }
  }

  Stream<QuerySnapshot> getMembers(String groupId) {
    return _firestore
        .collection('group_chats')
        .doc(groupId)
        .collection('members')
        .snapshots();
  }

  Stream<String> displayInfo() {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        return FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .snapshots()
            .map((snapshot) {
          return snapshot['fullname'];
        });
      } else {
        // Handle the case where the user is not authenticated
        return Stream<String>.empty();
      }
    } catch (e, stackTrace) {
      // Handle the exception
      print('Error getting user display name stream: $e');
      print(stackTrace);
      return Stream<String>.empty();
    }
  }

  Future<void> _updateUserInfo(
      String userId, String firstname, String lastname, String email) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(userId).update({
        'fullname': ' ',
        'email': email,
      });
      print('User additional info stored successfully.');
    } catch (e) {
      print("Error storing additional user info: $e");
      // Handle error appropriately, such as showing a message to the user
      // or retrying the operation.
      // You can also re-throw the error to let the caller handle it.
      throw e;
    }
  }
}
