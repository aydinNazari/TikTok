import 'package:flutter/material.dart';

class ProfileTextWidget extends StatelessWidget {
  final Size size;
  final String txt;
  final String count;

  const ProfileTextWidget(
      {Key? key, required this.size, required this.txt, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width / 5,
      height: size.width / 5,
      child: Column(
        children: [

          Text(
            count,
            style: TextStyle(
              fontSize: size.width / 20,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height/85),
            child: Text(
              txt,
              style: TextStyle(
                fontSize: size.width / 25,
                color: Colors.grey,
                fontWeight: FontWeight.w400
              ),
            ),
          ),
        ],
      ),
    );
  }
}
