import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
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
    );
  }
}
