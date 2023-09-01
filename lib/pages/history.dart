import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center( // Center the content vertically and horizontally
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Align the content to the center vertically
            children: [
              // Heading
              const Text(
                'Games played',
                style: TextStyle(fontSize: 20),
              ),
              // Other widgets related to your CartPage
            ],
          ),
        ),
      ),
    );
  }
}
