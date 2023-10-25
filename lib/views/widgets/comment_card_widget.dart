import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_2/constants.dart';
import '../../controls/comment_controller.dart';
import '../../models/comment.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentCardWidget extends StatefulWidget {
  final Comment comment;

  const CommentCardWidget({Key? key, required this.comment}) : super(key: key);

  @override
  State<CommentCardWidget> createState() => _CommentCardWidgetState();
}

class _CommentCardWidgetState extends State<CommentCardWidget> {
  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width / 7,
      height: size.height / 8.4,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width / 9,
            height: size.width / 9,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  widget.comment.profilePhoto,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.width / 25,
              left: size.width / 45,
            ),
            child: SizedBox(
              height: size.height / 7,
              width: size.width / 1.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.comment.userName,
                    style: TextStyle(
                      fontSize: size.width / 30,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height / 150,
                    ),
                    child: Text(
                      widget.comment.comment,
                      style: TextStyle(
                        fontSize: size.width / 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        tago.format(
                          widget.comment.datePublished.toDate().toUtc(),
                        ),
                        style: TextStyle(
                          fontSize: size.width / 35,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width / 20),
                        child: Text(
                          '${widget.comment.likes.length} likes',
                          style: TextStyle(
                            fontSize: size.width / 35,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: size.width / 18,
            ),
            child: InkWell(
              onTap: () {
                commentController.likeComment(widget.comment.id);
                setState(() {});
              },
              child: Icon(
                widget.comment.likes.contains(currentUserCallBack())
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: widget.comment.likes.contains(currentUserCallBack())
                    ? Colors.red
                    : Colors.white,
                size: size.width / 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
