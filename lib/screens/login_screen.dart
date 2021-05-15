import 'package:flutter/material.dart';
import 'package:kakaaga/api/auth_service.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/screens/screens.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../widgets/widgets.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final _auth = FirebaseAuth.instance;
  final _auth = AuthService();

  final _loginFormKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();

  final _emailController = TextEditingController();

  bool loading = false;
  String error = '';
  late bool newUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScreenBackground,
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white)),
        backgroundColor: kColorOne,
        elevation: 0.0,
      ),
      body: LoadingOverlay(
        progressIndicator: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(kColorOne)),
        opacity: 0.3,
        // color: kColorOne,
        isLoading: loading,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Enter\nEmail Address\n& Password',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  LoginTextFormField(
                      controller: _emailController,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) =>
                          val!.isEmpty ? 'Enter a valid email address' : null,
                      labelText: 'Your email address*'),
                  const SizedBox(height: 15),
                  LoginTextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: (val) => val!.isEmpty ? 'Enter password' : null,
                    labelText: 'Password*',
                  ),
                  const SizedBox(height: 4.0),
                  error == ''
                      ? const SizedBox.shrink()
                      : Column(
                          children: [
                            const SizedBox(height: 2.0),
                            Text(
                              error,
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          ],
                        ),
                  ForgotPassword(),
                  const SizedBox(height: 4.0),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        primary: kColorOne,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (_loginFormKey.currentState!.validate()) {
                          setState(() => loading = true);
                          // TODO: replace this with error from google firestore webiste below
                          // https://firebase.flutter.dev/docs/firestore/usage/
                          dynamic result =
                              await _auth.signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          if (result == null) {
                            setState(() {
                              error = 'Invalid email or password';
                              loading = false;
                            });
                          }

                          /// this is useless because we're listening to Wrapper.dart stream
                          // else {
                          //   setState(() => loading = false);
                          // }
                        }
                        // NOTE: VScode doesn't show the error in the app
                        // Therefore always use Android Studio
                        // if (_loginFormKey.currentState!.validate()) {
                        //   try {
                        //     setState(() => loading = true);
                        //     await _auth.signInWithEmailAndPassword(
                        //         email: _emailController.text,
                        //         password: _passwordController.text);
                        //
                        //     // Navigator.push(context,
                        //     //     MaterialPageRoute(builder: (_) {
                        //     //   return WrapperMyMazaawoAccountScreen();
                        //     // }));
                        //     setState(() => loading = false);
                        //   } catch (e) {
                        //     // print(e);
                        //     setState(() {
                        //       error = 'Invalid email or password';
                        //       loading = false;
                        //     });
                        //   }
                        // }
                      }),
                  const SizedBox(height: 15),
                  // LoginAnnonymously(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: -0.1,
                        ),
                      ),
                      InkWell(
                        splashColor: kColorThree,
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return SignUp();
                          }));
                          print('going to Sign up screen');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 6),
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kColorOne,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
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
//
// class LoginAnnonymously extends StatefulWidget {
//   @override
//   _LoginAnnonymouslyState createState() => _LoginAnnonymouslyState();
// }
//
// class _LoginAnnonymouslyState extends State<LoginAnnonymously> {
//   final _auth = AuthService();
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//           primary: kColorOne,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           child: Text(
//             'Login Annonymously',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         onPressed: () async {
//           dynamic result = await _auth.signInAnon();
//           if (result == null) {
//             print('error signing in');
//           }
//           print('signed in uid: ${result.uid}');
//           // setState(() => loading = true);
//           // await _auth.signInWithEmailAndPassword(
//           //     email: _emailController.text,
//           //     password: _passwordController.text);
//
//           // Navigator.push(context,
//           //     MaterialPageRoute(builder: (_) {
//           //       return WrapperMyMazaawoAccountScreen();
//           //     }));
//           // setState(() => loading = false);
//         });
//   }
// }
