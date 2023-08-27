// ParentInfoPage.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'QuestionnairePage.dart';

class ParentInfoPage extends StatefulWidget {
  final bool showMotherFields;
  final bool showFatherFields;
  final String parentRole;
  final String title;
  final String username;
  final String email;
  final String password;
  final String childFirstName;
  final String childLastName;
  final int? childAge;

  ParentInfoPage({
    required this.showMotherFields,
    required this.showFatherFields,
    required this.parentRole,
    required this.title,
    required this.childFirstName,
    required this.childLastName,
    required this.childAge,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  _ParentInfoPageState createState() => _ParentInfoPageState();
}

class _ParentInfoPageState extends State<ParentInfoPage> {
  bool _isMessageEnabled = false;
  bool _isMailEnabled = false;
  bool _isSMSEnabled = false;
  int? motherMobileNumber;
  int? fatherMobileNumber;
  final TextEditingController _parentFirstNameController =
      TextEditingController();
  final TextEditingController _parentLastNameController =
      TextEditingController();
  final TextEditingController _mobileNumberController =
      TextEditingController();

  String username = '';
  String email = '';
  String password = '';
  String childFirstName = '';
  String childLastName = '';
  int? childAge;
  String parentRole = '';

  @override
  void initState() {
    super.initState();
    username = widget.username;
    email = widget.email;
    password = widget.password;
    childFirstName = widget.childFirstName;
    childLastName = widget.childLastName;
    childAge = widget.childAge;
    parentRole = widget.parentRole;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                        controller: _mobileNumberController,
                        keyboardType: TextInputType.number,
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
                            motherMobileNumber = int.tryParse(value);
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
                        controller: _parentFirstNameController,
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
                        controller: _parentLastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the last name of the father';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: _mobileNumberController,
                        keyboardType: TextInputType.number,
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
                            fatherMobileNumber = int.tryParse(value);
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
                ),
                if (_isMessageEnabled)
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuestionnairePage(
                          firstName: _parentFirstNameController.text,
                          lastName: _parentLastNameController.text,
                          childFirstName: childFirstName,
                          childLastName: childLastName,
                          childAge: childAge,
                          parentRole: parentRole,
                          username: username,
                          email: email,
                          password: password,
                          mobileNumber: _mobileNumberController.text,
                        ),
                      ),
                    );
                  },
                  child: Text('Start Questionnaire'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
