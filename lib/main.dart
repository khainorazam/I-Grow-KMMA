import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group9/login.dart';
import 'package:flutter_group9/maininterface.dart';
import 'package:flutter_group9/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter AppDev',
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        backgroundColor: Colors.lightGreen.shade100,
        splash: Image.asset('assets/loading.png'),
        duration: 1000,
        splashTransition: SplashTransition.rotationTransition,
        nextScreen: const HomePage(),
      ),
    ),
  );
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = const MainInterface();
    } else {
      child = const Login();
    }
    return Scaffold(
      body: child,
    );
  }
}
