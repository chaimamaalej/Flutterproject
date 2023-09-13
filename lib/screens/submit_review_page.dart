import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stage/screens/form_child.dart';
import 'package:stage/screens/home_page.dart';

import 'form_doctor.dart';

class SubmitReviewPage extends StatelessWidget {
  final String email;
  final String childFirstName;
  final String childLastName;
  final int age;
  final int mentalScore;
  final String mobileNumber;

  final List<dynamic> scores;
  final List<dynamic> games;
  final List<dynamic> durations;

  SubmitReviewPage(
      {required this.email,
      required this.childFirstName,
      required this.childLastName,
      required this.age,
      required this.scores,
      required this.mobileNumber,
      required this.games,
      required this.mentalScore,
      required this.durations});

  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Use the back icon
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/images/med.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50, bottom: 50),
                    child: Text(
                      'Review page',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fullname: ${childFirstName} ${childLastName}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Age: ${age}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Mobile Number: ${mobileNumber}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'E-mail: ${email}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Mental score: ${mentalScore} (0 best, 30 worst)',
                          style: TextStyle(fontSize: 16),
                        ),
                        DataTable(
                          columns: [
                            DataColumn(
                              label: Text(
                                'Game',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Score',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Duration(ms)',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            games.length,
                            (index) => DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    games[index].toString(),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    scores[index].toString(),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    durations[index].toString(),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: textFieldController,
                    decoration: InputDecoration(
                      labelText: 'Review',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      CollectionReference reviews = FirebaseFirestore.instance
                          .collection('medical_reviews');
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
          ),
        ],
      ),
    );
  }
}
