import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/navbar.dart';
import 'package:messagingapp/profile_settings/setting.dart';
import 'package:messagingapp/user_authentication/firestore.dart';

class changePersonDetails extends StatefulWidget {
  const changePersonDetails({super.key});

  @override
  State<changePersonDetails> createState() => _changePersonDetailsState();
}

class _changePersonDetailsState extends State<changePersonDetails> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService firestoreService = FirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final fullnameTextController = TextEditingController();

  final emailTextController = TextEditingController();
  final newpassTextController = TextEditingController();
  final confirmpassTextController = TextEditingController();
  String _newPassword = '';
  String _confirmPassword = '';
  String _error = '';

  @override
  void dispose() {
    fullnameTextController.dispose();

    emailTextController.dispose();
    newpassTextController.dispose();
    confirmpassTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9BB8CD),
        title: Text(
          'Personal Information',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      backgroundColor: Color(0xFF9BB8CD),
      body: StreamBuilder<String>(
          stream: firestoreService.displayInfo(),
          builder: (context, snapshot) {
            return SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //first name textfield
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.name,
                              controller: fullnameTextController,
                              decoration: InputDecoration(
                                labelText: snapshot.data ?? '',
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),

                        //emailadd textfield
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              //   keyboardType: TextInputType.emailAddress,
                              controller: emailTextController,
                              decoration: InputDecoration(
                                labelText: _auth.currentUser!.email,
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),

                        //newpass textfield
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              controller: newpassTextController,
                              decoration: InputDecoration(
                                labelText: "New Password",
                                prefixIcon: Icon(Icons.key),
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),

                        //confirmpass textfield
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              controller: confirmpassTextController,
                              decoration: InputDecoration(
                                labelText: "Confirm your Password",
                                prefixIcon: Icon(Icons.key),
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              // Process data.
                              // Example: Submit the form or send data to API.
                              _updateUserInfo(_auth.currentUser!.uid);
                            }
                          },
                          child: Text(
                            'Save changes',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ), // Change text color to black
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors
                                .white, // Change button background color to black
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => settings()));
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ), // Change text color to black
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors
                                .red, // Change button background color to black
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future<void> _changePassword() async {
    try {
      User? user = _auth.currentUser;
      await user?.updatePassword(_newPassword);
      // Password updated successfully
      // You can navigate to a new page or show a success message
    } catch (e) {
      setState(() {});
    }
  }

  Future<void> _updateUserInfo(String userId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create a map to hold the fields to update
      Map<String, dynamic> userData = {};

      // Add fullname to userData map
      if (fullnameTextController.text.isNotEmpty) {
        userData['fullname'] = fullnameTextController.text;
      }

      // Add email to userData map if it's not empty
      if (emailTextController.text.isNotEmpty) {
        userData['email'] = emailTextController.text;
      }

      // Update user document in Firestore
      await firestore.collection('users').doc(userId).update(userData);

      // Change password if new password is provided
      if (newpassTextController.text.isNotEmpty) {
        await _changePassword();
      }

      fullnameTextController.clear();
      emailTextController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully Updated'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } catch (e) {
      print("Error storing additional user info: $e");
      // Handle error appropriately
    }
  }
}
