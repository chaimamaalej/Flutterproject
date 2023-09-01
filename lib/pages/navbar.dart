import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:stage/screens/home_page.dart';
import 'package:stage/screens/login_screen/components/login_content.dart';
import '../screens/login_screen/login_screen.dart';


class NavBar extends StatefulWidget {
  final bool isMusicOn;
  final Function(bool) setMusicState;
  final Function(Color) setBackgroundColor;

  const NavBar({
    Key? key,
    required this.isMusicOn,
    required this.setMusicState,
    required this.setBackgroundColor,
  }) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Color _selectedColor = Colors.blue;
  List<Color> colorOptions = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];

  void _changeBackgroundColor() {
    setState(() {
      int currentIndex = colorOptions.indexOf(_selectedColor);
      int nextIndex = (currentIndex + 1) % colorOptions.length;
      _selectedColor = colorOptions[nextIndex];
      widget.setBackgroundColor(
          _selectedColor); // Call the callback to update homepage color
    });
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              '',
              style: TextStyle(fontSize: 26),
            ),
            accountEmail: Align(
              alignment: Alignment.bottomLeft,
              child: FutureBuilder<QuerySnapshot>(
                future: users.where('email', isEqualTo: user.email).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    QueryDocumentSnapshot<Object?> data =
                        snapshot.data!.docs[0];
                    return Text(
                      '${data['childFirstName']} ${data['childLastName']}',
                      style: TextStyle(fontSize: 20),
                    );
                  }
                  return Text(
                    'loading',
                    style: TextStyle(fontSize: 20),
                  );
                },
              ),
            ),
            decoration: BoxDecoration(
              color: _selectedColor,
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/ADHD.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text(
              'Background Color',
              style: TextStyle(fontSize: 20), // Set the font size correctly
            ),
            onTap:
                _changeBackgroundColor, // Call the function to change the background color
          ),
          ListTile(
            leading: Icon(Icons.music_note), // Add the icon here
            title: Row(
              children: [
                Text(
                  'Music',
                  style: TextStyle(fontSize: 20), // Adjust the font size here
                ),
                SizedBox(width: 8), // Add spacing between "Music" and status
                Text(
                  widget.isMusicOn ? 'On' : 'Off',
                  style: TextStyle(
                    color: widget.isMusicOn ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            trailing: Switch(
              value: widget.isMusicOn,
              onChanged: (newValue) {
                widget.setMusicState(
                    newValue); // Use the callback to update the state
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Log Out',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pop(context); // Close the drawer
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ],
      ),
    );
  }
}
