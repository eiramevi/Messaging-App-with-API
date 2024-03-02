import "package:flutter/material.dart";

class ChangeGC extends StatefulWidget {
  const ChangeGC({super.key});

  @override
  State<ChangeGC> createState() => _ChangeGCState();
}

class _ChangeGCState extends State<ChangeGC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF9BB8CD),
        appBar: AppBar(
          backgroundColor: Color(0xFF9BB8CD),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 35),
            color: Colors.black,
            onPressed: () {
              // Add your logic to go back
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Change Group Photo or Name',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // or CrossAxisAlignment.end
          children: [
            SizedBox(height: 20), // Add some space
            GestureDetector(
              onTap: () {
                // Add your logic to handle profile picture change
              },
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Adjust alignment as needed
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFF9BB8CD),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.image, size: 20), // Image icon
                        SizedBox(width: 10), // Add some space
                        Text(
                          'Choose group photo',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20), // Add some space between buttons
                ],
              ),
            ),
            SizedBox(height: 20), // Add some space between buttons
            GestureDetector(
              onTap: () {
                // Add your logic to handle changing status
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xFF9BB8CD),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.change_circle, size: 20), // Change status icon
                    SizedBox(width: 10), // Add some space
                    Text(
                      'Change name',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
