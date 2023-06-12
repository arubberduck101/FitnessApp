import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Exercise App",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: LoginForm(),
          ),
        ],
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
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
      print("Sucessful login");
    }
    catch(e){
      print("login error");
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email_outlined),
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                  ),
              ),
              
            ),
             validator: (value)  {
              if(value!.isEmpty){
                return "Please Enter your email";
              }
              return null;
            },
            onSaved: (val) {
              email = val;
             
            }
          ),

          SizedBox(
            height: 20,
          ),
          // password
          TextFormField(
            //intialValue: "input text"
            decoration: const InputDecoration(
              
              labelText: "Password",
              prefixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                  ),
              ),
              
            ),
           obscureText: _obscureText,

           validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
            onSaved: (val) {
              password = val;
            },
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
             height: 40,),
             

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          ElevatedButton(
            onPressed: () {
            debugPrint("signup");
            },
            child: Text("No account? Signup here")),

          ElevatedButton(
            onPressed: () async {
              await _login();
            },
            child: Text("Login")),
        ])
        ],
          
        ),
      );

  }
}
