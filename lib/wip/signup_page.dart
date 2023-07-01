import 'package:flutter/material.dart';
import 'package:intro_to_flutter/auth_pages/login_page.dart';
import 'package:intro_to_flutter/wip/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

//do this one.

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  String _email = '';
  String _password = '';

  void _handleLogin() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }

  void _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final newUser = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (newUser != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Signup Successful')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => LoginPage(),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup Failed')),
        );
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email address';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: _handleSignup,
                child: Text('Signup'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  TextButton(
                    onPressed: _handleLogin,
                    child: Text("Have an account? Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}