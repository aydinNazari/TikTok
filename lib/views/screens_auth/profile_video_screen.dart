import 'package:flutter/material.dart';
import 'package:get/get.dart'; // GetX eklemeyi unutmayın
import '../../controls/video_controller.dart';
import '../widgets/video_player_item.dart';

class ProfileVideoPlayer extends StatelessWidget {
  //final List<Video> videoList;
  final VideoController videoController = Get.find();
 // final videoIndex = 0.obs;

  ProfileVideoPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          itemCount: videoController.profileVideoGet.length,
          scrollDirection: Axis.vertical,
          controller: PageController(
            initialPage: /*videoIndex.value,*/0,
            viewportFraction: 1,
          ),
          itemBuilder: (context, index) {
            return Stack(
              children: [
                VideoPlayerItem(
                  video: videoController.profileVideoGet[index],
                )
              ],
            );
          },
        );
      }),
    );
  }
}
