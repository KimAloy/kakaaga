import 'package:flutter/material.dart';

class MyRadioListTile extends StatelessWidget {
  final String title;
  final int value;
  final int groupValue;
  final Function onChanged;

  const MyRadioListTile({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: RadioListTile(
        dense: true,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        activeColor: Colors.red,
        controlAffinity: ListTileControlAffinity.trailing,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged as void Function(int?)?,
      ),
    );
  }
}
