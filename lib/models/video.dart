import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String userName;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilePhotho;

  Video({
    required this.userName,
    required this.thumbnail,
    required this.uid,
    required this.likes,
    required this.caption,
    required this.commentCount,
    required this.id,
    required this.profilePhotho,
    required this.shareCount,
    required this.songName,
    required this.videoUrl,
  });

  Map<String, dynamic> toJson() =>
      {
        'userName': userName,
        'uid': uid,
        'profilePhoto': profilePhotho,
        'likes': likes,
        'caption': caption,
        'commentCount': commentCount,
        'id': id,
        'shareCount': shareCount,
        'songName': songName,
        'videoUrl': videoUrl,
        'thumbnail': thumbnail
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;
    return Video(userName: snapShot['userName'],
        thumbnail: snapShot['thumbnail'],
        uid: snapShot['uid'],
        likes: snapShot['likes'],
        caption: snapShot['caption'],
        commentCount: snapShot['commentCount'],
        id: snapShot['id'],
        profilePhotho: snapShot['profilePhoto'],
        shareCount: snapShot['shareCount'],
        songName: snapShot['songName'],
        videoUrl: snapShot['videoUrl']);
  }
}
