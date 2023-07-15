import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class QuestionnairePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final String parent;
  final int? motherMobileNumber; 
  final int? fatherMobileNumber; 

  QuestionnairePage({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.parent,
    this.motherMobileNumber, 
    this.fatherMobileNumber, 
  });
  @override
  _QuestionnairePageState createState() =>
      _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  Map<int, int> responses = {};

  void _handleResponse(int questionIndex, int response) {
    setState(() {
      responses[questionIndex] = response;
    });
  }

  void _finishQuestionnaire() {
    // Process the responses and perQuestionnaire any required actions
    print(responses);
    // Add your logic here to handle the Questionnaire submission
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information About Your Child'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildQuestion(1, 'Restless or fidgety'),
            _buildQuestion(2, 'Impulsive'),
            _buildQuestion(3, 'Does not finish tasks'),
            _buildQuestion(4, 'Always on the go'),
            _buildQuestion(5, 'Disturbs other children'),
            _buildQuestion(6, 'Easily distracted'),
            _buildQuestion(7, 'Demands must be met immediately, easily frustrated'),
            _buildQuestion(8, 'Cries often and easily'),
            _buildQuestion(9, 'Rapid and marked mood changes'),
            _buildQuestion(10, 'Temper tantrums, explosive and unpredictable behavior'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _finishQuestionnaire,
              child: Text('Finish Registration'),
            ),
          ],
        ),
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
        Row(
          children: [
            _buildResponseButton(questionIndex, 0, 'Not at all'),
            _buildResponseButton(questionIndex, 1, 'A little bit'),
            _buildResponseButton(questionIndex, 2, 'Quite a bit'),
            _buildResponseButton(questionIndex, 3, 'Very much'),
          ],
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

 Widget _buildResponseButton(
  int questionIndex, int responseIndex, String label) {
  final response = responses[questionIndex] ?? -1;
  final isSelected = response == responseIndex;

  return Expanded(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () => _handleResponse(questionIndex, responseIndex),
        style: ButtonStyle(
          backgroundColor: isSelected
              ? MaterialStateProperty.all<Color>(Colors.red)
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : null,
          ),
        ),
      ),
    ),
  );
}}