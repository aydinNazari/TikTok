import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_2/constants.dart';

import '../models/comment.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);

  List<Comment> get commenta => _comments.value;
  String _postId = "";

  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async {
    _comments.bindStream(
      await firebaseFireStore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .snapshots()
          .map(
        (QuerySnapshot querySnapshot) {
          List<Comment> retValue = [];
          for (var element in querySnapshot.docs) {
            retValue.add(Comment.fromSnap(element));
          }
          return retValue;
        },
      ),
    );
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userdoc = await firebaseFireStore
            .collection('users')
            .doc(currentUserCallBack())
            .get();
        var allDoc = await firebaseFireStore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();
        int len = allDoc.docs.length;
        Comment comment = Comment(
          likes: [],
          id: 'Comment $len',
          uid: (userdoc.data()! as dynamic)['uid'],
          userName: (userdoc.data()! as dynamic)['name'],
          comment: commentText.trim(),
          profilePhoto: (userdoc.data()! as dynamic)['profilePhoto'],
          datePublished: Timestamp.fromDate(DateTime.now()),
        );
        await firebaseFireStore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('Comment $len')
            .set(comment.toJson());
        DocumentSnapshot doc =
            await firebaseFireStore.collection('videos').doc(_postId).get();
        await firebaseFireStore.collection('videos').doc(_postId).update({
          'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
        });
      }
    } catch (e) {
      Get.snackbar('error post comment', e.toString());
    }
  }

  likeComment(String id) async {
    var uid = authController.user.uid;
    DocumentSnapshot doc = await firebaseFireStore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firebaseFireStore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await firebaseFireStore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }
}

/*
*  try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userdoc = await firebaseFireStore
            .collection('users')
            .doc(authController.user.uid)
            .get();
        var allDoc = await firebaseFireStore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();
        int len = allDoc.docs.length;
        Comment comment = Comment(
            likes: [],
            id: 'Comment $len',
            uid: (userdoc.data()! as dynamic)['uid'],
            userName: (userdoc.data()! as dynamic)['name'],
            comment: commentText.trim(),
            profilePhoto: (userdoc.data()! as dynamic)['profilePhoto'],
            datePublished: DateTime.now()
        );
        await firebaseFireStore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('Comment $len')
            .set(comment.toJson());
        DocumentSnapshot doc =
            await firebaseFireStore.collection('videos').doc(_postId).get();
        await firebaseFireStore.collection('videos').doc(_postId).update({
          'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
        });
      }
    } catch (e) {
      Get.snackbar('Error while commenting', e.toString());
    }*/
