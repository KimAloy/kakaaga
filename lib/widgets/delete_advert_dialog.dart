import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';

class DeleteAdvertDialog extends StatelessWidget {
  final Function onPressed;

  const DeleteAdvertDialog({Key? key, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Advert'),
      content: Text('Are you sure you want to permanently delete this advert?'),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(primary: kColorTwo),
          child: Text(
            'Yes',
            style: TextStyle(fontSize: 15),
          ),
          onPressed: onPressed as void Function()?,
        ),
        const SizedBox(width: 25),
        TextButton(
          style: TextButton.styleFrom(primary: kColorTwo),
          child: Text(
            'No',
            style: TextStyle(fontSize: 15),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            print("'No, don't delete advert tapped'");
          },
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}
