import 'package:kakaaga/config/config.dart';

class AdvertField {
  static const createdTime = 'createdTime';
}

class Advert {
  String? advertiserEmail;
  String? id;
  int? quantity;
  String? quantityUnit;
  List? images;
  String? title;
  String? description;
  int? price;
  bool eachCheckbox;
  String? district;
  String? parish;
  DateTime? createdTime;
  String? phoneNumber;
  bool whatsApp;
  bool phoneCallOk;
  String? advertiserName;
  DateTime? advertiserJoinedDate;
  String? advertiserProfilePicture;

  // bool isWatchlisted;
  bool adStatus;

  // String listingID;

  Advert({
    this.advertiserEmail,
    this.id,
    required this.quantity,
    this.quantityUnit,
    this.images,
    required this.title,
    required this.createdTime,
    required this.price,
    this.eachCheckbox = false,
    required this.phoneNumber,
    required this.whatsApp,
    required this.phoneCallOk,
    this.advertiserName,
    this.advertiserJoinedDate,
    this.advertiserProfilePicture,
    required this.description,
    // required this.isWatchlisted,
    required this.adStatus,
    required this.district,
    required this.parish,
    // required this.listingID,
  });

  static Advert fromJson(Map<String, dynamic> json) => Advert(
        id: json['id'],
        adStatus: json['adStatus'],
        advertiserEmail: json['advertiserEmail'],
        advertiserJoinedDate: Utils.toDateTime(json['advertiserJoinedDate']),
        advertiserName: json['advertiserName'],
        advertiserProfilePicture: json['advertiserProfilePicture'],
        createdTime: Utils.toDateTime(json['createdTime']),
        description: json['description'],
        district: json['district'],
        eachCheckbox: json['eachCheckbox'],
        images: json['images'],
        parish: json['parish'],
        phoneCallOk: json['phoneCallOk'],
        phoneNumber: json['phoneNumber'],
        price: json['price'],
        quantity: json['quantity'],
        quantityUnit: json['quantityUnit'],
        title: json['title'],
        whatsApp: json['whatsApp'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'adStatus': adStatus,
        'advertiserEmail': advertiserEmail,
        'advertiserJoinedDate': advertiserJoinedDate,
        'advertiserName': advertiserName,
        'advertiserProfilePicture': advertiserProfilePicture,
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'description': description,
        'district': district,
        'eachCheckbox': eachCheckbox,
        'images': images,
        'parish': parish,
        'phoneCallOk': phoneCallOk,
        'phoneNumber': phoneNumber,
        'price': price,
        'quantity': quantity,
        'quantityUnit': quantityUnit,
        'title': title,
        'whatsApp': whatsApp,
      };
}
