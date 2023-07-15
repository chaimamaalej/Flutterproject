import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stage/screens/QuestionnairePage.dart';

import 'ParentInfo.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  int? _selectedAge;
  bool _isMale = false;
  bool _isFemale = false;
  bool _isParentMother = false;
  bool _isParentFather = false;

  List<int> _ages = List<int>.generate(17, (index) => index + 2); // List of ages from 2 to 18

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;
      int? age = _selectedAge;
      String gender = _getSelectedGender();
      String parent = _getParentName();

      // Now you can use the collected data for further processing

      if (_isParentMother || _isParentFather) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ParentInfoPage(
              showMotherFields: _isParentMother,
              showFatherFields: _isParentFather,
              parentName: parent,
              title: 'Parent Information',
            ),
          ),
        );
      } else {
        // Navigate to the next page without parent information
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionnairePage(
              firstName: firstName,
              lastName: lastName,
              age: age ?? 0,
              gender: gender,
              parent: parent,
            ),
          ),
        );
      }
    }
  }

  String _getSelectedGender() {
    if (_isMale) {
      return 'Male';
    } else if (_isFemale) {
      return 'Female';
    }
    return '';
  }

  String _getParentName() {
    if (_isParentMother && _isParentFather) {
      return 'Both Parents';
    } else if (_isParentMother) {
      return 'Mother';
    } else if (_isParentFather) {
      return 'Father';
    }
    return '';
  }

  void _onParentMotherChanged(bool? value) {
    setState(() {
      _isParentMother = value ?? false;
    });
  }

  void _onParentFatherChanged(bool? value) {
    setState(() {
      _isParentFather = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'To generate perfect and suitable games for your child, you have to fill in this questionnaire:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'The information of your child:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 6.0),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 6.0),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'The age of your child:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              DropdownButtonFormField<int>(
                value: _selectedAge,
                items: _ages.map((int age) {
                  return DropdownMenuItem<int>(
                    value: age,
                    child: Text(age.toString()),
                  );
                }).toList(),
                onChanged: (int? value) {
                  setState(() {
                    _selectedAge = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Age',
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select the age of your child';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Checkbox(
                    value: _isMale,
                    onChanged: (value) {
                      setState(() {
                        _isMale = value!;
                        if (_isMale) {
                          _isFemale = false;
                        }
                      });
                    },
                  ),
                  Text('Male'),
                  Checkbox(
                    value: _isFemale,
                    onChanged: (value) {
                      setState(() {
                        _isFemale = value!;
                        if (_isFemale) {
                          _isMale = false;
                        }
                      });
                    },
                  ),
                  Text('Female'),
                ],
              ),
              SizedBox(height: 8.0),
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Who is responsible for the child:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Checkbox(
                    value: _isParentMother,
                    onChanged: _onParentMotherChanged,
                  ),
                  Text('Mother'),
                  Checkbox(
                    value: _isParentFather,
                    onChanged: _onParentFatherChanged,
                  ),
                  Text('Father'),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                margin: EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
