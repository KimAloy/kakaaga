import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key? key,
    required this.validator,
    this.onChanged,
    this.labelText,
    required this.controller,
    this.inputFormatters,
    this.keyboardType,
    this.maxLines,
  }) : super(key: key);

  final Function? validator;
  final Function? onChanged;
  final String? labelText;
  final TextEditingController controller;
  final inputFormatters;
  final TextInputType? keyboardType;
  final maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      onChanged: onChanged as void Function(String)?,
      keyboardType: keyboardType,
      controller: controller,
      cursorColor: kColorOne,
      style: TextStyle(fontSize: 15),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: labelText,
        contentPadding: EdgeInsets.fromLTRB(5, 11, 5, 11),
        isDense: true,
        // labelStyle: TextStyle(color: Palette.colorOne),
        border: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.black38,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kColorOne),
        ),
      ),
      inputFormatters: inputFormatters,
      validator: validator as String? Function(String?)?,
      // onChanged: onChanged,
    );
  }
}

class MyTextFormFieldOnChanged extends StatelessWidget {
  const MyTextFormFieldOnChanged({
    Key? key,
    required this.validator,
    this.onChanged,
    this.labelText,
    this.inputFormatters,
    this.keyboardType,
    this.maxLines,
    this.initialValue,
  }) : super(key: key);

  final Function? validator;
  final Function? onChanged;
  final String? labelText;
  final inputFormatters;
  final TextInputType? keyboardType;
  final maxLines;
  final initialValue;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      onChanged: onChanged as void Function(String)?,
      keyboardType: keyboardType,
      cursorColor: kColorOne,
      style: TextStyle(fontSize: 15),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: labelText,
        contentPadding: EdgeInsets.fromLTRB(5, 11, 5, 11),
        isDense: true,
        // labelStyle: TextStyle(color: Palette.colorOne),
        border: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.black38,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kColorOne),
        ),
      ),
      inputFormatters: inputFormatters,
      validator: validator as String? Function(String?)?,
      // onChanged: onChanged,
    );
  }
}
