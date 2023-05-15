import 'package:flutter/material.dart';
import 'package:intro_to_flutter/signup_screen.dart';
import 'package:intro_to_flutter/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // Implement your login logic here
  }

  void _handleRegister() {
    // Implement your register logic here
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color.fromARGB(255, 239, 239, 239)),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 180,
                width: 180,
                
              ),
              SizedBox(height: 50),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: "Username",
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => {
                    Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) => HomeScreen()))
                    },
                    
                    
                    child: Text("Login"),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    onPressed: () => {
                      Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) => SignupScreen()))
                    },
                    child: const Text("Need an account? Register"),
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
