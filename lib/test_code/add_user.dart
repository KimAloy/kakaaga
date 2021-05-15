import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kakaaga/widgets/widgets.dart';

class AddAdvert extends StatelessWidget {
  final int quantity;
  final String? quantityUnit;
  final int price;
  final bool eachCheckbox;
  final String title;
  final String? description;
  final List? images;
  final String district;
  final String parish;
  final String phoneNumber;
  final bool whatsApp;
  final bool phoneCallOk;
  final String advertiserName;
  final String? advertiserJoinedDate;
  final String? advertiserProfilePicture;
  final String advertiserEmail;

  AddAdvert({
    Key? key,
    required this.advertiserEmail,
    required this.quantity,
    this.quantityUnit,
    required this.price,
    required this.eachCheckbox,
    required this.title,
    this.description,
    this.images,
    required this.district,
    required this.parish,
    required this.phoneNumber,
    required this.whatsApp,
    required this.phoneCallOk,
    required this.advertiserName,
    this.advertiserJoinedDate,
    this.advertiserProfilePicture,
  }) : super(key: key);
  // bool adStatus = true;

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference adverts =
        FirebaseFirestore.instance.collection('adverts');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return adverts
          .add({
            'advertiser_email': advertiserEmail,
            'quantity': quantity,
            'quantityUnit': quantityUnit,
            'price': price,
            'eachCheckbox': eachCheckbox,
            'title': title,
            'description': description,
            'images': images,
            'district': district,
            'parish': parish,
            'phoneNumber': phoneNumber,
            'whatsApp': whatsApp,
            'phoneCallOk': phoneCallOk,
            'advertiserName': advertiserName,
            'advertiserJoinedDate': advertiserJoinedDate,
            'advertiserProfilePicture': advertiserProfilePicture,
          })
          .then((value) => print("Advert Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    // return TextButton(
    //   onPressed: addUser,
    //   child: Text(
    //     "Add User",
    //   ),
    // );
    return ActionButton(
      text: 'Post Advert',
      padding: EdgeInsets.symmetric(horizontal: 8),
      onPressed: addUser,
    );
  }
}
