import 'package:flutter/material.dart';

class addPeople extends StatefulWidget {
  const addPeople({super.key});

  @override
  State<addPeople> createState() => _addPeopleState();
}

class _addPeopleState extends State<addPeople> {
  List<int> selectedRadioList = [
    -1
  ]; // List to store selected radio button values

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
          'Add People',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Add your logic for add member
              // This is just an example, replace it with your actual logic
            },
            child: Text(
              'ADD',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.black,
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Suggested',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Your ListTiles go here
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                // Your circle avatar widget
              ),
              title: Text(
                'Joe Marudo',
                // Your text widget for the name
              ),
              trailing: Checkbox(
                value: selectedRadioList.contains(0),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedRadioList.add(0); // Add to selected list
                    } else {
                      selectedRadioList.remove(0); // Remove from selected list
                    }
                  });
                },
              ),
            ),
            // Repeat ListTile widgets for other options
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                // Your circle avatar widget
              ),
              title: Text(
                'Aye Dorum',
                // Your text widget for the name
              ),
              trailing: Checkbox(
                value: selectedRadioList.contains(1),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedRadioList.add(1); // Add to selected list
                    } else {
                      selectedRadioList.remove(1); // Remove from selected list
                    }
                  });
                },
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                // Your circle avatar widget
              ),
              title: Text(
                'Perci Sue',
                // Your text widget for the name
              ),
              trailing: Checkbox(
                value: selectedRadioList.contains(2),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedRadioList.add(2); // Add to selected list
                    } else {
                      selectedRadioList.remove(2); // Remove from selected list
                    }
                  });
                },
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                // Your circle avatar widget
              ),
              title: Text(
                'Knoxx Jorge',
                // Your text widget for the name
              ),
              trailing: Checkbox(
                value: selectedRadioList.contains(3),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedRadioList.add(3); // Add to selected list
                    } else {
                      selectedRadioList.remove(3); // Remove from selected list
                    }
                  });
                },
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                // Your circle avatar widget
              ),
              title: Text(
                'Elijah Falcon',
                // Your text widget for the name
              ),
              trailing: Checkbox(
                value: selectedRadioList.contains(4),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedRadioList.add(4); // Add to selected list
                    } else {
                      selectedRadioList.remove(4); // Remove from selected list
                    }
                  });
                },
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                // Your circle avatar widget
              ),
              title: Text(
                'Azrael Ty',
                // Your text widget for the name
              ),
              trailing: Checkbox(
                value: selectedRadioList.contains(5),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedRadioList.add(5); // Add to selected list
                    } else {
                      selectedRadioList.remove(5); // Remove from selected list
                    }
                  });
                },
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                // Your circle avatar widget
              ),
              title: Text(
                'Jowey Maru',
                // Your text widget for the name
              ),
              trailing: Checkbox(
                value: selectedRadioList.contains(6),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedRadioList.add(6); // Add to selected list
                    } else {
                      selectedRadioList.remove(6); // Remove from selected list
                    }
                  });
                },
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                // Your circle avatar widget
              ),
              title: Text(
                'Klare Tey',
                // Your text widget for the name
              ),
              trailing: Checkbox(
                value: selectedRadioList.contains(7),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedRadioList.add(7); // Add to selected list
                    } else {
                      selectedRadioList.remove(7); // Remove from selected list
                    }
                  });
                },
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                // Your circle avatar widget
              ),
              title: Text(
                'Vincent Smith ',
                // Your text widget for the name
              ),
              trailing: Checkbox(
                value: selectedRadioList.contains(8),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedRadioList.add(8); // Add to selected list
                    } else {
                      selectedRadioList.remove(8); // Remove from selected list
                    }
                  });
                },
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                // Your circle avatar widget
              ),
              title: Text(
                'Lincon Fume',
                // Your text widget for the name
              ),
              trailing: Checkbox(
                value: selectedRadioList.contains(9),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedRadioList.add(9); // Add to selected list
                    } else {
                      selectedRadioList.remove(9); // Remove from selected list
                    }
                  });
                },
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                // Your circle avatar widget
              ),
              title: Text(
                'Nite Von',
                // Your text widget for the name
              ),
              trailing: Checkbox(
                value: selectedRadioList.contains(10),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedRadioList.add(10); // Add to selected list
                    } else {
                      selectedRadioList.remove(10); // Remove from selected list
                    }
                  });
                },
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                // Your circle avatar widget
              ),
              title: Text(
                'Clara Santa',
                // Your text widget for the name
              ),
              trailing: Checkbox(
                value: selectedRadioList.contains(11),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedRadioList.add(11); // Add to selected list
                    } else {
                      selectedRadioList.remove(11); // Remove from selected list
                    }
                  });
                },
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                // Your circle avatar widget
              ),
              title: Text(
                'John Smith',
                // Your text widget for the name
              ),
              trailing: Checkbox(
                value: selectedRadioList.contains(12),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedRadioList.add(12); // Add to selected list
                    } else {
                      selectedRadioList.remove(12); // Remove from selected list
                    }
                  });
                },
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                // Your circle avatar widget
              ),
              title: Text(
                'Alwayne Legend',
                // Your text widget for the name
              ),
              trailing: Checkbox(
                value: selectedRadioList.contains(13),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedRadioList.add(13); // Add to selected list
                    } else {
                      selectedRadioList.remove(13); // Remove from selected list
                    }
                  });
                },
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                // Your circle avatar widget
              ),
              title: Text(
                'Jhonny Bore',
                // Your text widget for the name
              ),
              trailing: Checkbox(
                value: selectedRadioList.contains(14),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedRadioList.add(14); // Add to selected list
                    } else {
                      selectedRadioList.remove(14); // Remove from selected list
                    }
                  });
                },
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                // Your circle avatar widget
              ),
              title: Text(
                'Queenie Maputi',
                // Your text widget for the name
              ),
              trailing: Checkbox(
                value: selectedRadioList.contains(15),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedRadioList.add(15); // Add to selected list
                    } else {
                      selectedRadioList.remove(15); // Remove from selected list
                    }
                  });
                },
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                // Your circle avatar widget
              ),
              title: Text(
                'Kigai Sue',
                // Your text widget for the name
              ),
              trailing: Checkbox(
                value: selectedRadioList.contains(16),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedRadioList.add(16); // Add to selected list
                    } else {
                      selectedRadioList.remove(16); // Remove from selected list
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
