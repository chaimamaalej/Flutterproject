import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'figures/checkmark.dart';
import 'figures/circle.dart';
import 'figures/spiral.dart';
import 'figures/square.dart';
import 'figures/star.dart';
import 'figures/triangle.dart';
import 'figures/letter_r.dart';

class GamesPage extends StatefulWidget {
  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {

  Widget gamesCompleted() {
  return Scaffold(
    appBar: AppBar(
      title: Text('Congratulations!'),
    ),
    body: Center(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/kid.jpg'),
            fit: BoxFit.cover, // Adjust the fit as needed
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Align text to the top
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20), // Add some space at the top
              Text(
                'You finished all the games, well done!',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Lumanosimo',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Go and check the medical reviews.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lumanosimo',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Add any additional widgets here if needed
            ],
          ),
        ),
      ),
    ),
  );
}


  bool showBackgroundImage = false;

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    CollectionReference gameStatus =
        FirebaseFirestore.instance.collection('game_status');

    return FutureBuilder<QuerySnapshot>(
      future: gameStatus.where('email', isEqualTo: currentUser.email).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          QueryDocumentSnapshot<Object?> data = snapshot.data!.docs[0];

          int index = data['progressOrdinal'];

          if (index == data['games'].length) {
            return gamesCompleted();
          }
          String currentGame = data['games'][index];
          switch (currentGame) {
            case 'star':
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Star()),
              );
              break;
            case 'circle':
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Circle()),
              );
              break;
            case 'spiral':
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Spiral()),
              );
              break;
            case 'letter_r':
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LettreR()),
              );
              break;
            case 'square':
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Square()),
              );
              break;
            case 'triangle':
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Triangle()),
              );
              break;
            case 'checkmark':
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Checkmark()),
              );
              break;
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
