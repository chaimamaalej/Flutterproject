import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MedicalReviewPage extends StatelessWidget {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<QuerySnapshot>(
      future: users.where('email', isEqualTo: currentUser.email).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          QueryDocumentSnapshot<Object?> data = snapshot.data!.docs[0];

          List<Map<String, dynamic>> reviews = [
            {
              'score': 85,
              'duration': '5 minutes',
              'doctorRemark': 'Good progress in focusing.',
              'games': ['spiral', 'letter_r'],
              'doctor': 'John Smith',
            },
            {
              'score': 92,
              'duration': '2 minutes',
              'doctorRemark': 'Impressive attention span.',
              'games': ['spiral', 'letter_r'],
              'doctor': 'Emma Johnson',
            },
            {
              'score': 78,
              'duration': '9 minutes',
              'doctorRemark': 'Needs improvement in concentration.',
              'games': ['spiral', 'letter_r'],
              'doctor': 'David Anderson',
            },
          ];

          return Scaffold(
            appBar: AppBar(
              title: Text('Medical Reviews Dashboard'),
            ),
            body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, ${data['firstName']}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Medical Reviews:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: reviews.length,
                      itemBuilder: (BuildContext context, int index) {
                        final review = reviews[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              'Remark: ${review['doctorRemark']}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Score: ${review['score']}'),
                                Text(
                                  'Duration: ${review['duration']}',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  'Games: ${review['games'].join(', ')}',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  'Doctor: ${review['doctor']}',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
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
}
