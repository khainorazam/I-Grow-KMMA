import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:flutter_group9/maininterface.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/scheduler.dart';
import 'network_utils/api.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MainInterface(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.lightGreen.shade100,
        appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/igrowicon.png',
            fit: BoxFit.contain,
            height: 70,
            width: 250,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 20,
            color: Colors.black,
          ),
        ),
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: const <Widget>[
                          SizedBox(height: 70,),
                          Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 60, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Login to your account",
                            style:
                                TextStyle(fontSize: 15, color: Colors.lightGreen),
                          )
                        ],
                      ),
                      SizedBox(height: 70.0),
                
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(
                                  Icons.email,
                                  color: const Color(0xFF8BC34A),
                                ),
                                title: TextFormField(
                                  decoration: const InputDecoration(
                                      hintText: "Email",
                                      hintStyle: TextStyle(
                                          fontSize: 15.0, color: Colors.lightGreen),
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailTextController,
                                  focusNode: _focusEmail,
                                  validator: (emailValue) {
                                    if (emailValue == null) {
                                      return null;
                                    }
                                    if (emailValue.isEmpty) {
                                      return 'Email can\'t be empty';
                                    }
                                    return null;
                                  },
                                ),
                                tileColor: Colors.white,
                              ),
                              SizedBox(height: 8.0),
                              ListTile(
                                leading: Icon(
                                  Icons.lock,
                                  color: const Color(0xFF8BC34A),
                                ),
                                title: TextFormField(
                                  decoration: const InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                          fontSize: 15.0, color: Colors.lightGreen),
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _passwordTextController,
                                  focusNode: _focusPassword,
                                  obscureText: true,
                                  validator: (emailValue) {
                                    if (emailValue == null) {
                                      return null;
                                    }
                                    if (emailValue.isEmpty) {
                                      return 'Password can\'t be empty';
                                    } else if (emailValue.length < 6) {
                                      return 'Enter a password with length at least 6';
                                    }
                                    return null;
                                  },
                                ),
                                tileColor: Colors.white,
                              ),
                              SizedBox(height: 50.0),
                              _isProcessing
                                  ? CircularProgressIndicator()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 10,
                                                primary: Colors.lightGreen,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 50,
                                                        vertical: 20),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50))),
                                            onPressed: () async {
                                              _focusEmail.unfocus();
                                              _focusPassword.unfocus();
                
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  _isProcessing = true;
                                                });
                
                                                User? user = await FireAuth
                                                    .signInUsingEmailPassword(
                                                  email:
                                                      _emailTextController.text,
                                                  password:
                                                      _passwordTextController
                                                          .text,
                                                );
                
                                                setState(() {
                                                  _isProcessing = false;
                                                });
                
                                                if (user != null) {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          MainInterface(
                                                              user: user),
                                                    ),
                                                  );
                                                }
                                              }
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 40),
                                              child: Text(
                                                "Login",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class FireAuth {
  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: "Wrong Email and Password",
        toastLength: Toast.LENGTH_LONG,
      );
    }

    return user;
  }
}
