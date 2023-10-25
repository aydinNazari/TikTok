import 'package:flutter/material.dart';

import '../../constants.dart';

class TextInputField extends StatelessWidget {
  const TextInputField(
      {Key? key,
      required this.hintText,
      required this.labelTextWidget,
      required this.iconWidget,
      required this.obscrueText,
      required this.onchange,
      required this.hintColor})
      : super(key: key);
  final String hintText;
  final Widget labelTextWidget;
  final Widget iconWidget;
  final bool obscrueText;
  final Color hintColor;
  final void Function(String) onchange;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width / 1.1,
      height: size.height / 10,
      child: TextField(
        onChanged: onchange,
        obscureText: obscrueText,
        decoration: InputDecoration(
          hintText: hintText,
          prefix: iconWidget,
          labelStyle: TextStyle(
            color: hintColor,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
          label: labelTextWidget,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
        ),
      ),
    );
  }
}
