import 'package:flutter/material.dart';

import '../../constants.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: InkWell(
            onTap: () => showOptionsDialog(context, size),
            child: Container(
              width: size.width / 4,
              height: size.height / 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    size.width / 50,
                  ),
                ),
                color: Colors.red,
              ),
              child: Center(
                child: Text(
                  'Add Video',
                  style: TextStyle(
                    fontSize: size.width / 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
