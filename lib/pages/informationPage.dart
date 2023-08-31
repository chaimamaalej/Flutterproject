import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'games.dart';
import 'medicalreview.dart';


class InformationPage extends StatefulWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const SizedBox(height: 80),

            // Button to navigate to GamesPage
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GamesPage(),
                  ),
                );
              },
              child: Text("Let's Play"),
            ),

            const SizedBox(height: 20),

            // Button to navigate to MedicalReviewPage
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicalReviewPage(),
                  ),
                );
              },
              child: Text("Medical Review"),
            ),
          ],
        ),
      ),
    );
  }
}
