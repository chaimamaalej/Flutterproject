import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stage/pages/history.dart';
import 'package:stage/pages/informationPage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:stage/screens/login_screen/login_screen.dart';
import 'package:stage/screens/submit_review_page.dart';
import '../components/bottom_nav_bar.dart';
import '../pages/informationPage.dart';
import '../pages/navbar.dart';

class HomePage extends StatefulWidget {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    final currentUser = FirebaseAuth.instance.currentUser!;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<QuerySnapshot>(
      future: users.where('email', isEqualTo: currentUser.email).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          QueryDocumentSnapshot<Object?> data = snapshot.data!.docs[0];
          if (data['role'] == 'parent') {
            return buildParentPage(data);
          }
          return buildDoctorPage(data);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildDoctorPage(QueryDocumentSnapshot<Object?> user) {
    CollectionReference gameStatus =
        FirebaseFirestore.instance.collection('game_status');
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<QuerySnapshot>(
      future: gameStatus.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          List<QueryDocumentSnapshot<Object?>> playedGames =
              snapshot.data!.docs;
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Text('Doctor Dashboard'),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                  ),
                ],
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/doc.jpg'),
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Doctor ${user['firstName']} ${user['lastName']}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "List of User Games",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return FutureBuilder<QuerySnapshot>(
                            future: users
                                .where('email',
                                    isEqualTo: playedGames[index]['email'])
                                .get(),
                            builder: (context2, snapshot2) {
                              if (snapshot2.hasData &&
                                  snapshot2.data!.docs.isNotEmpty) {
                                QueryDocumentSnapshot<Object?> userData =
                                    snapshot2.data!.docs[0];

                                return Card(
                                  elevation: 4,
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child: ListTile(
                                    title: Text(
                                      'User: ${userData['childFirstName']} ${userData['childLastName']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Scores: ${playedGames[index]['scores']}',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          'Durations: ${playedGames[index]['durations']}',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          'Suggested Games: ${playedGames[index]['games']}',
                                          style: TextStyle(fontSize: 14),
                                        ),                                     
                                      ],
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons
                                          .rate_review), // Add an appropriate icon
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SubmitReviewPage(
                                                      email: userData['email'],
                                                      childFirstName:
                                                          userData['childFirstName'],
                                                      age:
                                                          userData['age'],                                                          
                                                      childLastName:
                                                          userData['childLastName'],
                                                      games: playedGames[index]
                                                          ['games'],
                                                      scores: playedGames[index]
                                                          ['scores'],
                                                      durations:
                                                          playedGames[index]
                                                              ['durations'])),
                                        );
                                        // Add your review functionality here
                                      },
                                    ),
                                  ),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildParentPage(QueryDocumentSnapshot<Object?> user) {
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
                  "Welcome ${user['username']}",
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
