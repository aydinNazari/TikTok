import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_2/constants.dart';
import 'package:tiktok_2/models/user.dart' as model;
import 'package:tiktok_2/views/screens_auth/home_screen.dart';

import '../views/screens_auth/login_signin_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<File?> _pickedImage;


  File? get profilePhoto => _pickedImage.value;
  User get user=> _user.value!;
  late Rx<User?> _user;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(
            () => const LoginScreen(),
      );
    } else {
      Get.offAll(
            () => const HomeScreen(),
      );
    }
  }

  void pickImage() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar(
        'Profile Picture',
        'You have succesessfully selected your profile picture',
      );
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  //upload to firebase storage
  Future<String> _uploadToStorage(File file) async {
    Reference ref = firebaseStorege
        .ref()
        .child('profilePics')
        .child(currentUserCallBack());
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //register the user
  Future<void> registerUser(
      String userName, String email, String password, File? image) async {
    try {
      if (userName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
          name: userName,
          uid: cred.user!.uid,
          email: email,
          profilPhoto: downloadUrl,
        );
        await firebaseFireStore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar('Error creating account', 'Please enter all the fields');
      }
    } catch (e) {
      Get.snackbar(
        'Error creating an account',
        e.toString(),
      );
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        print('Enter is succsessfully');
      } else {
        Get.snackbar('Error', 'Please enter all the fields');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  Future<void> logOut() async {
    await firebaseAuth.signOut();
  }
  Future<String> photoControl() async {
    // var dd= await firebaseFireStore.collection('users').doc(currentUserCallBack()).snapshots();
    DocumentSnapshot userdoc = await firebaseFireStore
        .collection('users')
        .doc(currentUserCallBack())
        .get();
    var dd=(userdoc.data()! as dynamic)['profilePhoto'];
    return dd;
  }
}
