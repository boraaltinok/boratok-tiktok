import 'dart:io';
import 'package:boratok/constants.dart';
import 'package:boratok/views/screens/auth/login_screen.dart';
import 'package:boratok/views/screens/home_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:boratok/models/user.dart' as userModel;
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<File?>
      _pickedImage; //this is observable keeps track if the image variable is changed or not
  late Rx<User?> _user; // this is not model user this is FİREBASE AUTH USER

  File? get profilePhoto => _pickedImage.value;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth
        .authStateChanges()); //whenever authStateChanges user value will also change = binding
    ever(_user, _setInitialScreen); //whenever there is change in the user call _setInitialScreen method
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      print('UID IS : ${user.uid}');
      Get.offAll(() => const HomeScreen());
    }
  }

  //upload to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  //pick Image
  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar("Profile Picture", "Successfully selected profile picture");
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  //registering user
  Future<void> registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //save our user to our auth and firebase database(firestore)
        UserCredential credential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        String downloadUrl = await _uploadToStorage(image);
        userModel.User user = userModel.User(
            name: username,
            uid: credential.user!.uid,
            email: email,
            profilePhoto: downloadUrl);

        firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar('Error Creating Account', 'Please enter all the fields');
      }
    } catch (e) {
      Get.snackbar('Error Creating Account', e.toString());
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        print('log success');
      } else {
        Get.snackbar('Error Logging in to Account', 'Fields can not be empty');
      }
    } catch (e) {
      Get.snackbar('Error Logging in to Account', e.toString());
    }
  }
}
