// ParentInfoPage.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'QuestionnairePage.dart';

class ParentInfoPage extends StatefulWidget {
  final bool showMotherFields;
  final bool showFatherFields;
  final String parentName;
  final String title;

  ParentInfoPage({
    required this.showMotherFields,
    required this.showFatherFields,
    required this.parentName,
    required this.title,
  });

  @override
  _ParentInfoPageState createState() => _ParentInfoPageState();
}

class _ParentInfoPageState extends State<ParentInfoPage> {
  bool _isMessageEnabled = false;
  bool _isMailEnabled = false;
  bool _isSMSEnabled = false;
  String parentName = '';
  int? motherMobileNumber;
  int? fatherMobileNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Parent Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            if (widget.showMotherFields)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mother Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'First Name of the Mother',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the first name of the mother';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Last Name of the Mother',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the last name of the mother';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the mother\'s email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    keyboardType: TextInputType.number, // Set the keyboard type to number
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the mother\'s mobile number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        motherMobileNumber = int.tryParse(value); // Parse the input as an integer
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            if (widget.showFatherFields)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Father Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'First Name of the Father',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the first name of the father';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Last Name of the Father',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the last name of the father';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the father\'s email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    keyboardType: TextInputType.number, // Set the keyboard type to number
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the father\'s mobile number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        fatherMobileNumber = int.tryParse(value); // Parse the input as an integer
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            CheckboxListTile(
              value: _isMessageEnabled,
              onChanged: (value) {
                setState(() {
                  _isMessageEnabled = value ?? false;
                });
              },
              title: Text(
                  'Do you want to be regularly informed by a message of the progress of your child?'),
            ),if (_isMessageEnabled) // Only show the following options if the message is enabled
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How do you want to be informed?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Checkbox(
                        value: _isMailEnabled,
                        onChanged: (value) {
                          setState(() {
                            _isMailEnabled = value ?? false;
                          });
                        },
                      ),
                      Text('Per Mail'),
                      Checkbox(
                        value: _isSMSEnabled,
                        onChanged: (value) {
                          setState(() {
                            _isSMSEnabled = value ?? false;
                          });
                        },
                      ),
                      Text('Per SMS'),
                    ],
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            SizedBox(height: 26.0),
            ElevatedButton(
              onPressed: () {
                // Implement the logic to save the parent information or navigate to the next page.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionnairePage(
                      firstName: '',
                      lastName: '',
                      age: 0,
                      gender: '',
                      parent: parentName,
                      motherMobileNumber: motherMobileNumber, // Pass the mother's mobile number as an integer
                      fatherMobileNumber: fatherMobileNumber, // Pass the father's mobile number as an integer
                    ),
                  ),
                );
              },
              child: Text('Start Questionnaire'),
            ),
          ],
        ),
      ),
    );
  }
}
