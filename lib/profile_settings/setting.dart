import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/profile_settings/activestatuspage%20(1).dart';
import 'package:messagingapp/profile_settings/change.dart';
import 'package:messagingapp/profile_settings/manageaccountpage%20(1).dart';
import 'package:messagingapp/profile_settings/noticationspage.dart';
import 'package:messagingapp/profile_settings/persondetails.dart';
import 'package:messagingapp/profile_settings/settingphotmed.dart';
import 'package:messagingapp/user_authentication/firestore.dart';

class settings extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();
  settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF9BB8CD),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: StreamBuilder<String>(
              stream: firestoreService.displayUser(),
              builder: (context, snapshot) {
                return Text(
                  snapshot.data ?? '',
                  style: TextStyle(color: Colors.black),
                );
              }),
        ),
        backgroundColor: Color(0xFF9BB8CD),
        body: StreamBuilder<Map<String, dynamic>>(
            stream: firestoreService.displayProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Handle loading state
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Handle error state
                return Text('Error: ${snapshot.error}');
              } else {
                // Access full name and image URL from snapshot.data
                String? fullName = snapshot.data?['fullname'];
                String? imageUrl = snapshot.data?['imageLink'];

                return SingleChildScrollView(
                    child: Column(children: [
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Change()),
                      );
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 45.0,
                        backgroundColor: Colors.blue,
                        child: imageUrl != null && imageUrl.isNotEmpty
                            ? ClipOval(
                                child: Image.network(
                                  imageUrl,
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(
                                Icons.person,
                                size: 50.0,
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    fullName ?? '',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          'Account Center',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.purple.shade700,
                            child: Icon(
                              Icons.change_circle,
                              size: 35.0,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'Personal Details',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => changePersonDetails()),
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Preferences',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.purple.shade700,
                            child: Icon(
                              Icons.photo_size_select_actual_outlined,
                              size: 30.0,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'Photos & Media',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => settingphotomed()),
                            );
                          },
                        ),
                        SizedBox(height: 15.0),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.purple.shade700,
                            child: Icon(
                              Icons.notifications_none,
                              size: 30.0,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'Notifications',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => notificationspage()),
                            );
                          },
                        ),
                        SizedBox(height: 15.0),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.deepPurple.shade400,
                            child: Icon(
                              Icons.lock_outline_rounded,
                              size: 30.0,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'Privacy & Safety',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => activestatuspage()),
                            );
                          },
                        ),
                        SizedBox(height: 15.0),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.blueGrey.shade400,
                            child: Icon(
                              Icons.logout,
                              size: 30.0,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'Sign out',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // Ensure the parameter type is correct
                                  return AlertDialog(
                                    title: Text("Confirm Sign out"),
                                    content: Text("Do you want to sign out?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Perform logout logic here
                                          FirebaseAuth.instance.signOut();
                                          Navigator.pushNamed(context,
                                              'login_or_register'); // Close the dialog
                                        },
                                        child: Text("OK",
                                            style:
                                                TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                ]));
              }
            }));
  }
}
