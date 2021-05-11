import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/widgets/widgets.dart';

class Description extends StatelessWidget {
  final TextEditingController? controller;
  final Function? onChanged;
  final double? height;
  final String title;
  final String hintText;

  const Description({
    Key? key,
    this.controller,
    this.onChanged,
    this.height,
    required this.title,
    required this.hintText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: kGrey50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardTitleText(title: title),
            const SizedBox(height: 8),
            MultiLineTextField(
              controller: controller,
              onChanged: onChanged,
              height: height == null ? 200 : height,
              keyboardType: TextInputType.multiline,
              maxLines: 999,
              hintText: hintText,
              validator: null,
            ),
          ],
        ),
      ),
    );
  }
}
