import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';

class ActionButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final EdgeInsetsGeometry padding;
  final Color? color;

  const ActionButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.padding,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
        onPressed: onPressed as void Function()?,
        style: ElevatedButton.styleFrom(
          primary: kColorTwo,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            )),
      ),
    );
  }
}
