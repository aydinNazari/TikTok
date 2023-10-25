import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_2/controls/video_controller.dart';

import '../widgets/video_player_item.dart';

class VideoScreen extends StatelessWidget {
  final VideoController videoController = Get.put(VideoController());

  VideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          itemCount: videoController.videoList.length,
          scrollDirection: Axis.vertical,
          controller: PageController(
            initialPage: 0,
            viewportFraction: 1,
          ),
          itemBuilder: (context, index) {
            return Stack(
              children: [
                VideoPlayerItem(
                  video: videoController.videoList[index],
                )
              ],
            );
          },
        );
      }),
    );
  }
}
