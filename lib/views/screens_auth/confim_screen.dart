import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_2/controls/upload_video_controller.dart';
import 'package:video_player/video_player.dart';

import '../widgets/text_input_field.dart';

class ConfimScreen extends StatefulWidget {
  //final File videoFile;
  final String videoPath;

  const ConfimScreen({Key? key, required this.videoPath})
      : super(key: key);

  @override
  State<ConfimScreen> createState() => _ConfimScreenState();
}

class _ConfimScreenState extends State<ConfimScreen> {
  late VideoPlayerController controller;
  late String _songText;
  late String _captionText;
  UploadVideoController uploadVideoController = Get.put(
      UploadVideoController());


  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(File(widget.videoPath));
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 25,
            ),
            Stack(
              children: [
                SizedBox(
                  width: size.width,
                  height: size.height,
                  child: VideoPlayer(controller),
                ),
                Positioned(
                  bottom: size.height / 25,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height / 50,
                      ),
                      SizedBox(
                        width: size.width - 20,
                        child: TextInputField(
                          hintText: 'Song name',
                          labelTextWidget: const Text('Song Name'),
                          iconWidget: const Icon(Icons.music_note),
                          obscrueText: false,
                          onchange: (String text) {
                            setState(() {
                              _songText = text;
                            });
                          },
                          hintColor: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: size.width - 20,
                        child: TextInputField(
                          hintColor: Colors.black,
                          hintText: 'Caption',
                          labelTextWidget: const Text('Caption'),
                          iconWidget: const Icon(Icons.subtitles),
                          obscrueText: false,
                          onchange: (String text) {
                            setState(() {
                              _captionText = text;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: size.height / 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          /*uploadVideoController.uploadVideo(
                            _songText, _captionText, widget.videoPath),*/

                          uploadVideoController.uploadVideo(
                              _songText, _captionText, widget.videoPath);

                        },
                        child: const Text(
                          'Share!',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
