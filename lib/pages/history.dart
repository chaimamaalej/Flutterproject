import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference gameStatus =
        FirebaseFirestore.instance.collection('game_status');

    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Games played',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              FutureBuilder<QuerySnapshot>(
                future: gameStatus
                    .where('email', isEqualTo: currentUser?.email)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text('No games played yet.');
                  } else {
                    List<QueryDocumentSnapshot<Object?>> playedGames =
                        snapshot.data!.docs;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: playedGames[0]['progressOrdinal'],
                        itemBuilder: (context, index) {
                          // Wrap each game with its score and duration in a box
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Game: ${playedGames[0]['games'][index]}\nScore: ${playedGames[0]['scores'][index]}\nDuration: ${playedGames[0]['durations'][index]}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
