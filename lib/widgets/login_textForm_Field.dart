import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';

class LoginTextFormField extends StatelessWidget {
  final Function? onChanged;
  final validator;
  final String labelText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  const LoginTextFormField({
    Key? key,
    this.onChanged,
    required this.validator,
    required this.labelText,
    this.obscureText,
    this.keyboardType,
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 17),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: labelText,
        contentPadding: EdgeInsets.fromLTRB(5, 11, 5, 11),
        border: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kColorTwo),
        ),
      ),
      obscureText: obscureText!,
      validator: validator,
      onChanged: onChanged as void Function(String)?,
    );
  }
}
