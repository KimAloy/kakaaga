import 'package:flutter/material.dart';
import 'package:kakaaga/models/models.dart';
import 'package:kakaaga/screens/screens.dart';
import 'package:provider/provider.dart';

class WrapperMyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserModel?>(context);
    print('WrapperMyAccoutn: $user');
    if (user == null) {
      return Login();
    } else {
      // return MyProfileAndAccountScreen();
      return MyAdvertsScreen();
    }
  }
}

class WrapperAdvertise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserModel?>(context);
    print('WrapperMyAccoutn: $user');
    if (user == null) {
      return Login();
    } else {
      return AdvertiseScreen();
    }
  }
}
