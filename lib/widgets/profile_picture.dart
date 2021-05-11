
import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/models/models.dart';

class ProfilePicture extends StatelessWidget {
  final UserModel userModel;
  final Function onTap;

  const ProfilePicture({Key? key, required this.onTap, required this.userModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Stack(
        children: [
          ClipOval(
            child: Container(
              height: 70,
              width: 70,
              color: userModel.profilePicture == '' ? Colors.grey[300] : null,
              child: userModel.profilePicture == ''
                  ? Center(
                child: Icon(
                  Icons.photo_camera_outlined,
                  color: Colors.black38,
                  size: 28,
                ),
              )
                  : Image.network(
                '${userModel.profilePicture}',
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.photo_camera,
                color: kColorOne,
                size: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
