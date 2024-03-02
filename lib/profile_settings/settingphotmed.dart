import 'package:flutter/material.dart';

class settingphotomed extends StatefulWidget {
  const settingphotomed({super.key});

  @override
  State<settingphotomed> createState() => _settingphotomedState();
}

class _settingphotomedState extends State<settingphotomed> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9BB8CD),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Photos & Media', style: TextStyle(color: Colors.black)),
      ),
      backgroundColor: Color(0xFF9BB8CD), // Entire background color
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Save on Capture',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      // Add your logic for switch state change here
                    });
                  },
                  activeColor: Colors.blue, // Customize the active color
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 16.0),
            child: Text(
              'Save new photos you take in the app to your Gallery',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          // You can directly add your UI components or settings here
        ],
      ),
    );
  }
}
