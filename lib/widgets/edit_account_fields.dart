import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/widgets/widgets.dart';

class EditPasswordAccountFields extends StatelessWidget {
  final Function onChanged1;
  final Function onChanged2;
  final Function onChanged3;
  final Function validator1;
  final Function validator2;
  final Function validator3;
  final String title;

  const EditPasswordAccountFields({
    Key? key,
    required this.title,
    required this.onChanged1,
    required this.onChanged2,
    required this.onChanged3,
    required this.validator1,
    required this.validator2,
    required this.validator3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kColorTwo,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PasswordTextFormField(
              validator: validator1,
              onChanged: onChanged1,
              labelText: 'Enter old password*',
            ),
            const SizedBox(height: 7),
            ForgotPassword(color: Colors.white),
            const SizedBox(height: 7),
            PasswordTextFormField(
              validator: validator2,
              onChanged: onChanged2,
              labelText: 'Enter new password',
            ),
            const SizedBox(height: 15),
            PasswordTextFormField(
              validator: validator3,
              onChanged: onChanged3,
              labelText: 'Confirm new password*',
            ),
          ],
        ),
      ),
    );
  }
}

class EditAccountFields extends StatelessWidget {
  final TextEditingController controller;
  // final Function onChanged;
  final String title;
  final String hintText;
  final IconData icon;

  const EditAccountFields({
    Key? key,
    required this.title,
    required this.hintText,
    required this.controller,
    // required this.onChanged,
    required this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: kColorTwo,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 15),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.5,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            EditAccountTextField(
              controller: controller,
              // onChanged: onChanged,
              height: 38,
              hintText: hintText,
              fontSize: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class EditAccountTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Function? onChanged;
  final String hintText;
  final double height;
  final fontWeight;
  final double? fontSize;
  final keyboardType;
  final inputFormatters;
  final prefixIcon;
  final onSubmitted;
  final textInputAction;
  final prefixStyle;

  const EditAccountTextField({
    Key? key,
    required this.hintText,
    required this.height,
    this.fontSize,
    this.controller,
    this.onChanged,
    this.fontWeight,
    this.keyboardType,
    this.inputFormatters,
    this.prefixIcon,
    this.onSubmitted,
    this.textInputAction,
    this.prefixStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.words,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      controller: controller,
      onChanged: onChanged as void Function(String)?,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.white,
        fontWeight: fontWeight,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        // filled: true,
        // fillColor: Colors.white,
        isDense: true,
        hintText: hintText,
        prefixIcon: prefixIcon,
        prefixStyle: prefixStyle,
        hintStyle: TextStyle(color: Colors.white, fontSize: 13.5),
        contentPadding: EdgeInsets.fromLTRB(5, 11, 5, 11),
        border: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            width: 1,
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
