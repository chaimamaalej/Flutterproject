import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stage/pages/history.dart';
import 'package:stage/pages/informationPage.dart';
import 'package:audioplayers/audioplayers.dart';
import '../components/bottom_nav_bar.dart';
import '../pages/history.dart';
import '../pages/informationPage.dart';
import '../pages/navbar.dart';

class ParentHomePage extends StatefulWidget {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  _ParentHomePageState createState() => _ParentHomePageState();
}

class _ParentHomePageState extends State<ParentHomePage> {
  int _selectedIndex = 0;
  bool isMusicOn =
      true; // Tracc:\src\geometry2\lib\components\bottom_nav_bar.dart c:\src\geometry2\lib\components\figure_tile.dartk the state of the music toggle
  late AudioPlayer audioPlayer;
  String audioFilePath =
      'assets/mixkit-a-happy-child-532.mp3'; // Replace with the actual path
  Color _backgroundColor = Colors.blue; // Default background color

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    if (isMusicOn) {
      playAudio(); // Start playing audio if music is on
    }
  }

  Future<void> playAudio() async {
    int result = await audioPlayer.play(audioFilePath, isLocal: true);

    if (result == 1) {
      print('Music playing');
    } else {
      print('Error playing music');
    }
  }

  Future<void> stopAudio() async {
    int result = await audioPlayer.stop();

    if (result == 1) {
      print('Music stopped');
    } else {
      print('Error stopping music');
    }
  }

  void toggleMusicState(bool newState) {
    setState(() {
      isMusicOn = newState;
      if (isMusicOn) {
        playAudio();
      } else {
        stopAudio();
      }
    });
  }

  void setBackgroundColor(Color color) {
    setState(() {
      _backgroundColor = color;
    });
  }

  void navigateBottomBar(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  final List<Widget> _pages = [
    const InformationPage(),
    const HistoryPage(),
  ];

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      drawer: NavBar(
        isMusicOn: isMusicOn,
        setMusicState: toggleMusicState,
        setBackgroundColor: setBackgroundColor,
      ),
      appBar: AppBar(
        title: Text(''),
        backgroundColor: _backgroundColor,
      ),
      backgroundColor: _backgroundColor,
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: [
                Text(
                  'Welcome ${user.displayName!}',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'GloriaHallelujah',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser!;
//     return Scaffold(
//       appBar: AppBar(title: Text('Home')),
//       body: Padding(
//         padding: EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Logged in as',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 16),
//             Text(
//               user.email!,
//               style: TextStyle(fontSize: 16),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
