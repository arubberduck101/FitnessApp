// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../wip/home_screen2.dart';
import '../wip/signup_page.dart';

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
        print("Sucessful login");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      } catch (e) {
        print("Login error: ${e.toString()}");
      }
    }
  }

  void _goToSignUpScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
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
                    color: Theme.of(context).primaryColorDark,
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
              }),

          SizedBox(height: 40.0),

          Container(
            width:
                double.infinity, // Set the width to occupy the available space
            child: ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
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
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = _goToSignUpScreen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
