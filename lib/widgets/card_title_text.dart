import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';

class CardTitleText extends StatelessWidget {
  final String? title;
  const CardTitleText({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: TextStyle(
        fontSize: 16,
        // color: Colors.black,
        color: kColorOne,
      ),
    );
  }
}
