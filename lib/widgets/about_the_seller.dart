import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/models/models.dart';

class AboutTheSellerOrBuyer extends StatelessWidget {
  final Advert advertData;

  const AboutTheSellerOrBuyer({Key? key, required this.advertData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          'About the seller',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            advertData.advertiserProfilePicture == null
                ? Icon(
                    Icons.account_circle_outlined,
                    size: 60,
                    color: Colors.black45,
                  )
                : CircleAvatar(
                    backgroundColor: kScreenBackground,
                    radius: 30,
                    backgroundImage:
                        AssetImage(advertData.advertiserProfilePicture!),
                  ),
            const SizedBox(width: 20),
            Expanded(
              child: SelectableText(
                '${advertData.advertiserName}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Divider(height: 1, color: Colors.grey),
        const SizedBox(height: 7),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: SelectableText('Member since',
                      style: TextStyle(fontSize: 17))),
              Expanded(
                  flex: 2,
                  child: SelectableText('${advertData.advertiserJoinedDate}',
                      style: TextStyle(fontSize: 17)))
            ],
          ),
        ),
        const SizedBox(height: 7),
        Divider(height: 1, color: Colors.grey),
      ],
    );
  }
}
