import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';

class MySearchTextFieldDummy extends StatelessWidget {
  final Function onTap;
  final String text;

  const MySearchTextFieldDummy({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: kColorOne,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(Icons.search, size: 27, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
