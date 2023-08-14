import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stage/screens/login_screen/components/bottom_text.dart';
import 'package:stage/screens/login_screen/components/top_text.dart';
import 'package:ionicons/ionicons.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper_functions.dart';
import '../../role_selection.dart';
import '../animations/change_screen_animations.dart';
import '../../form.dart';
import 'top_text.dart';
import 'package:ionicons/ionicons.dart';

enum Screens {
  createAccount,
  welcomeBack,
}

class LoginContent extends StatefulWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late final List<Widget> createAccountContent;
  late final List<Widget> loginContent;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hasFocus = false;

  void signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null; // Return null if the input is valid
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    // Add additional email validation logic if needed
    return null; // Return null if the input is valid
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    // Add additional password validation logic if needed
    return null; // Return null if the input is valid
  }

  Widget inputField(String hint, IconData iconData,
      {required String? Function(String?) validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          child: TextFormField(
            // Use TextFormField
            validator: validator, // Add the validator function
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              prefixIcon: Icon(iconData),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 16),
      child: ElevatedButton(
        onPressed: () {
          signUserIn();
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: const StadiumBorder(),
          primary: kSecondaryColor,
          elevation: 8,
          shadowColor: Colors.black87,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget formButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 115, vertical: 8),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RoleSelectionPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: const StadiumBorder(),
          primary: kSecondaryColor,
          elevation: 8,
          shadowColor: Colors.black87,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget forgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 110),
      child: TextButton(
        onPressed: () {},
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: kSecondaryColor,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    createAccountContent = [
      inputField('Name', Ionicons.person_outline, validator: validateName),
      inputField('Email', Ionicons.mail_outline, validator: validateEmail),
      inputField('Password', Ionicons.lock_closed_outline,
          validator: validatePassword),
      formButton('Next'),
    ];

    loginContent = [
      inputField('Email', Ionicons.mail_outline, validator: validateEmail),
      inputField('Password', Ionicons.lock_closed_outline,
          validator: validatePassword),
      loginButton('Log In'),
      forgotPassword(),
    ];

    ChangeScreenAnimation.initialize(
      vsync: this,
      createAccountItems: createAccountContent.length,
      loginItems: loginContent.length,
    );

    for (var i = 0; i < createAccountContent.length; i++) {
      createAccountContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.createAccountAnimations[i],
        child: createAccountContent[i],
      );
    }

    for (var i = 0; i < loginContent.length; i++) {
      loginContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.loginAnimations[i],
        child: loginContent[i],
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    ChangeScreenAnimation.dispose();

    super.dispose();
  }

  void saveUserData(String name, String email, String password) async {
    // Get a reference to the "users" collection in Firestore
    /* CollectionReference */ var usersCollection = null;

    try {
      // Save user data as a new document with the email as the document ID
      await usersCollection.doc(email).set({
        'name': name,
        'email': email,
        'password': password,
      });

      // Data saved successfully
      print('User data saved to Firestore');
    } catch (e) {
      // An error occurred while saving data
      print('Error saving user data: $e');
    }
  }

  // Example usage in your login or registration function
  void onRegisterButtonPressed() {
    // Get the name, email, and password from the text fields
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // Call the function to save user data to Firebase
    saveUserData(name, email, password);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Remove focus from text fields when tapping outside
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Stack(
        children: [
          const Positioned(
            top: 136,
            left: 24,
            child: TopText(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 280),
            child: SingleChildScrollView(
              child: Form(
                // Wrap the input fields with Form widget
                key: _formKey,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: createAccountContent,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: loginContent,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: AnimatedOpacity(
                // Use AnimatedOpacity to handle the visibility of the "Already have an account? Log in" text
                opacity: _hasFocus ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: BottomText(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
