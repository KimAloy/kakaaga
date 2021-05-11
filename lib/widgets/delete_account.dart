import 'package:flutter/material.dart';
import 'package:kakaaga/api/api.dart';
import 'package:kakaaga/config/config.dart';

class DeleteAccountDialog extends StatelessWidget {
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Account'),
      content: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black),
          children: <TextSpan>[
            TextSpan(text: 'Do you want to permanently delete your account?'),
            // TextSpan(
            //   text: 'Note: ',
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            // TextSpan(
            //     text:
            //         'You cannot delete an account if it still has money balance.'),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: Colors.red,
          ),
          child: Text(
            'Delete',
            style: TextStyle(fontSize: 15),
          ),
          onPressed: () async {
            Navigator.pop(context);
            // TODO: Add Firebase plugin to delete user data, you should be on Blaze Plan
            await _auth.deleteAccount();

            /// THIS IS CUMBERSOME, USE FIREBASE 'DELETE USER DATA' PLUGIN
            // await DatabaseService().deleteUserFirestoreData();
          },
        ),
        const SizedBox(width: 25),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: kColorOne,
          ),
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 15),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            print('"Cancel delete pressed"');
          },
        ),
      ],
    );
  }
}
