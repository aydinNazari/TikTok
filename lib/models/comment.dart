import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String userName;
  String comment;
  Timestamp datePublished;
  List likes;
  String profilePhoto;
  String uid;
  String id;

  Comment(
      {required this.likes,
      required this.id,
      required this.uid,
      required this.userName,
      required this.comment,
      required this.profilePhoto,
      required this.datePublished});

  Map<String, dynamic> toJson() => {
        'username': userName,
        'comment': comment,
        'datePublished': datePublished,
        'likes': likes,
        'profilePhoto': profilePhoto,
        'uid': uid,
        'id': id
      };

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
      userName: snapshot['username'],
      comment: snapshot['comment'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      id: snapshot['id'],
    );
  }
}
