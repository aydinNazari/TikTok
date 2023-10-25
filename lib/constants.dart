
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tiktok_2/controls/auth_controller.dart';
import 'package:tiktok_2/views/screens_auth/add_video_screen.dart';
import 'package:tiktok_2/views/screens_auth/confim_screen.dart';
import 'package:tiktok_2/views/screens_auth/profile_screen.dart';
import 'package:tiktok_2/views/screens_auth/search_screnn.dart';
import 'package:tiktok_2/views/screens_auth/video_screen.dart';

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;


//Firebase
var firebaseAuth=FirebaseAuth.instance;
var firebaseFireStore=FirebaseFirestore.instance;
var firebaseStorege= FirebaseStorage.instance;


//controller
var authController=AuthController.instance;


List pageList = [
  VideoScreen(),
  //VideoScreen(),
  /*const Center(child: Text('Search Screen')),*/
  const SearchScreen(),
  //const Center(child: Text('Add Video')),
  const AddVideoScreen(),
  const Center(child: Text('Inbox Screen')),
  /*const Center(child: Text('Profile Screen')),*/
  ProfileScreen(uid: currentUserCallBack()),
];



pickVideo(ImageSource src, BuildContext context) async {
  final video = await ImagePicker().pickVideo(source: src);
  if (video != null) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.bottomToTop,
        child: ConfimScreen(
          videoPath: video.path,
        ),
      ),
    );
  }
}


String currentUserCallBack(){
  return firebaseAuth.currentUser!.uid;
}

//showDialog
showOptionsDialog(BuildContext context, Size size) {
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      children: [
        SimpleDialogOption(
          onPressed: () => pickVideo(ImageSource.camera, context),
          child: Row(
            children: [
              const Icon(
                Icons.camera_alt,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: size.width / 45,
                ),
                child: Text(
                  'Camera',
                  style: TextStyle(
                    fontSize: size.width / 20,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: size.height / 50),
          child: SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.gallery, context),
            child: Row(
              children: [
                const Icon(Icons.image),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width / 45,
                  ),
                  child: Text(
                    'Gallery',
                    style: TextStyle(
                      fontSize: size.width / 20,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding:
            EdgeInsets.only(left: size.width / 5, top: size.height / 50),
            child: Text(
              'Cancele',
              style: TextStyle(
                fontSize: size.width / 20,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}