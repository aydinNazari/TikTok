import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';

import '../../constants.dart';
import '../../controls/video_controller.dart';
import '../../models/video.dart';
import '../screens_auth/comment_screen.dart';

class VideoPlayerItem extends StatefulWidget {
  final Video video;

  const VideoPlayerItem({Key? key,  required this.video}) : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;
  VideoController videoController = VideoController();

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(widget.video.videoUrl)
      ..initialize().then((value) {
        videoPlayerController.play();
        videoPlayerController.setVolume(1);
        videoPlayerController.setLooping(true);
      });
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          Stack(
            children: [
              SizedBox(
                width: size.width,
                height: size.height,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: size.height / 100,
                  ),
                  child: VideoPlayer(
                    videoPlayerController,
                  ),
                ),
              ),
              Positioned(
                right: size.width / 80,
                top: size.height / 3.2,
                child: SizedBox(
                  width: size.width / 8,
                  height: size.width / 7,
                  child: Stack(
                    children: [
                      Container(
                        width: size.width / 8,
                        height: size.width / 8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.video.profilePhotho
                                //widget.video.profilePhotho,
                                //'https://images.unsplash.com/photo-1695504236952-37306fc71896?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzMHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=60',
                                ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -1,
                        right: 0,
                        left: 0,
                        child: Container(
                          width: size.width / 20,
                          height: size.width / 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: buttonColor,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: size.width / 26,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                right: size.width / 80,
                top: size.height / 2.4,
                child: widgetIcon(
                  size,
                  (widget.video.likes).length.toString(),
                  InkWell(
                    onTap: () => videoController.likeVideo(widget.video.id),
                    child: Icon(
                      Icons.favorite,
                      size: size.width / 10,
                      color:
                          widget.video.likes.contains(currentUserCallBack(),)
                              ? Colors.red
                              : Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: size.width / 80,
                top: size.height / 2,
                child: widgetIcon(
                  size,
                  '${widget.video.commentCount}',
                  Padding(
                    padding: EdgeInsets.only(top: size.height / 90),
                    child: InkWell(
                      onTap: () {
                         Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child:  CommentScreen(
                              id: widget.video.id,
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: size.width / 10,
                        child: Image.asset(
                          'assets/logo/coment.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: size.width / 80,
                top: size.height / 1.6,
                child: widgetIcon(
                  size,
                  '0',
                  Icon(
                    Icons.bookmark,
                    size: size.width / 10,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                right: size.width / 35,
                top: size.height / 1.4,
                child: Padding(
                  padding: EdgeInsets.only(top: size.height / 120),
                  child: widgetIcon(
                    size,
                    '${widget.video.shareCount}',
                    Padding(
                      padding: EdgeInsets.only(top: size.height / 90),
                      child: SizedBox(
                        width: size.width / 14,
                        child: Image.asset(
                          'assets/logo/share.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: size.width / 25,
                bottom: size.height / 10,
                child: Text(
                  widget.video.userName,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: size.width / 22,
                  ),
                ),
              ),
              Positioned(
                left: size.width / 25,
                bottom: size.height / 15,
                child: Text(
                  widget.video.caption,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: size.width / 23),
                ),
              ),
              Positioned(
                left: size.width / 25,
                bottom: size.height/25,
                child: Row(
                  children: [
                    Icon(
                      Icons.music_note,
                      color: Colors.white60,
                      size: size.width / 25,
                    ),
                    Text(
                      widget.video.songName,
                      style: TextStyle(
                          color: Colors.white60,
                          fontWeight: FontWeight.w400,
                          fontSize: size.width / 28),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Column widgetIcon(Size size, String textt, Widget widget) {
  return Column(
    children: [
      widget,
      Padding(
        padding: EdgeInsets.only(top: size.height / 150),
        child: Text(textt),
      )
    ],
  );
}
