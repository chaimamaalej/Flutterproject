import 'package:flutter/material.dart';
import 'package:stage/screens/form_child.dart';

import 'form_doctor.dart';

class RoleSelectionPage extends StatelessWidget {
  final String username;
  final String email;
  final String password;

  RoleSelectionPage({required this.username ,required this.email, required this.password});

  void _showInformation(BuildContext context, String message) {
    // Show a dialog or a bottom sheet with the desired information
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Information'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Role'),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FormDoctorPage(
                              username: this.username,
                              email: this.email,
                              password: this.password,
                            )),
                          );
                        },
                        child: Text('Doctor'),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _showInformation(
                        context,
                        'Supervise the progress of the children and provide medical care as needed.',
                      ),
                      icon: Icon(Icons.info, color: Colors.white),
                      tooltip: 'Doctor Information',
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FormParentPage(
                              username: this.username,
                              email: this.email,
                              password: this.password,
                            )),
                          );
                        },
                        child: Text('Parent'),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _showInformation(
                        context,
                        'Create accounts for parents, manage children\'s progress, and provide support.',
                      ),
                      icon: Icon(Icons.info, color: Colors.white),
                      tooltip: 'Parent Information',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
