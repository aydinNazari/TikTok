import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_2/constants.dart';
import 'package:tiktok_2/models/video.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  final Rx<List<Video>> _profileVideos = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;
  List<Video> get profileVideoGet => _profileVideos.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(_getVideosStream());
    _profileVideos.bindStream(_getVideosStream());


  }
  Stream<List<Video>> _getVideosStream() {
    return firebaseFireStore.collection('videos').snapshots().map(
          (QuerySnapshot query) {
        List<Video> retVal = [];
        for (var element in query.docs) {
          retVal.add(Video.fromSnap(element));
        }
        return retVal;
      },
    );
  }

  Future<void> likeVideo(String id) async {
    DocumentSnapshot doc =
    await firebaseFireStore.collection('videos').doc(id).get();
    var uid = authController.user.uid;
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firebaseFireStore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await firebaseFireStore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }

  Future<void> profileVideoPlayer(String uid, String thumbline) async {
    print(uid);
    print(thumbline);
    print(_profileVideos.value.length);
    print('--------------------------');
    for(var element in _profileVideos.value){
      print(element.uid);
      print(element.userName);
    }
    _profileVideos.value.length;
    Video video;
    List<Video> listVideo=[];
    for (var element in _profileVideos.value) {
      if(uid == element.uid && element.thumbnail == thumbline) {
        video = Video(
          userName: element.userName,
          thumbnail: thumbline,
          uid: uid,
          likes: element.likes,
          caption: element.caption,
          commentCount: element.commentCount,
          id: element.id,
          profilePhotho: element.profilePhotho,
          shareCount: element.shareCount,
          songName: element.songName,
          videoUrl: element.videoUrl,
        );
        listVideo.add(video);
      }
    }
    for(var element in _profileVideos.value){
      if(element.uid == uid && element.thumbnail != thumbline){
        video = Video(
          userName: element.userName,
          thumbnail: thumbline,
          uid: uid,
          likes: element.likes,
          caption: element.caption,
          commentCount: element.commentCount,
          id: element.id,
          profilePhotho: element.profilePhotho,
          shareCount: element.shareCount,
          songName: element.songName,
          videoUrl: element.videoUrl,
        );
        listVideo.add(video);
      }
    }
    print('////////////////');
    print(listVideo.length);
    _profileVideos.value.clear();
    //_profileVideos.value=listVideo;
    _profileVideos.value.addAll(listVideo);
   // return _profileVideos.value;
   // return Future.error("Video bulunamadı");
  }
}
