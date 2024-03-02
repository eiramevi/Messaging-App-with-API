import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/navbar.dart';
import 'package:messagingapp/user_authentication/firebase_authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final _formfield = GlobalKey<FormState>();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  bool rememberMe = false;
  bool passToggle = true;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  void _signInWithGoogle() async {
    User? user = await _auth.signInWithGoogle();

    if (user != null) {
      // Successful sign-in with Google, you can navigate to the next screen or do any other action
      // For example, navigate to the home screen
      Navigator.pushReplacementNamed(context, 'navbar');
    } else {
      // Handle sign-in failure
      // For example, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Google'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9BB8CD),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Form(
              key: _formfield,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 15),

                  //welcome message
                  Text(
                    "Messaging App",
                    style: TextStyle(
                      color: Colors.black,
                      //  fontWeight: FontWeight.bold,
                      fontFamily: 'CedarvilleCursive-Regular',
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 50),

                  //email textfield
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailTextController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                    ),
                    validator: (value) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9,a-zA-Z0-9.!#$%&'*+-/=?^_'{|}]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);
                      if (value.isEmpty) {
                        return "Enter Email";
                      } else if (!emailValid) {
                        return "Enter Valid Email";
                      }
                    },
                  ),
                  const SizedBox(height: 20),

                  //password textfield
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: passwordTextController,
                    obscureText: passToggle,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      prefixIcon: Icon(Icons.lock, color: Colors.black),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            passToggle = !passToggle;
                          });
                        },
                        child: Icon(
                          passToggle ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      } else if (passwordTextController.text.length < 6) {
                        return "Password Length is should not be less than 6 characters";
                      }
                    },
                  ),
                  const SizedBox(height: 20),

                  //Remember Me checkbox
                  Row(
                    children: [
                      Spacer(), //add space between the checkbox and text
                    ],
                  ),
                  const SizedBox(height: 20),

                  InkWell(
                    onTap: _signIn,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Or login with

                  //Button Google

                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: GestureDetector(
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    if (emailTextController.text.isEmpty ||
        passwordTextController.text.isEmpty) {
      // Show error message to the user using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please put email and password.'),
          behavior: SnackBarBehavior
              .floating, // Ensure the SnackBar floats above other content
          margin: EdgeInsets.all(20), // Adjust margin as needed
          shape: RoundedRectangleBorder(
            // Apply rounded corners to SnackBar
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return; // Return to prevent further execution
    }

    String email = emailTextController.text;
    String password = passwordTextController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null && _formfield.currentState!.validate()) {
      emailTextController.clear();
      passwordTextController.clear();
      if (email == user && password == user) {
        emailTextController.clear();
      }

      // ignore: use_build_context_synchronously

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Log In'),
          behavior: SnackBarBehavior
              .floating, // Ensure the SnackBar floats above other content
          margin: EdgeInsets.all(20), // Adjust margin as needed
          shape: RoundedRectangleBorder(
            // Apply rounded corners to SnackBar
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      Navigator.pushReplacementNamed(context, 'navbar');

      return; // Return to prevent further execution
    }
  }
}
