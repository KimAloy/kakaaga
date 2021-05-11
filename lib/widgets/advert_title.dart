import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/widgets/widgets.dart';

class AdvertTitle extends StatelessWidget {
  final TextEditingController controller;

  const AdvertTitle({
    Key? key,
    required this.controller,
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
            CardTitleText(title: "Advert's Title*"),
            const SizedBox(height: 8),
            MultiLineTextField(
                controller: controller,
                height: 80,
                keyboardType: TextInputType.multiline,
                maxLines: 999,
                hintText: 'Enter a short title...',
                fontWeight: FontWeight.bold,
                validator: (value) =>
                    value.isEmpty ? 'Please enter an Advert Title*' : null),
          ],
        ),
      ),
    );
  }
}
