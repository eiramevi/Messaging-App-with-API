import 'package:flutter/material.dart';

class notificationspage extends StatefulWidget {
  const notificationspage({super.key});

  @override
  State<notificationspage> createState() => _notificationspageState();
}

class _notificationspageState extends State<notificationspage> {
  bool _isSwitchedAllowNotif = true; // Initial value for the switch
  bool _isSwitchedSetSilent = true;
  int? _radioValueLockScreen; // Nullable to allow for deselection
  int? _radioValueBanner; // Nullable to allow for deselection
  bool _isLockScreenRadioDisabled = false;
  bool _isBannerRadioDisabled = true;

  void _handleRadioValue(int value) {
    if (value == 0 && !_isLockScreenRadioDisabled) {
      setState(() {
        _radioValueLockScreen = value;
        _isBannerRadioDisabled = true;
      });
    } else if (value == 1 && !_isBannerRadioDisabled) {
      setState(() {
        _radioValueBanner = value;
        _isLockScreenRadioDisabled = true;
      });
    }
  }

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
          'Notifications',
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
                  Text(
                    'Customize notifications',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Allow notifications',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Switch(
                        value: _isSwitchedAllowNotif,
                        onChanged: (bool newValue) {
                          setState(() {
                            _isSwitchedAllowNotif = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Set as silent',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Switch(
                        value: _isSwitchedSetSilent,
                        onChanged: (bool newValue) {
                          setState(() {
                            _isSwitchedSetSilent = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Lock screen',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Banner',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _handleRadioValue(0);
                        },
                        child: Row(
                          children: [
                            Radio(
                              value: 0,
                              groupValue: _radioValueLockScreen,
                              onChanged: (int? value) {
                                setState(() {
                                  if (_radioValueLockScreen == value) {
                                    _radioValueLockScreen =
                                        null; // Deselect if already selected
                                  } else {
                                    _radioValueLockScreen =
                                        value; // Select the new value
                                    _radioValueBanner =
                                        null; // Deselect the other option
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _handleRadioValue(1);
                        },
                        child: Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: _radioValueBanner,
                              onChanged: (int? value) {
                                setState(() {
                                  if (_radioValueBanner == value) {
                                    _radioValueBanner =
                                        null; // Deselect if already selected
                                  } else {
                                    _radioValueBanner =
                                        value; // Select the new value
                                    _radioValueLockScreen =
                                        null; // Deselect the other option
                                  }
                                });
                              },
                            ),
                          ],
                        ),
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
