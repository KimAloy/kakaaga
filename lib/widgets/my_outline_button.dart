import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';

class MyOutlineButton extends StatelessWidget {
  final Function? onPressed;
  final String text;
  final Color? textColor;

  const MyOutlineButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed == null ? () => null : onPressed as void Function()?,
      child: Text(text),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: textColor == null ? Colors.black54 : kColorOne),
        primary: textColor == null ? Colors.black54 : textColor,
      ),
    );
  }
}
