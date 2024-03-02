import "package:flutter/material.dart";

class mediafilesGC extends StatefulWidget {
  const mediafilesGC({super.key});

  @override
  State<mediafilesGC> createState() => _mediafilesGCState();
}

class _mediafilesGCState extends State<mediafilesGC> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        backgroundColor: const Color(0xFF9BB8CD),
        appBar: AppBar(
          backgroundColor: const Color(0xFF9BB8CD),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 35),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Media, files, and links',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Media'),
              Tab(text: 'Files'),
              Tab(text: 'Links'),
            ],
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            // Contents of the 'Members' tab
            Center(
              child: Text(
                'Media Tab Content',
                style: TextStyle(fontSize: 20),
              ),
            ),
            // Contents of the 'Admins' tab
            Center(
              child: Text(
                'files Tab Content',
                style: TextStyle(fontSize: 20),
              ),
            ),
            // Contents of the 'Admins' tab
            Center(
              child: Text(
                'links Tab Content',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
