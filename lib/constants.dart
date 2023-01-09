import 'package:boratok/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


const pages = [
  Text('Home Screen'),
  Text('Messages Screen'),
  Text('Add Page Screen'),
  Text('Messages Screen'),
  Text('Profile Screen'),


];

//COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

//FİREBASE RELATED CONSTANTS
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//CONTROLLERS
var authController = AuthController.instance;