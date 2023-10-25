import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width / 7,
      height: size.height / 18,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: Container(
              width: size.width / 12,
              height: size.height / 18,
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  250,
                  45,
                  108,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    size.width / 48,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: Container(
              width: size.width / 12,
              height: size.height / 18,
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  32,
                  211,
                  234,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    size.width / 48,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      size.width / 48,
                    ),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: size.width / 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
