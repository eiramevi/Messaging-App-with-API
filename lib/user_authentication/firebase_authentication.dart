import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signUpWithEmailAndPassword(
      String firstname, String lastname, String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _storeAdditionalUserInfo(
          credential.user!.uid, firstname, lastname, email);

      return credential.user;
    } catch (e) {
      print("Error signing up with email and password: $e");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Error signing in with email and password: $e");
    }
    return null;
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        // Additional operations after signing in with Google if needed

        return user;
      } else {
        print("Google Sign-In canceled.");
      }
    } catch (e) {
      print("Error signing in with Google: $e");
    }
    return null;
  }

  Future<void> _storeAdditionalUserInfo(
      String userId, String firstname, String lastname, String email) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(userId).set({
        'userID': userId,
        'fullname': '$firstname $lastname',
        'email': email,
        'imageLink': "",
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
