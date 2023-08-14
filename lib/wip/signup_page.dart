import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../auth_pages/login_page.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 215, 208, 183),
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Container(
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
                    "Sign Up",
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
                    child: SignupForm(),
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

class SignupForm extends StatefulWidget {
  SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  String? userUID;
  String? exercises;
  String? diet;
  String? username; // Added username field

  bool _obscureText = false;

  bool agree = false;

  final pass = TextEditingController();

  _addUserDetails(String email) async {
    await FirebaseFirestore.instance.collection('Users').doc(userUID).set({
      'Email': email,
      'Name': username,
      'Exercises': exercises,
      'Diet': diet,
      'Height': 0,
      'Weight': 0,
      'Age': 0,
      "Gender": "None"
    });
  }

  Future<void> _signup() async {
    if (agree) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        try {
          final UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: email!, password: password!);

          print("Successful");

          userUID = userCredential.user!.uid;

          _addUserDetails(email!);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => LoginPage(),
            ),
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'email-already-in-use' ||
              e.code == 'invalid-email' ||
              e.code == 'weak-password') {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Invalid Input'),
                  content: Text(e.message ?? 'An error occurred.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Ok'),
                    ),
                  ],
                );
              },
            );
          }
        }
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Accept Policy'),
            content: Text(
                'Please read Terms of Service and Privacy Policy and confirm test.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    }
  }

  void _passInvalid() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Password Invalid'),
          content: Text('Passwords do not match. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void _goToLoginPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              fillColor: Color.fromARGB(50, 96, 93, 83),
              filled: true,
              prefixIcon: Icon(
                Icons.email_outlined,
              ),
              hintText: 'Email',
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
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (val) {
              email = val;
            },
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: pass,
            decoration: InputDecoration(
              fillColor: Color.fromARGB(50, 96, 93, 83),
              filled: true,
              hintText: 'Password',
              prefixIcon: Icon(
                Icons.lock_outline,
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
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            onSaved: (val) {
              password = val;
            },
            obscureText: !_obscureText,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Field empty. Please fill out.';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: InputDecoration(
              fillColor: Color.fromARGB(50, 96, 93, 83),
              filled: true,
              hintText: 'Confirm Password',
              prefixIcon: Icon(
                Icons.lock_outline,
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
            obscureText: true,
            validator: (value) {
              if (value != pass.text) {
                _passInvalid();
                return 'Passwords do not match.';
              }
              if (value!.isEmpty) {
                return 'Field empty. Please fill out.';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: InputDecoration(
              fillColor: Color.fromARGB(50, 96, 93, 83),
              filled: true,
              prefixIcon: Icon(
                Icons.person,
              ),
              hintText: 'Username',
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
            onSaved: (val) {
              debugPrint(username.toString());
              username = val.toString();
              debugPrint(username.toString());
            },
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 20.0),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Checkbox(
                  onChanged: (_) {
                    setState(() {
                      agree = !agree;
                    });
                  },
                  value: agree,
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                    'By creating account, $username agrees to Terms & Conditions and Privacy Policy.'),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _signup,
              child: Text('Signup'),
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
              text: 'Already have an account? ',
              style: TextStyle(
                color: Color.fromARGB(255, 96, 93, 83),
              ),
              children: [
                TextSpan(
                  text: 'Login',
                  style: TextStyle(
                    color: Color.fromARGB(255, 65, 117, 33),
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = _goToLoginPage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: Signup()));
