import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kakaaga/config/config.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: SpinKitChasingDots(
          // child: SpinKitDoubleBounce(
          color: kColorOne,
          size: 50,
        ),
      ),
    );
  }
}
