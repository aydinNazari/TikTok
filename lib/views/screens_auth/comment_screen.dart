import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_2/controls/auth_controller.dart';

import '../../controls/comment_controller.dart';
import '../widgets/comment_card_widget.dart';

class CommentScreen extends StatefulWidget {
  final String id;

  CommentScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  void initState() {
    super.initState();
    profileImageURL = '';
    profileImageUpload();
  }

  Future<void> profileImageUpload() async {
    profileImageURL = await authController.photoControl();
    setState(() {});

    //return profileImageURL;
  }

  CommentController commentController = Get.put(CommentController());

  AuthController authController = Get.put(AuthController());

  TextEditingController textEditingController = TextEditingController();

  late String profileImageURL;

  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(widget.id);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Obx(
              () {
                return ListView.builder(
                  itemCount: commentController.commenta.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final commentt = commentController.commenta[index];
                    return CommentCardWidget(
                      comment: commentt,
                    );
                  },
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
            child: Container(
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            width: size.width,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:  EdgeInsets.only(right: size.width/30),
                    child: Container(
                      height: size.height / 15,
                      width: size.width / 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            profileImageURL,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    child: TextField(
                      controller: textEditingController,
                      decoration: const InputDecoration(
                        hintText: 'Add comment...',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: InkWell(
                      onTap: () {
                        commentController
                            .postComment(textEditingController.text);
                        textEditingController.clear();
                      },
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: size.width / 20,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
