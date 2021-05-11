import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';

class MyTextField extends StatelessWidget {
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
  final textCapitalization;
  final cursorColor;

  const MyTextField({
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
    this.textCapitalization,
    this.cursorColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      controller: controller,
      onChanged: onChanged as void Function(String)?,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: fontSize,
        // color: Colors.white,
        fontWeight: fontWeight,
      ),
      cursorColor: cursorColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        hintText: hintText,
        prefixIcon: prefixIcon,
        prefixStyle: prefixStyle,
        contentPadding: EdgeInsets.fromLTRB(5, 11, 5, 11),
        border: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.black38,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kColorOne),
        ),
      ),
    );
  }
}
