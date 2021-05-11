import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/widgets/widgets.dart';

class MyPreferredContact extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Function validator;
  final bool whatsApp;
  final bool phoneCallOk;
  final Function onSelectedWhatsApp;
  final Function onSelectedPhoneCallOk;

  const MyPreferredContact({
    Key? key,
    required this.title,
    required this.controller,
    required this.validator,
    required this.whatsApp,
    required this.phoneCallOk,
    required this.onSelectedWhatsApp,
    required this.onSelectedPhoneCallOk,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: kGrey50,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardTitleText(title: title),
            const SizedBox(height: 8),
            MyTextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]'))
              ],
              controller: controller,
              keyboardType: TextInputType.number,
              validator: validator,
              labelText: 'Phone number*',
            ),
            Wrap(
              spacing: 5,
              runSpacing: -8,
              children: [
                FilterChip(
                  label: Text('WhatsApp'),
                  labelStyle:
                      TextStyle(color: whatsApp ? Colors.white : Colors.black),
                  checkmarkColor: Colors.white,
                  selectedShadowColor: kColorOne,
                  selectedColor: kColorOne,
                  selected: whatsApp,
                  onSelected: onSelectedWhatsApp as void Function(bool)?,
                  // onSelected: (value) {
                  //   setState(() {
                  //    whatsApp = value;
                  //   });
                  // },
                ),
                FilterChip(
                  label: Text('Phone Call Ok'),
                  labelStyle: TextStyle(
                      color: phoneCallOk ? Colors.white : Colors.black),
                  checkmarkColor: Colors.white,
                  selectedShadowColor: kColorOne,
                  selectedColor: kColorOne,
                  selected: phoneCallOk,
                  onSelected: onSelectedPhoneCallOk as void Function(bool)?,

                  // onSelected: (value) {
                  //   setState(() {
                  //     phoneCallOk = value;
                  //   });
                  // },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
