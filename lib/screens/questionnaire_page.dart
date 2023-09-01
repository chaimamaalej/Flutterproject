import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_page.dart';

class QuestionnairePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final int? childAge;
  final String parentRole;
  final String mobileNumber;
  final String username;
  final String email;
  final String password;
  final String childFirstName;
  final String childLastName;

  QuestionnairePage({
    required this.firstName,
    required this.lastName,
    required this.childAge,
    required this.childFirstName,
    required this.childLastName,
    required this.parentRole,
    required this.mobileNumber,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  Map<int, int> responses = {};

  void _handleResponse(int questionIndex, int response) {
    setState(() {
      responses[questionIndex] = response;
    });
  }

  String username = '';
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  int? age;
  String parentRole = '';
  String mobileNumber = '';
  String childFirstName = '';
  String childLastName = '';

  @override
  void initState() {
    super.initState();
    username = widget.username;
    email = widget.email;
    password = widget.password;
    firstName = widget.firstName;
    lastName = widget.lastName;
    parentRole = widget.parentRole;
    mobileNumber = widget.mobileNumber;
    age = widget.childAge;
    childFirstName = widget.childFirstName;
    childLastName = widget.childLastName;
  }

  List<String> getGames(List<String> questionnaire) {
    List<String> games = [];

    int total = 0;

    for (String item in questionnaire) {
      int value = int.parse(item);
      total += value;
    }
    double average = total / 10;

    if (average < 3) {
      return ['spiral', 'letter_r'];
    }
    if (average <= 5) {
      return ['circle', 'star'];
    }
    if (average <= 7) {
      return ['square', 'triangle'];
    }

    return ['checkmark'];
  }

  void _finishQuestionnaire() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user != null) {
      User? user = userCredential.user;
      await user?.updateDisplayName(username);
    }

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    CollectionReference gameStatus =
        FirebaseFirestore.instance.collection('game_status');

    List<String> questionnaire = [];
    for (int i = 0; i < controllers.length; i++) {
      questionnaire.add(controllers[i].text);
    }

    await users
        .add({
          'role': 'parent',
          'username': username,
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'age': age,
          'parentRole': parentRole,
          'mobileNumber': mobileNumber,
          'childFirstName': childFirstName,
          'childLastName': childLastName,
          'questionnaire': questionnaire
        })
        .then((value) => print("User created"))
        .catchError((error) => print("$error"));

    await gameStatus
        .add({
          'email': email,
          'games': getGames(questionnaire),
          'scores': [],
          'durations': [],
          'progressOrdinal': 0
        })
        .then((value) => print("Game status created"))
        .catchError((error) => print("$error"));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Successfully registered'),
          content: Text('Your user is created'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the popup
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  List<TextEditingController> controllers = List.generate(
    10, // Number of questions
    (index) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information About Your Child'),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/form.jpg'), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                _buildQuestion(1, 'Restless or fidgety'),
                _buildQuestion(2, 'Impulsive'),
                _buildQuestion(3, 'Does not finish tasks'),
                _buildQuestion(4, 'Always on the go'),
                _buildQuestion(5, 'Disturbs other children'),
                _buildQuestion(6, 'Easily distracted'),
                _buildQuestion(
                    7, 'Demands must be met immediately, easily frustrated'),
                _buildQuestion(8, 'Cries often and easily'),
                _buildQuestion(9, 'Rapid and marked mood changes'),
                _buildQuestion(10,
                    'Temper tantrums, explosive and unpredictable behavior'),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _finishQuestionnaire,
                  child: Text('Finish Registration'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion(int questionIndex, String question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$questionIndex. $question',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Column(
          children: [
            _buildResponseRadio(
                questionIndex, 0, 'Not at all', controllers[questionIndex - 1]),
            _buildResponseRadio(questionIndex, 1, 'A little bit',
                controllers[questionIndex - 1]),
            _buildResponseRadio(questionIndex, 2, 'Quite a bit',
                controllers[questionIndex - 1]),
            _buildResponseRadio(
                questionIndex, 3, 'Very much', controllers[questionIndex - 1]),
          ],
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildResponseRadio(int questionIndex, int responseIndex, String label,
      TextEditingController controller) {
    final response = responses[questionIndex] ?? -1;
    final isSelected = response == responseIndex;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.05),
      child: RadioListTile<int>(
        value: responseIndex,
        groupValue: response,
        onChanged: (value) {
          _handleResponse(questionIndex, value!);
          controller.text = value.toString();
          setState(() {});
        },
        title: Text(
          label,
          style: TextStyle(
            fontSize: 13.0,
            color: isSelected ? Colors.red : null,
          ),
        ),
        selectedTileColor: Colors.red,
        activeColor: Colors.red,
      ),
    );
  }
}
