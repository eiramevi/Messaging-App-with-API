import 'package:flutter/material.dart';

class manageaccountpage extends StatefulWidget {
  const manageaccountpage({super.key});

  @override
  State<manageaccountpage> createState() => _manageaccountpageState();
}

class _manageaccountpageState extends State<manageaccountpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9BB8CD),
      appBar: AppBar(
        backgroundColor: Color(0xFF9BB8CD),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 35, color: Colors.black),
          onPressed: () {
            // Add your logic to go back
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Switch account',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chana',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'signed in',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Handle tap on plus button
              print('Plus button tapped');
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Add account',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(), // Pushes the button to the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              color: Colors.white,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // background color
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ), // text color
                ),
                child: const Text('CREATE A NEW ACCOUNT',
                    style: TextStyle(
                        fontWeight:
                            FontWeight.bold)), // trying to move to the bottom
              ),
            ),
          ),
        ],
      ),
    );
  }
}
