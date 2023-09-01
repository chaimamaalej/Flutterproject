import 'package:flutter/material.dart';
import 'games.dart';
import 'medicalreview.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const SizedBox(height: 80),

            // Button to navigate to GamesPage
            MaterialButton(
              minWidth: 200,
              height: 40,
              padding: EdgeInsets.all(8.0),
              textColor: Colors.white,
              splashColor: Colors.greenAccent,
              elevation: 16.0,
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              onPressed: () {
                // Add your navigation logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GamesPage(),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/ADHD.jpg', // Replace with your image path
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Play',
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                  SizedBox(height: 6),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Button to navigate to MedicalReviewPage
            // Button to navigate to MedicalReviewPage
            MaterialButton(
              minWidth: 200,
              height: 60,
              padding: EdgeInsets.all(8.0),
              textColor: Colors.white,
              splashColor: Colors.greenAccent,
              elevation: 16.0,
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              onPressed: () {
                // Add your navigation logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicalReviewPage(),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/play.jpg', // Replace with your medical review image path
                    height: 100,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Medical Review',
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                  SizedBox(height: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
