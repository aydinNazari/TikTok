import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tiktok_2/constants.dart';
import 'package:tiktok_2/controls/auth_controller.dart';
import 'package:tiktok_2/controls/profile_controller.dart';
import 'package:tiktok_2/controls/video_controller.dart';
import 'package:tiktok_2/views/screens_auth/edite_profile.dart';
import 'package:tiktok_2/views/screens_auth/profile_video_screen.dart';
import 'package:tiktok_2/views/screens_auth/video_screen.dart';
import 'package:tiktok_2/views/widgets/profile_text_widget.dart';
import 'package:tiktok_2/views/widgets/video_player_item.dart';

import '../../models/video.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthController authControllerClass = Get.put(AuthController());
  final ProfileControllers profileControllers = Get.put(ProfileControllers());
  final VideoController videoController = Get.put(VideoController());
  bool isButton = true;

  @override
  void initState() {
    super.initState();
    print('-------------------------------------');
    print(widget.uid);
    print(currentUserCallBack());
    profileControllers.updateUserId(widget.uid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ProfileControllers>(
        init: ProfileControllers(),
        builder: (controller) {
          return controller.user['name'] != null
              ? Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    leading: const Icon(
                      Icons.person_add,
                      color: Colors.white,
                    ),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(right: size.width / 35),
                        child: InkWell(
                            onTap: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  content: InkWell(
                                    onTap: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text(
                                            'Warrning!',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: const Text(
                                              'Are you sure you want to log out?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () async {
                                                await authControllerClass
                                                    .logOut();
                                                setState(() {});
                                              },
                                              child: const Text('Yes'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('No'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: const Text('Log Out!'),
                                  ),
                                ),
                              );
                            },
                            child: const Icon(Icons.more_horiz)),
                      )
                    ],
                    backgroundColor: Colors.black,
                    title: Text(
                      controller.user['name'],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  body: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: size.height / 50),
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: size.width / 4,
                            height: size.width / 4,
                            child: /*const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://plus.unsplash.com/premium_photo-1695219819793-159c4258875'
                        'c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufD'
                        'B8fHx8fA%3D%3D&auto=format&fit=crop&w=1972&q=80',
                      ),
                    ),*/
                                ClipOval(
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                height: size.width / 4,
                                width: size.width / 4,
                                imageUrl: controller.user['profilePhoto'],
                                //placeholder: (context, url) => const CircularProgressIndicator(),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height / 55),
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: size.width / 1.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ProfileTextWidget(
                                    size: size,
                                    txt: 'Following',
                                    count: controller.user['following']),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width / 25),
                                  child: ProfileTextWidget(
                                      size: size,
                                      txt: 'Followers',
                                      count: controller.user['followers']),
                                ),
                                ProfileTextWidget(
                                    size: size,
                                    txt: 'Likes',
                                    count: controller.user['likes']),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width / 35),
                        child: Container(
                          width: size.width,
                          height: size.height / 20,
                          decoration: BoxDecoration(
                            color: widget.uid == authController.user.uid
                                ? Colors.grey
                                : controller.user['isFollowing']
                                    ? buttonColor
                                    : Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                size.width / 65,
                              ),
                            ),
                          ),
                          child: Center(
                            child: InkWell(
                              onTap: isButton
                                  ? () async {
                                      if (widget.uid == currentUserCallBack()) {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type:
                                                PageTransitionType.leftToRight,
                                            child: const Editeprofile(),
                                          ),
                                        );
                                      } else {
                                        isButton = false;
                                        await controller.followUser();
                                        setState(() {});
                                        isButton = true;
                                        setState(() {});
                                      }
                                    }
                                  : null,
                              child: Text(
                                widget.uid == authController.user.uid
                                    ? 'Edit Profile'
                                    : controller.user['isFollowing']
                                        ? 'Follow'
                                        : 'Unfollow',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height / 25),
                        child: SizedBox(
                          width: size.width,
                          height: size.height / 3,
                          child: GridView.builder(
                              itemCount: controller.user['thumbnails'].length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 5),
                              itemBuilder: (context, index) {
                                String thumbnail =
                                    controller.user['thumbnails'][index];
                                return InkWell(
                                  onTap: () async {
                                    /*List<Video> listVideo =*/
                                    await videoController.profileVideoPlayer(
                                      widget.uid,
                                      thumbnail,
                                    );
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.scale,
                                        alignment: Alignment.bottomCenter,
                                        child: ProfileVideoPlayer(),
                                      ),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    height: size.width / 4,
                                    width: size.width / 4,
                                    imageUrl: thumbnail,
                                    //placeholder: (context, url) => const CircularProgressIndicator(),
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
}
