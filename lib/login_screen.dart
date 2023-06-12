// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.all(8.0),
      children: <Widget>[
        const SizedBox(
          height: 50,
        ),

        // Text component --> align the text in the center, and make it bold and make font size 30
        const Text("Exercise App",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),

        Padding(padding: EdgeInsets.all(16.0), child: LoginForm()),
      ],
    ));
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // email
          TextFormField(
              // initialValue: 'Input text',
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100.0),
                  ),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your email";
                }
                return null;
              },
              onSaved: (val) {
                email = val;
              }),

          SizedBox(
            height: 20,
          ),
          // password
          TextFormField(
            // initialValue: 'Input text',
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
            ),

            obscureText: _obscureText,
          ),

          ElevatedButton(
              onPressed: () {
                setState(() {
                  _obscureText = false;
                });
              },
              child: Text("Show Password")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _obscureText = true;
                });
              },
              child: Text("Hide Password")),

SizedBox(
  height: 40,
),
SizedBox(
  height: 40,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center, 
    children: [
      ElevatedButton(
        onPressed: () {
          setState(() {
            _obscureText = true;
          });
        },
        child: Text("Sign up"),
      ),
      SizedBox(width: 10), 
      ElevatedButton(
        onPressed: () {
          setState(() {
            _obscureText = true;
          });
        },
        child: Text("Login"),
      ),
    ],
  ),
),

    ]
    )
    );
  }
}
