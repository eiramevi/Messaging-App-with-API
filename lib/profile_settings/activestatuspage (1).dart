import 'package:flutter/material.dart';

class activestatuspage extends StatefulWidget {
  const activestatuspage({super.key});

  @override
  State<activestatuspage> createState() => _activestatuspageState();
}

class _activestatuspageState extends State<activestatuspage> {
  bool _isSwitchActiveStatus = true;

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
          'Active Status',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Show when you\'re active',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Switch(
                        value: _isSwitchActiveStatus,
                        onChanged: (bool newValue) {
                          setState(() {
                            _isSwitchActiveStatus = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
