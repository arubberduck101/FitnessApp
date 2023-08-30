// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intro_to_flutter/core_app_pages/profile_screen.dart';
import 'package:intro_to_flutter/firebase/db.dart';
import 'package:intro_to_flutter/core_app_pages/home/home_page.dart';
import 'signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 215, 208, 183),
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
                maxWidth: 400), // Set a maximum width for the content
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 20.0),
                children: [
                  Image.asset(
                    'assets/images/fitnessappimage.png',
                    width: 250,
                    height: 250,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 96, 93, 83),
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: LoginForm(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  bool _obscureText = true;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email!, password: password!);
        print("Successful login");
        String userUID = userCredential.user!.uid; // Get the user UID

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
        );
      } catch (e) {
        print("Login error: ${e.toString()}");
      }
    }
  }

  void _goToSignUpPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Signup()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // email
          TextFormField(
            // initialValue: 'Input text',
            decoration: InputDecoration(
              fillColor: Color.fromARGB(50, 96, 93, 83),
              filled: true,
              hintText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 65, 117, 33),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter your email";
              }
              return null;
            },
            onSaved: (val) {
              email = val;
            },
          ),

          SizedBox(height: 20.0),

          // password
          TextFormField(
            // initialValue: 'Input text',
            decoration: InputDecoration(
              fillColor: Color.fromARGB(50, 96, 93, 83),
              filled: true,
              hintText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Color.fromARGB(255, 65, 117, 33),
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 65, 117, 33),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
            ),
            obscureText: _obscureText,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter your password";
              }
              return null;
            },
            onSaved: (val) {
              password = val;
            },
          ),

          SizedBox(height: 40.0),

          Container(
            height: 40,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 65, 117, 33),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      100.0), // Set the same border radius as the text field
                ),
              ),
            ),
          ),

          SizedBox(height: 20.0),

          RichText(
            text: TextSpan(
              text: 'Don\'t have an account? ',
              style: TextStyle(
                color: Color.fromARGB(255, 96, 93, 83),
              ),
              children: [
                TextSpan(
                  text: 'Sign Up',
                  style: TextStyle(
                    color: Color.fromARGB(255, 65, 117, 33),
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = _goToSignUpPage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
