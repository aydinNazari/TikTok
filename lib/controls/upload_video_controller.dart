import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_2/models/video.dart';
import 'package:video_compress/video_compress.dart';

import '../constants.dart';

class UploadVideoController extends GetxController {
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = currentUserCallBack();
      DocumentSnapshot userDoc =
          await firebaseFireStore.collection('users').doc(uid).get();
      var allDoc = await firebaseFireStore.collection('videos').get();
      int len = allDoc.docs.length;
      String videoUrl = await _uploadVideoToStorage('video $len', videoPath);
      String thumbnail = await _uploadImageToStorage('video $len', videoPath);
      Video video = Video(
        userName: (userDoc.data()! as Map<String, dynamic>)['name'],
        thumbnail: thumbnail,
        uid: uid,
        likes: [],
        caption: caption,
        commentCount: 0,
        id: 'video $len',
        profilePhotho:
            (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
        shareCount: 0,
        songName: songName,
        videoUrl: videoUrl,
      );
      await firebaseFireStore
          .collection('videos')
          .doc('video $len')
          .set(video.toJson());
      List<Video> list= await _videosAllDoc();
      print('****************************************************');
      for(var element in list){
        print('${element.userName}-${element.songName}-${element.caption}');

      }
      print('****************************************************');
      Get.back();
    } catch (e) {
      Get.snackbar('Error uploading video', e.toString());
    }
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorege.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbmnails(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbmnails(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorege.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _compressVideo(String videoPath) async {
    final compressVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressVideo!.file;
  }

//geçici
  Future<List<Video>> _videosAllDoc() async {
    var allDoc= await firebaseFireStore.collection('videos').get();
    List<Video> list=[];
    for(var element in allDoc.docs){
      list.add( Video.fromSnap(element));
    }
    return list;
  }
}

