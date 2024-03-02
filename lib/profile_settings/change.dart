import "dart:io";
import "dart:typed_data";

import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import 'package:messagingapp/profile_settings/profUtil.dart';
import "package:messagingapp/profile_settings/addData.dart";
import "package:messagingapp/profile_settings/setting.dart";

class Change extends StatefulWidget {
  const Change({super.key});

  @override
  State<Change> createState() => _ChangeState();
}

class _ChangeState extends State<Change> {
  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void saveProfile() async {
    String resp =
        await StoreData().saveData(file: _image!, contentType: 'png ');
  }

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
            'Change Profile Picture and Status',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: MemoryImage(_image!),
                                )
                              : CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(
                                      'https://static.vecteezy.com/system/resources/previews/026/619/142/non_2x/default-avatar-profile-icon-of-social-media-user-photo-image-vector.jpg'),
                                ),
                          Positioned(
                            child: IconButton(
                                onPressed: () {
                                  selectImage();
                                },
                                icon: Icon(Icons.add_a_photo)),
                            bottom: -10,
                            left: 80,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            saveProfile();
                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => settings()),
                            );
                          },
                          child: Text('Save Profile Picture'))
                    ]))));
  }
}
