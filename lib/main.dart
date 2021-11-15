import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group9/welcome.dart';

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
