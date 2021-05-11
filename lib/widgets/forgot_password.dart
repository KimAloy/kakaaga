import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/screens/screens.dart';

class ForgotPassword extends StatelessWidget {
  final Color? color;
  const ForgotPassword({
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          splashColor: kColorThree,
          borderRadius: BorderRadius.circular(3),
          onTap: () {
            print('Forgot password tapped');
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return ResetPassword();
            }));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
            child: Text(
              'Forgot password',
              style: TextStyle(fontWeight: FontWeight.w600, color: color),
              // textAlign: TextAlign.end,
            ),
          ),
        ),
      ],
    );
  }
}
