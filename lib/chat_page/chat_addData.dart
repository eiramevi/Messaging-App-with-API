import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class StoreDataChat {
  Future<String> uploadImageToStorage(
      String child, Uint8List file, String contentType) async {
    Reference ref = _storage.ref().child(child).child('image');
    UploadTask uploadTask =
        ref.putData(file, SettableMetadata(contentType: contentType));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveData(
      {required Uint8List file, required contentType}) async {
    String resp = "Some error Occured";
    try {
      String imageUrl =
          await uploadImageToStorage('chatImage', file, contentType);
      await _firestore
          .collection('chat_rooms')
          .doc(_auth.currentUser!.uid)
          .collection('messages')
          .doc()
          .update({
        'imageLink': imageUrl,
      });

      resp = 'Success';
    } catch (e) {
      resp = e.toString();
    }
    return resp;
  }
}
