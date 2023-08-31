import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stage/screens/QuestionnairePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stage/screens/home_page_parent.dart';
import 'package:stage/screens/login_screen/login_screen.dart';
import 'form_parent.dart';
import 'package:stage/screens/home_page_parent.dart';
import 'dart:io';

class FormDoctorPage extends StatefulWidget {
  final String username;
  final String email;
  final String password;
  FormDoctorPage(
      {required this.username, required this.email, required this.password});

  @override
  _FormDoctorPageState createState() => _FormDoctorPageState();
}

class _FormDoctorPageState extends State<FormDoctorPage> {
  XFile? image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _faxController = TextEditingController();
  TextEditingController _currentPositionController = TextEditingController();
  TextEditingController _medicalSchoolController = TextEditingController();
  TextEditingController _praxisAddressController = TextEditingController();

  bool _isMale = false;
  bool _isFemale = false;
  bool _formSubmitted = false;

  String username = '';
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    username = widget.username;
    email = widget.email;
    password = widget.password;
  }

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img;
    try {
      img = await picker.pickImage(source: media);
    } catch (e) {
      print(e);
    }

    setState(() {
      image = img;
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _faxController.dispose();
    _currentPositionController.dispose();
    _medicalSchoolController.dispose();
    _praxisAddressController.dispose();
    super.dispose();
  }

  String? _validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    return null;
  }

  String? _validateSex() {
    if (!_isMale && !_isFemale) {
      return 'Please select your sex';
    }
    return null;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() && _isSexSelected()) {
      // Form is valid, process the data or save to the database
      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;
      String address = _addressController.text;
      String phoneNumber = _phoneNumberController.text;
      String fax = _faxController.text;
      String currentPosition = _currentPositionController.text;
      String medicalSchool = _medicalSchoolController.text;
      String praxisAddress = _praxisAddressController.text;

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      CollectionReference users = FirebaseFirestore.instance.collection('users');

      await users
          .add({
            'role': 'doctor',
            'firstName': firstName,
            'lastName': lastName,
            'address': address,
            'phoneNumber': phoneNumber,
            'fax': fax,
            'currentPosition': currentPosition,
            'medicalScchool': medicalSchool,
            'praxisAddress': praxisAddress,
            'username': username,
            'email': email,
            })
          .then((value) => print("User created"))
          .catchError((error) => print("$error"));

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Successfuly registered'),
            content: Text('Please return to the login page'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the popup
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  bool _isSexSelected() {
    return _isMale || _isFemale;
  }

  String _getSelectedSex() {
    if (_isMale) {
      return 'Male';
    } else if (_isFemale) {
      return 'Female';
    }
    return '';
  }

  void _onMaleChanged(bool? value) {
    setState(() {
      _isMale = value ?? false;
      if (_isMale) {
        _isFemale = false;
      }
    });
  }

  void _onFemaleChanged(bool? value) {
    setState(() {
      _isFemale = value ?? false;
      if (_isFemale) {
        _isMale = false;
      }
    });
  }

  void myAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text('Please choose media to select'),
          content: Container(
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      Text('From Gallery'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.camera),
                      Text('From Camera'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageDisplay() {
    return image != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(image!.path),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 300,
              ),
            ),
          )
        : Text(
            "No Image",
            style: TextStyle(fontSize: 10),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Form'),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/form_doctor.jpg'), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Doctor Information Form:',
                      style: TextStyle(
                        fontSize: 18,
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
                    validator: (value) => _validateField(value, 'first name'),
                  ),
                  SizedBox(height: 6.0),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                    ),
                    validator: (value) => _validateField(value, 'last name'),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                    ),
                    validator: (value) => _validateField(value, 'address'),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                    ),
                    validator: (value) => _validateField(value, 'phone number'),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _faxController,
                    decoration: InputDecoration(
                      labelText: 'Fax',
                    ),
                    validator: (value) => _validateField(value, 'fax'),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Sex:',
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
                        value: _isMale,
                        onChanged: _onMaleChanged,
                      ),
                      Text('Male'),
                      Checkbox(
                        value: _isFemale,
                        onChanged: _onFemaleChanged,
                      ),
                      Text('Female'),
                    ],
                  ),
                  if (_formSubmitted && !_isSexSelected())
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Please select your sex',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Professional Information:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _currentPositionController,
                    decoration: InputDecoration(
                      labelText: 'Current Position',
                    ),
                    validator: (value) =>
                        _validateField(value, 'current position'),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _medicalSchoolController,
                    decoration: InputDecoration(
                      labelText: 'Medical School of Graduation',
                    ),
                    validator: (value) =>
                        _validateField(value, 'medical school of graduation'),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _praxisAddressController,
                    decoration: InputDecoration(
                      labelText: 'Address of the Praxis',
                    ),
                    validator: (value) =>
                        _validateField(value, 'address of the praxis'),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      myAlert();
                    },
                    child: Text('Upload your degree'),
                  ),
                  SizedBox(height: 10),

                  // Display the selected image or "No Image"
                  _buildImageDisplay(),

                  SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _formSubmitted = true;
                        });
                        _submitForm();
                      },
                      child: Text('Submit form'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
