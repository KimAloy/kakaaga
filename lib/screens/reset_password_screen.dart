import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/widgets/widgets.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();

  bool loading = false;
  final _resetPasswordKey = GlobalKey<FormState>();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: kScreenBackground,
            appBar: AppBar(
              title:
                  Text('Reset Password', style: TextStyle(color: Colors.white)),
              backgroundColor: kColorOne,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: _resetPasswordKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Enter your\nEmail Address',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      LoginTextFormField(
                          controller: _emailController,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) => val!.isEmpty
                              ? 'Enter a valid email address'
                              : null,
                          labelText: 'Your email address*'),
                      error == ''
                          ? const SizedBox.shrink()
                          : Column(
                              children: [
                                const SizedBox(height: 2.0),
                                Text(
                                  error,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14),
                                ),
                              ],
                            ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            primary: kColorOne,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Send verification email',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (_resetPasswordKey.currentState!.validate()) {
                              try {
                                await _auth.sendPasswordResetEmail(
                                    email: _emailController.text);
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(
                                    SnackBar(
                                      content: Text('Verification email sent!'),
                                    ),
                                  );
                              } catch (e) {
                                print('Error is: $e');
                                setState(() {
                                  error = 'No user found for this email.';
                                });
                              }
                            }
                          }),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
