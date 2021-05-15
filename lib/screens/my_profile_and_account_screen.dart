import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kakaaga/api/api.dart';
import 'package:kakaaga/api/auth_service.dart';
import 'package:kakaaga/api/database_service.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/models/models.dart';
import 'package:kakaaga/screens/screens.dart';
import 'package:kakaaga/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MyProfileAndAccountScreen extends StatefulWidget {
  @override
  _MyProfileAndAccountScreenState createState() =>
      _MyProfileAndAccountScreenState();
}

class _MyProfileAndAccountScreenState extends State<MyProfileAndAccountScreen> {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    return StreamBuilder<UserModel>(
        stream: DatabaseService(uid: user!.uid).userModel,
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Scaffold(
                body: SafeArea(
                    child: Column(
              children: [
                GestureDetector(
                    onTap: () {
                      _authService.signOut();
                      Navigator.pop(context);
                      print('"Logout Account icon tapped"');
                    },
                    child: Text('Loading...')),
                // _SettingsOptions(
                //   text: 'Logout',
                //   icon: Icons.power_settings_new_outlined,
                //   color: Colors.red,
                //   onTap: () {
                //     _authService.signOut();
                //     Navigator.pop(context);
                //     print('"Logout Account icon tapped"');
                //   },
                // ),
              ],
            )));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return Text("Loading");
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kColorOne),
                ),
              ),
            );
          }

          /// This helps when the data is still being fetched, otherwise the
          /// screen will error "Null check operator used on a null value"
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kColorOne),
              ),
            );
          }
          UserModel? userModel = snapshot.data!;
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NavigationItems(
                      myZattabiColor: kScreenBackground2,
                      goToMyZattabiMyAdvertsScreenOnTap: false,
                    ),
                    Container(color: kColorOne, height: 4),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, size: 24),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Spacer(),
                        MyOutlineButton(
                          onPressed: () {
                            print('"my advert button pressed"');
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return MyAdvertsScreen();
                            }));
                          },
                          text: 'My Adverts',
                        ),
                        const SizedBox(width: 10),
                        MyOutlineButton(
                          // onPressed: () => null,
                          text: 'My account',
                          textColor: kColorOne,
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          ProfilePicture(
                            userModel: userModel,
                            onTap: () {
                              changeProfilePicture();
                            },
                          ),
                          SizedBox(width: 10),
                          Text(
                            userModel.name!,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    // Text(userModel.name!),
                    // Text(userModel.email!),
                    // Text(userModel.phoneNumber!),
                    // Text('${userModel.joinedDate!}'),
                    // Text(userModel.accountBalance!.toString()),

                    const SizedBox(height: 15),
                    Divider(height: 1, color: Colors.grey),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Phone Number:  ${userModel.phoneNumber!}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Divider(height: 1, color: Colors.grey),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SettingsOptions(
                            text: 'Edit account',
                            icon: Icons.edit,
                            color: Colors.black87,
                            onTap: () => _showSettingsPanel(),
                          ),
                          _SettingsOptions(
                            text: 'Delete account',
                            icon: Icons.delete_forever_outlined,
                            color: Colors.black87,
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => DeleteAccountDialog());
                            },
                          ),
                          _SettingsOptions(
                            text: 'Logout',
                            icon: Icons.power_settings_new_outlined,
                            color: Colors.red,
                            onTap: () {
                              // _auth.signOut()
                              _authService.signOut();
                              print('"Logout Account icon tapped"');
                            },
                          ),
                          const SizedBox(height: 80),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future changeProfilePicture() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    UploadTask? task;
    File? file;
    final User? currentUser = _auth.currentUser;
    final user = Provider.of<UserModel?>(context, listen: false);

    /// pick picture
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));
    print('select file successful');

    // upload file to Firebase Storage
    if (file == null) return;
    final fileName = currentUser!.email;
    // final fileName = basename(file!.path);
    final destination = 'profilePicture/$fileName';
    task = FirebaseApi.uploadFile(destination, file!);
    // setState(() => CircularProgressIndicator());

    print('file successfully uploaded');

    /// display uploaded image from Firebase Storage in the app
    if (task == null) return;
    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    /// update profile picture in firestore
    DatabaseService(uid: user!.uid).updateProfilePicture(urlDownload);

    setState(() => user.profilePicture = urlDownload);
  }

  void _showSettingsPanel() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return Wrap(children: [EditAccountForm()]);
        });
  }
}

class _SettingsOptions extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? color;
  final Function onTap;

  const _SettingsOptions({
    Key? key,
    required this.text,
    required this.icon,
    this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: InkWell(
        splashColor: kColorThree,
        onTap: onTap as void Function()?,
        child: ListTile(
          contentPadding: EdgeInsets.all(0.0),
          title: Text(
            text,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: Icon(icon, size: 30, color: color),
        ),
      ),
    );
  }
}

class EditAccountForm extends StatefulWidget {
  @override
  _EditAccountFormState createState() => _EditAccountFormState();
}

class _EditAccountFormState extends State<EditAccountForm> {
  String? _currentName;

  String? _currentPhoneNumber;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    return StreamBuilder<UserModel>(
        stream: DatabaseService(uid: user!.uid).userModel,
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text('Something went wrong');
          }

          // if (snapshot.connectionState == ConnectionState.waiting) {
          // return Text("Loading");
          // return Center(
          //   child: CircularProgressIndicator(
          //     valueColor: AlwaysStoppedAnimation<Color>(kColorOne),
          //   ),
          // );
          // }
          /// This helps when the data is still being fetched, otherwise the
          /// screen will error "Null check operator used on a null value"
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kColorOne),
              ),
            );
          }
          UserModel? userModel = snapshot.data!;
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Edit Account',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    initialValue: userModel.name,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.fromLTRB(5, 11, 5, 11),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.5)),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black26, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kColorTwo),
                      ),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter your name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    initialValue: userModel.phoneNumber,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      labelStyle: TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.fromLTRB(5, 11, 5, 11),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.5)),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black26, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kColorTwo),
                      ),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a phone number' : null,
                    onChanged: (val) =>
                        setState(() => _currentPhoneNumber = val),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: kColorOne),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserModel(
                            email: userModel.email!,
                            profilePicture: userModel.profilePicture!,
                            phoneNumber:
                                (_currentPhoneNumber ?? userModel.phoneNumber)!,
                            joinedDate: userModel.joinedDate!,
                            accountBalance: userModel.accountBalance!,
                            name: (_currentName ?? userModel.name)!,
                          );

                          Navigator.pop(context);
                          print(_currentName);
                          // print(_currentSugars);
                          // print(_currentStrength);
                        }
                      }
                    },
                    child: Text(
                      'Save Changes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            //   ),
            // ),
          );
        });
  }
}
