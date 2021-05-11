import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    Key? key,
    required this.validator,
    required this.onChanged,
    required this.labelText,
  }) : super(key: key);

  final Function validator;
  final Function onChanged;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      child: TextFormField(
        cursorColor: Colors.white,
        style: TextStyle(fontSize: 15, color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        obscureText: true,
        validator: validator as String? Function(String?)?,
        onChanged: onChanged as void Function(String)?,
      ),
    );
  }
}
