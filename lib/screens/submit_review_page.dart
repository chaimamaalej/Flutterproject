import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stage/screens/form_child.dart';

import 'form_doctor.dart';

class SubmitReviewPage extends StatelessWidget {
  final String email;
  final String firstName;
  final String lastName;
  final List<dynamic> scores;
  final List<dynamic> games;
  final List<dynamic> durations;

  SubmitReviewPage(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.scores,
      required this.games,
      required this.durations});

  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Review page',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20), // Add some spacing between text and button
            Text(
              'Fullname: ${firstName} ${lastName}', // Display the email as a TextView
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Scores: ${scores}', // Display the email as a TextView
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Games: ${games}', // Display the email as a TextView
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Durations: ${durations}', // Display the email as a TextView
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
                height:
                    20), // Add some spacing between email TextView and text field
            TextField(
              controller: textFieldController,
              decoration: InputDecoration(
                labelText: 'Review',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
                height: 20), // Add some spacing between text field and button
            ElevatedButton(
              onPressed: () async {
                CollectionReference reviews =
                    FirebaseFirestore.instance.collection('medical_reviews');
                final currentUser = FirebaseAuth.instance.currentUser!;

                await reviews
                    .add({
                      'patientEmail': email,
                      'doctorEmail': currentUser.email,
                      'content': textFieldController.text,
                      'scores': scores,
                      'games': games,
                      'durations': durations,
                    })
                    .then((value) => print("Review created"))
                    .catchError((error) => print("$error"));
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
