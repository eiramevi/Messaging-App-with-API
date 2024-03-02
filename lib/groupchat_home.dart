import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/chat_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:messagingapp/createMessage/creategroupchat.dart';
import 'package:messagingapp/groupchat_page.dart';

import 'package:messagingapp/user_authentication/firestore.dart';

class groupChatScreen extends StatefulWidget {
  groupChatScreen({super.key});

  @override
  State<groupChatScreen> createState() => _groupChatScreenState();
}

class _groupChatScreenState extends State<groupChatScreen> {
  TextEditingController _searchController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String cityName = "";
  double temperature = 0.0;
  String weatherCondition = "";

  List groupList = [];

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    // Replace "YOUR_API_KEY" with your actual API key
    String apiKey = "7ec9c7510df0fb77aca02a1922c53c02";
    String city = "Davao City"; // Replace "London" with your desired city name

    String apiUrl =
        "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        cityName = data['name'];
        temperature = (data['main']['temp'] - 273.15);
        weatherCondition = data['weather'][0]
            ['main']; // Convert temperature from Kelvin to Celsius
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  String getWeatherGif() {
    switch (weatherCondition) {
      case 'Rain':
        return '../lib/images/raining.gif';
      case 'Clouds':
        return '../lib/images/partly.png';
      case 'Thunder':
        return '../lib/images/thunder_rain.gif';
      case 'Clear Sky':
        return '../lib/images/sunny.gif';
      default:
        return ''; // Default GIF for unknown weather conditions
    }
  }

  bool _isSearchVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: Column(
        children: [
          weather(), // Weather widget
          Expanded(
            child: _groupList(),

            // User list
          ),
        ],
      ),
    );
  }

  Widget _groupList() {
    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('group_chats').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildGroupList(doc))
                .toList(),
          );
        });
  }

  Widget _buildGroupList(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (data['member'] == null) {
      return Container();
    }

    if (_auth.currentUser!.uid != data['member']) {
      return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GroupChatPage(
                          groupName: data['name'],
                          groupId: data['groupId'],
                          //  receiverID: data['userID'],
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: Row(
              children: [
                Stack(
                  children: [
                    //PROFILE AVATAR
                    CircleAvatar(
                      radius: 24,
                      //backgroundImage: AssetImage(chatsData[index].image),
                    ),
                  ],
                ),
                //CHAT NAME & LAST MESSAge
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['name'],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Opacity(opacity: 0.64, child: Text(""))
              ],
            ),
          ));
    } else {
      return Container();
    }
  }

  Widget weather() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF9BB8CD),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                getWeatherGif(), // Get the corresponding GIF
                fit: BoxFit.cover,
                height: double.infinity,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '$cityName',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '${temperature.toStringAsFixed(1)} °C',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      ' $weatherCondition',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//APPBAR
  AppBar Appbar() {
    return AppBar(
      title: _isSearchVisible
          ? Container(
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            )
          : Text("Messages"),
      backgroundColor: Color(0xFF9BB8CD),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                _isSearchVisible = !_isSearchVisible;
              });
            },
            icon: Icon(Icons.search)),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => creategroupchat(),
                ),
              );
            },
            icon: Icon(Icons.edit_square))
      ],
    );
  }
}
