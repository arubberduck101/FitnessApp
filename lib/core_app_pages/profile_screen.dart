import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase/authentication.dart';
import '../firebase/db.dart';
import 'home/home_page.dart';
import '../core_app_pages/learn/learn_screen.dart';
import 'log/log_page.dart';
import '../auth_pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile',
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();

  var _genders = ['Female', 'Male'];
  String? _gender;

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  getInfo() async {
    getUserInfo().then((info) {
      setState(() {
        _gender = info!['gender'];
        _weightController.text = info!['weight'];
        _ageController.text = info!['age'];
        _heightController.text = info!['height'];
      });
    });
  }

  updateInfo() async {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    Map<String, dynamic> userInfo = {
      'Height': double.parse(_heightController.text.trim()),
      'Weight': double.parse(_weightController.text.trim()),
      'Age': int.parse(_ageController.text.trim()),
      'Gender': _gender,
    };

    buildLoading();

    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        print('Not authenticated user.');
        return;
      }

      final userID = currentUser.uid;

      // await editUserInfo(userInfo);
      Navigator.of(context).pop();
      snapBarBuilder('User info edited');

      // Update user info in Firestore
      await FirebaseFirestore.instance
          .collection('Users') // Change this to your collection name
          .doc(userID) // Change this to the user's document ID
          .update(userInfo);
    } catch (e) {
      print('Error updating user info: $e');
      Navigator.of(context).pop();
      snapBarBuilder('Error updating user info');
    }
  }

  buildLoading() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          );
        });
  }

  snapBarBuilder(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onTap(int index) {
    if (index == 0) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }

    if (index == 1) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => LogPage()));
    }

    if (index == 2) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LearnPage()));
    }

    if (index == 3) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ProfilePage()));
    }
  }

  void _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LoginPage()), // Replace LoginPage with your login page
      );
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  Future<void> _confirmDeleteAccount() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Account Deletion'),
          content: Text(
              'Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // Close the dialog
                await _deleteAccount(); // Call the delete account function
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        print('Not authenticated user.');
        return;
      }

      // Delete user data from Firestore
      final userID = currentUser.uid;
      await FirebaseFirestore.instance.collection('Users').doc(userID).delete();

      // Delete the user's Firebase Authentication account
      await currentUser.delete();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LoginPage()), // Replace LoginPage with your login page
      );
    } catch (e) {
      print('Error deleting account: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color.fromARGB(255, 65, 117, 33),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                color: const Color.fromRGBO(227, 219, 218, 1.0),
                height: height * .12,
                child: Image.asset('assets/images/logo.png',
                    fit: BoxFit.fitHeight),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12, top: 20),
                child: Column(
                  children: [
                    const Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(220, 166, 129, 1.0),
                      ),
                    ),
                    Container(
                      height: 3,
                      color: const Color.fromRGBO(80, 80, 74, 1.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: 'Height',
                          hintText: "71 (inches)",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        controller: _heightController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        decoration: InputDecoration(
                          label: const Text('Weight (lbs)'),
                          hintText: "140",
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        controller: _weightController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        decoration: InputDecoration(
                          label: const Text('Age'),
                          hintText: "Age",
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        controller: _ageController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: createRoundedDropDown(width),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ElevatedButton(
                        onPressed: updateInfo,
                        child: Text('Update User Info'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(220, 166, 129, 1.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ElevatedButton(
                        onPressed: _logout,
                        child: Text('Logout'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.red, // Use your preferred color
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ElevatedButton(
                        onPressed: _confirmDeleteAccount,
                        child: Text('Delete Account'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.red, // Use your preferred color
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 65, 117, 33),
        selectedItemColor: Color.fromARGB(255, 2, 50, 10),
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Log',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget createRoundedDropDown(width) {
    return Container(
      width: width * .95,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color.fromRGBO(65, 58, 58, 1.0)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            borderRadius: BorderRadius.circular(10),
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
            hint: Text("Select Gender"),
            value: _gender,
            isDense: true,
            onChanged: (newValue) {
              setState(() {
                _gender = newValue;
              });
            },
            items: _genders.map((document) {
              return DropdownMenuItem<String>(
                value: document,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    document,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(65, 58, 58, 1.0),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
