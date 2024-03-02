import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/user_authentication/firebase_authentication.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final _formfield = GlobalKey<FormState>();
  final firstnameTextController = TextEditingController();
  final lastnameTextController = TextEditingController();
  final emailTextController = TextEditingController();

  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  bool passToggle = true;
  bool confirmpassToggle = true;
  bool termsAndcondition = false;

  @override
  void dispose() {
    firstnameTextController.dispose();
    lastnameTextController.dispose();

    emailTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9BB8CD),
      body: SafeArea(
        child: Center(
          child: Padding(
            key: _formfield,
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //welcome message
                Text(
                  "Welcome!",
                  style: TextStyle(
                    //  fontWeight: FontWeight.bold,
                    fontFamily: 'CedarvilleCursive-Regular',
                    color: Colors.black,
                    fontSize: 35,
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  "Create your account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),

                //username textfield
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: firstnameTextController,
                        decoration: InputDecoration(
                          labelText: "First name",
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        validator: (value) {
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9,a-zA-Z0-9.!#$%&'*+-/=?^_'{|}]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!);
                          if (value.isEmpty) {
                            return "Enter Firstname";
                          } else if (!emailValid) {
                            return "Enter Valid name";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10), // Add some space between the fields
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: lastnameTextController,
                        decoration: InputDecoration(
                          labelText: "Last name",
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        validator: (value) {
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9,a-zA-Z0-9.!#$%&'*+-/=?^_'{|}]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!);
                          if (value.isEmpty) {
                            return "Enter Lastname";
                          } else if (!emailValid) {
                            return "Enter Valid name";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                //emailaddress textfield
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailTextController,
                  decoration: InputDecoration(
                    labelText: "Enter your Email Address",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  validator: (value) {
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9,a-zA-Z0-9.!#$%&'*+-/=?^_'{|}]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);
                    if (value.isEmpty) {
                      return "Enter Email Address";
                    } else if (!emailValid) {
                      return "Enter Valid Email Address";
                    }
                  },
                ),

                const SizedBox(height: 20),

                //createpassword textfield
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordTextController,
                  obscureText: passToggle,
                  decoration: InputDecoration(
                    labelText: "Create a Password",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          passToggle = !passToggle;
                        });
                      },
                      child: Icon(
                          passToggle ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                //confirmpassword textfield
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: confirmPasswordTextController,
                  obscureText: confirmpassToggle,
                  decoration: InputDecoration(
                    labelText: "Confirm your Password",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          confirmpassToggle = !confirmpassToggle;
                        });
                      },
                      child: Icon(
                          confirmpassToggle
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Password";
                    } else if (passwordTextController.text.length < 8) {
                      return "Password Length is should not be less than 6 characters";
                    } else if (value != passwordTextController.text) {
                      return "Passwords do not match.";
                    }
                  },
                ),
                const SizedBox(height: 20),

                //Remember Me checkbox

                const SizedBox(height: 20),

                InkWell(
                  onTap: _signUp,

                  /*if (_formfield.currentState!.validate()) {
                        print("Data Added Successfully");
                        emailTextController.clear();
                        passwordTextController.clear();
                      }*/

                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "Sign up",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
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
    );
  }

  void _signUp() async {
    if (firstnameTextController.text.isEmpty ||
        lastnameTextController.text.isEmpty ||
        passwordTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill out all fields.'),
          behavior: SnackBarBehavior
              .floating, // Ensure the SnackBar floats above other content
          margin: EdgeInsets.all(20), // Adjust margin as needed
          shape: RoundedRectangleBorder(
            // Apply rounded corners to SnackBar
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }
    if (passwordTextController.text.length < 8) {
      // Show error message to the user using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password must be at least 8 characters long.'),
          behavior: SnackBarBehavior
              .floating, // Ensure the SnackBar floats above other content
          margin: EdgeInsets.all(20), // Adjust margin as needed
          shape: RoundedRectangleBorder(
            // Apply rounded corners to SnackBar
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    if (passwordTextController.text.length !=
        confirmPasswordTextController.text.length) {
      // Show error message to the user using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password do not match.'),
          behavior: SnackBarBehavior
              .floating, // Ensure the SnackBar floats above other content
          margin: EdgeInsets.all(20), // Adjust margin as needed
          shape: RoundedRectangleBorder(
            // Apply rounded corners to SnackBar
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    String firstname = firstnameTextController.text;
    String lastname = lastnameTextController.text;
    String email = emailTextController.text;

    String password = passwordTextController.text;
    String confirm_pass = confirmPasswordTextController.text;

    User? user = await _auth.signUpWithEmailAndPassword(
        firstname, lastname, email, password);

    if (user != null) {
      // Clear text fields
      firstnameTextController.clear();
      lastnameTextController.clear();
      emailTextController.clear();

      passwordTextController.clear();
      confirmPasswordTextController.clear();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account successfully created.'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      Navigator.pushReplacementNamed(context, 'login');
      return;
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create account. Please try again.'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }
}
