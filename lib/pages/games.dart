import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  int level = 1;
  int score = 0;
  Color? backgroundColor = Colors.deepPurple[200]; // Default background color

  final List<Color> colorChoices = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.deepPurple[200]!,
  ];

  int currentColorIndex =
      4; // Index of the default color in the colorChoices list

  void changeBackgroundColor() {
    setState(() {
      currentColorIndex = (currentColorIndex + 1) % colorChoices.length;
      backgroundColor = colorChoices[currentColorIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    CollectionReference gameStatus =
        FirebaseFirestore.instance.collection('game_status');

    return FutureBuilder<QuerySnapshot>(
      future: gameStatus.where('email', isEqualTo: currentUser.email).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          QueryDocumentSnapshot<Object?> data = snapshot.data!.docs[0];

          print(data['progressOrdinal']);
          print(data['games']);

          int index = data['progressOrdinal'];
 
          if (index == data['games'].length) {
            return Text(
              'You finished all the games, well done. Return to the home page',
              style: TextStyle(fontSize: 20),
            );
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
        return Text(
          'loading',
          style: TextStyle(fontSize: 20),
        );
      },
    );
  }
}
