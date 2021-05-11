import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:kakaaga/api/auth_service.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/screens/screens.dart';
import 'package:kakaaga/widgets/widgets.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = AuthService();

  // final _directAuth = FirebaseAuth.instance;
  final _signUpFormKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _userPhoneNumber = TextEditingController();

  bool loading = false;
  String error = '';

  @override
  void initState() {
    _userPhoneNumber.text = '+256';
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScreenBackground,
      appBar: AppBar(
        title: Text('Sign up', style: TextStyle(color: Colors.white)),
        backgroundColor: kColorOne,
        elevation: 0.0,
      ),
      body: LoadingOverlay(
        isLoading: loading,
        opacity: 0.3,
        progressIndicator: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(kColorOne)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _signUpFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Sign up, it's Free!",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kColorOne),
                  ),
                  SizedBox(height: 25),
                  enterYourFullName(controller: _usernameController),
                  SizedBox(height: 15),
                  LoginTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      obscureText: false,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter valid email address';
                        } else if (EmailValidator.validate(val) == false) {
                          return 'Enter valid email address';
                        }
                        return null;
                      },
                      labelText: 'Your email address*'),
                  SizedBox(height: 15),
                  LoginTextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _userPhoneNumber,
                      obscureText: false,
                      validator: (val) =>
                          val!.isEmpty ? 'Enter valid phone number' : null,
                      labelText: 'Phone Number*'),
                  const SizedBox(height: 15),
                  LoginTextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: (val) => val!.length < 6
                        ? 'Password should be at least 6 characters'
                        : null,
                    labelText: 'Password*',
                  ),
                  const SizedBox(height: 15),
                  LoginTextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    validator: (val) => val!.isEmpty ||
                            _passwordController.text !=
                                _confirmPasswordController.text
                        ? 'Confirm password'
                        : null,
                    labelText: 'Confirm Password*',
                  ),
                  const SizedBox(height: 15.0),
                  error == ''
                      ? const SizedBox.shrink()
                      : Column(
                          children: [
                            const SizedBox(height: 2.0),
                            Text(
                              error,
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                            const SizedBox(height: 4.0),
                          ],
                        ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kColorOne,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (_signUpFormKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                            phoneNumber: _userPhoneNumber.text,
                            name: _usernameController.text,
                          );
                          if (result == null) {
                            setState(() {
                              error = 'Invalid email or password';
                              loading = false;
                            });
                          } else {
                            Navigator.pop(context);
                            WrapperMyAccount();

                            /// this is useless because we are listening to the Wrapper stream
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (_) {
                            //   return WrapperMyAccount();
                            // }));
                            // loading = false;
                            // setState(() => loading = false);
                          }
                        }
                        // if (_signUpFormKey.currentState!.validate()) {
                        // setState(() => loading = true);
                        // try {
                        //   UserCredential result = await _directAuth
                        //       .createUserWithEmailAndPassword(
                        //           email: _emailController.text,
                        //           password: _passwordController.text);
                        //
                        //   /// returned user from firebase
                        //   User? user = result.user;
                        //
                        //   /// Create a new user using the UserModel
                        //   UserModel _userModel = UserModel(
                        //     // id: _userCredential.user!.uid,
                        //     name: _usernameController.text,
                        //     email: _emailController.text,
                        //     profilePicture: '',
                        //     phoneNumber: _userPhoneNumber.text,
                        //     joinedDate: DateTime.now(),
                        //     accountBalance: 0,
                        //   );

                        /// create a new document with the uid
                        // await DatabaseService(uid: user!.uid)
                        //     .updateUserData(_userModel);
                        //
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) {
                        //   return UploadToFirebaseStorage();
                        // }));
                        // setState(() => loading = false);
                        // } on FirebaseAuthException catch (e) {
                        //   setState(() {
                        //     if (e.code == 'weak-password') {
                        //       error =
                        //           'Password should be at least 6 characters';
                        //     } else if (e.code == 'email-already-in-use') {
                        //       error =
                        //           'The email is already in use by another account';
                        //     }
                        //     print(e);
                        //     loading = false;
                        //   });
                        // }
                        // }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already registered?',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      InkWell(
                        splashColor: kColorThree,
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return Login();
                          }));
                          print('going to login screen');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: kColorOne,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget enterYourFullName({dynamic controller}) {
  return TextFormField(
    controller: controller,
    style: TextStyle(fontSize: 17),
    textCapitalization: TextCapitalization.words,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      labelText: "Your Full Name*",
      contentPadding: EdgeInsets.fromLTRB(5, 11, 5, 11),
      border: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black26, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kColorTwo),
      ),
    ),
    validator: (val) => val!.isEmpty ? 'Enter your name' : null,
  );
}
