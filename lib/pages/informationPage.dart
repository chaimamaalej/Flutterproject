import 'package:flutter/material.dart';
import 'games.dart';
import 'medicalreview.dart';
import '../pages/navbar.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Button to navigate to GamesPage
              MaterialButton(
                minWidth: 100,
                height: 10,
                padding: EdgeInsets.all(8.0),
                textColor: Colors.white,
                splashColor: Colors.greenAccent,
                elevation: 16.0,
                color: const Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                onPressed: () {
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
                      'assets/images/play.jpg', // Replace with your image path
                      height: 100,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Play',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Button to navigate to MedicalReviewPage
              MaterialButton(
                minWidth: 100,
                height: 10,
                padding: EdgeInsets.all(8.0),
                textColor: Colors.white,
                splashColor: Colors.greenAccent,
                elevation: 16.0,
                color: const Color.fromARGB(255, 255, 255, 255),
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
                      'assets/images/medical.jpg', // Replace with your medical review image path
                      height: 100,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Medical Review',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
