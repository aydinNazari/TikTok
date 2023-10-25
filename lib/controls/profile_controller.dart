import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_2/constants.dart';

class ProfileControllers extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});

  Map<String, dynamic> get user => _user.value;
  final Rx<String> _uid = ''.obs;

  updateUserId(String uid) {
    /*print('7777777777777777777777777777777777');
    print(uid);
    print(currentUserCallBack());*/
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    List<String> thumbline = [];
    var myVideos = await firebaseFireStore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();
    for (int i = 0; i < myVideos.docs.length; i++) {
      thumbline.add((myVideos.docs[i].data() as dynamic)['thumbnail']);
    }
    DocumentSnapshot userDoc =
    await firebaseFireStore.collection('users').doc(_uid.value).get();
    final userData = userDoc.data()! as dynamic;
    String name = userData['name'];
    String profilePhoto = userData['profilePhoto'];
    int like = 0;
    int followers = 0;
    int following = 0;
    bool? isFollowing;

    for (var item in myVideos.docs) {
      like += (item.data()['likes'] as List).length;
    }

    var followersDoc = await firebaseFireStore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();
    var followingDoc = await firebaseFireStore
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();
    followers = followersDoc.docs.length;
    following = followingDoc.docs.length;
    firebaseFireStore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(currentUserCallBack())
        .get()
        .then((value) => {
      if (value.exists) {isFollowing = true} else {isFollowing = false}
    });
    isFollowing ??= false;
    // print('************************************** $isFollowing *********************************');
    _user.value = {
      'followers': followers.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'likes': like.toString(),
      'profilePhoto': profilePhoto.toString(),
      'name': name,
      'thumbnails': thumbline
    };
    update();
  }

  followUser() async {
    var doc = await firebaseFireStore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(currentUserCallBack())
        .get();
    if (!doc.exists) {
      await firebaseFireStore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(currentUserCallBack())
          .set({});
      await firebaseFireStore
          .collection('users')
          .doc(currentUserCallBack())
          .collection('following')
          .doc(_uid.value)
          .set({});
      _user.value.update(
        'followers',
            (value) => (int.parse(value) + 1).toString(),
      );
    }else{
      await firebaseFireStore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(currentUserCallBack())
          .delete();
      await firebaseFireStore
          .collection('users')
          .doc(currentUserCallBack())
          .collection('following')
          .doc(_uid.value)
          .delete();
      _user.value.update(
        'followers',
            (value) => (int.parse(value) - 1).toString(),
      );
    }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }
}
