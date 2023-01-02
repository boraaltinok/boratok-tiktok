import 'package:boratok/constants.dart';
import 'package:boratok/views/screens/auth/login_screen.dart';
import 'package:boratok/views/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor
      ),
      title: 'BoraTok',
      home: SignUpScreen(),
    );
  }
}
