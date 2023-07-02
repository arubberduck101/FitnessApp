// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../auth_pages/login_page.dart';

// import 'firebase/authentication.dart';

// import 'authentication.dart';
// import 'home_screen.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Color(0xFFE7A563),
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(50.0),
      //       bottomRight: Radius.circular(50.0),
      //     ),
      //   ),
      //   toolbarHeight: 180,
      //   flexibleSpace: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       GestureDetector(
      //         onTap: () => Navigator.pop(context),
      //         child: const Padding(
      //           padding: EdgeInsets.only(left: 10.0),
      //           child: Icon(Icons.arrow_back),
      //         ),
      //       ),
      //       Center(
      //         child: Container(
      //           height: 85,
      //           width: 110,
      //           decoration: const BoxDecoration(
      //             image: DecorationImage(
      //                 image: AssetImage('assets/images/fitnessappimage.png'),
      //                 fit: BoxFit.cover),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),

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

  bool _obscureText = false;

  bool agree = false;

  final pass = new TextEditingController();

  Future<void> _signup() async {
    if (agree) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        // try {
        //   if (agree) {
        //     UserCredential userCredential = await FirebaseAuth.instance
        //         .createUserWithEmailAndPassword(
        //             email: email!, password: password!);
        //     print("Sucessful login");
        //     Navigator.pushReplacement(
        //         context,
        //         MaterialPageRoute(
        //             builder: (BuildContext context) => LoginPage()));
        //   }
        // } catch (e) {
        //   print("Login error: ${e.toString()}");
        // }
        try {
          final UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: email!, password: password!);
          print("Successful");
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
                  content: Text(e.message ?? 'An error occured.'),
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
                'Please read Terms of Service and Privacy Policy and confirm.'),
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
          // email
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

          // password
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
          // confirm passwords
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
          // name

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
                    'By creating account, I agree to Terms & Conditions and Privacy Policy.'),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),

          // signUP button
          // SizedBox(
          //   height: 40,
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     onPressed: () {
          //       // comment this block after you setup the Firebase
          //       Navigator.pushReplacement(context,
          //           MaterialPageRoute(builder: (context) => LoginPage()));

          //       //uncomment this block after you set up the Firebase
          //       // if (_formKey.currentState!.validate()) {
          //       //   _formKey.currentState!.save();
          //       //
          //       //   AuthenticationHelper()
          //       //       .signUp(email: email!, password: password!)
          //       //       .then((result) {
          //       //     if (result == null) {
          //       //       Navigator.pushReplacement(context,
          //       //           MaterialPageRoute(builder: (context) => RoutePage()));
          //       //     } else {
          //       //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //       //         content: Text(
          //       //           result,
          //       //           style: TextStyle(fontSize: 16),
          //       //         ),
          //       //       ));
          //       //     }
          //       //   });
          //       // }
          //     },
          //     style: ElevatedButton.styleFrom(
          //         backgroundColor: Color.fromARGB(255, 65, 117, 33),
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.all(Radius.circular(24.0)))),
          //     child: Text('Sign Up'),
          //   ),
          // ),

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
