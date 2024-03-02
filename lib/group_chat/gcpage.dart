import 'package:flutter/material.dart';
import 'package:messagingapp/group_chat/addpeople.dart';
import 'package:messagingapp/group_chat/gcchange.dart';
import 'package:messagingapp/group_chat/gcmediafiles.dart';

import 'package:messagingapp/group_chat/gcmembers.dart';

class GroupChatSetting extends StatefulWidget {
  final String groupName, groupId;

  GroupChatSetting({Key? key, required this.groupName, required this.groupId})
      : super(key: key);

  @override
  State<GroupChatSetting> createState() => _GroupChatSettingState();
}

class _GroupChatSettingState extends State<GroupChatSetting> {
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
      ),
      backgroundColor: Color(0xFF9BB8CD),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.person,
                  size: 50.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 15), // Moved the SizedBox here
            Text(
              widget.groupName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 13),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangeGC()),
                );
              },
              child: Text(
                'Change name or image',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => addPeople()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.blueGrey.shade400,
                    child: Icon(
                      Icons.person_add,
                      size: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.all(10.0),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0xFF9BB8CD),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chat Info',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.blueGrey.shade400,
                      child: Icon(
                        Icons.person,
                        size: 26.0,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      'See members',
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
                            builder: (context) => membersGC(
                                  groupId: widget.groupId,
                                )),
                      );
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'More actions',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.blueGrey.shade400,
                      child: Icon(
                        Icons.photo_size_select_actual_outlined,
                        size: 26.0,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      'View media, files, and links',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => mediafilesGC()),
                      );
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Privacy and Support',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.blueGrey.shade400,
                      child: Icon(
                        Icons.logout,
                        size: 26.0,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      'Leave chat',
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
                          return AlertDialog(
                            title: Text("Confirm leave group chat"),
                            content:
                                Text("Do you want to leave this group chat?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Perform leave chat logic here
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "OK",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
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
