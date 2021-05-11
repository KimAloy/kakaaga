import 'package:flutter/material.dart';

const kTextFormFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  contentPadding: EdgeInsets.fromLTRB(5, 11, 5, 11),
  border: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black26, width: 0.5),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kColorTwo),
  ),
);

const kSearchDelegateTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w600,
  color: Colors.black54,
);

const kSearchDelegateRichTextStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w600,
  color: Colors.black87,
);

const kPriceContainerTextStyle = TextStyle(
  fontWeight: FontWeight.w600,
  color: Colors.black87,
  fontSize: 16,
);

const kGrey50 = Color(0xFFFAFAFA); // some grey 50

const kScreenBackground2 = Color(0xFFF0F2F5); // some gray shade
const Color kScreenBackground = Color(0xFFFFFFFF); // simply 'white'
//  const Color colorOne = Color(0xFF00838F);
const Color kColorOne = Color(0xFF0097A7);
//  const Color colorTwo = Color(0xFF006064);
const Color kColorTwo = Color(0xFF00838F);
const Color kColorThree = Color(0xFF4DD0E1);

String kConvertDateTime(DateTime input) {
  Duration diff = DateTime.now().difference(input);
  if (diff.inDays >= 31) {
    if ((diff.inDays / 31).round() > 1) {
      return '${(diff.inDays / 31).toStringAsFixed(0)} months ago';
    } else {
      return '${(diff.inDays / 31).toStringAsFixed(0)} month ago';
    }
  } else if (diff.inDays >= 1 && diff.inDays < 31) {
    if (diff.inDays == 1) {
      return '${diff.inDays} day ago';
    } else {
      return '${diff.inDays} days ago';
    }
  } else if (diff.inDays < 1 && diff.inHours < 24) {
    if (diff.inHours == 1) {
      return '${diff.inHours} hour ago';
    } else if (diff.inHours < 1) {
      if (diff.inMinutes < 1) {
        return 'just now';
      } else if (diff.inMinutes == 1) {
        return '${diff.inMinutes} minute ago';
      } else {
        return '${diff.inMinutes} minutes ago';
      }
    } else {
      return '${diff.inHours} hours ago';
    }
  } else
    return 'just now';
}
