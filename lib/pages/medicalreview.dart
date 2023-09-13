import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MedicalReviewPage extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser!;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference reviews =
      FirebaseFirestore.instance.collection('medical_reviews');
  CollectionReference gameStatus =
      FirebaseFirestore.instance.collection('game_status');

  Widget buildReviewList() {
    return FutureBuilder<QuerySnapshot>(
      future: reviews.where('patientEmail', isEqualTo: currentUser.email).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No reviews found.'),
          );
        } else {
          List<QueryDocumentSnapshot<Object?>> reviewsList =
              snapshot.data!.docs;
          return Expanded(
            child: ListView.builder(
              itemCount: reviewsList.length,
              itemBuilder: (BuildContext context, int index) {
                final review = reviewsList[index];

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      'Remark: ${review['content']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Score: ${review['scores']}'),
                        Text(
                          'Duration: ${review['durations']}',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        Text(
                          'Games: ${review['games']}',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        Text(
                          'Doctor email: ${review['doctorEmail']}',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: users.where('email', isEqualTo: currentUser.email).get(),
      builder: (userContext, userSnapshot) {
        if (userSnapshot.hasData && userSnapshot.data!.docs.isNotEmpty) {
          QueryDocumentSnapshot<Object?> data = userSnapshot.data!.docs[0];

          return Scaffold(
            appBar: AppBar(
              title: Text('Medical Reviews Dashboard'),
            ),
            body: Stack(
              children: [
                Image.asset(
                  'assets/images/dct.jpg', 
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 14),
                        Text(
                          'Medical Reviews:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10), // Add some vertical space
                      Container(
                        height: 400, // Set an appropriate height constraint
                        child: buildReviewList(),
                      ),
                      ],
                    ),
                  ),
                ),
              ],
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
