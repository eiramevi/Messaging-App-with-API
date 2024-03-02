import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:messagingapp/chat_screen.dart';
import 'package:messagingapp/groupchat_home.dart';

import 'package:messagingapp/profile_settings/setting.dart';

import 'package:messagingapp/user_authentication/firestore.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService firestoreService = FirestoreService();

  final List<Widget> _pages = [
    ChatScreen(),
    groupChatScreen(),
    settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },

          // backgroundColor: Colors.black,
          selectedIconTheme: IconThemeData(color: Color(0xFF9BB8CD)),
          unselectedIconTheme: IconThemeData(color: Colors.blueGrey[800]),
          fixedColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.messenger,
              ),
              label: "Chats",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: "Group Chat",
            ),
            /*  BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "People",
            ),*/
            BottomNavigationBarItem(
                icon: CircleAvatar(
                  //users profile image
                  backgroundImage: AssetImage(""),
                ),
                label: "Profile"),
          ],
        ));
  }
}
