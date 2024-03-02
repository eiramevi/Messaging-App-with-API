import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:messagingapp/chat_screen.dart';
import 'package:messagingapp/createMessage/creategroupchat.dart';
import 'package:messagingapp/firebase_options.dart';

import 'package:messagingapp/groupchat_home.dart';

import 'package:messagingapp/login_signup/login_or_register.dart';

import 'package:messagingapp/navbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Message App',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginOrRegister(),
      routes: {
        'login_or_register': (context) => const LoginOrRegister(),
        'navbar': (context) => const NavBar(),
        'groupchatScreen': (context) => groupChatScreen(),
      },
    );
  }
}
