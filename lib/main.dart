import 'package:boratok/constants.dart';
import 'package:boratok/controllers/auth_controller.dart';
import 'package:boratok/views/screens/auth/login_screen.dart';
import 'package:boratok/views/screens/auth/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
      title: 'BoraTok',
      home: SignUpScreen(),
    );
  }
}
