class Advert {
  int? quantity;
  String? quantityUnit;
  List? images;
  String? title;
  String? description;
  int? price;
  bool eachCheckbox;
  String? district;
  String? parish;
  String? listed;
  String? advertPhoneNumber;
  bool whatsApp;
  bool phoneCallOk;
  String? advertiserName;
  String? advertiserJoinedDate;
  String? advertiserProfilePicture;
  bool isWatchlisted;
  bool adStatus;
  String listingID;

  Advert({
    required this.quantity,
    this.quantityUnit,
    this.images,
    required this.title,
    required this.listed,
    required this.price,
    this.eachCheckbox = false,
    required this.advertPhoneNumber,
    required this.whatsApp,
    required this.phoneCallOk,
    this.advertiserName,
    this.advertiserJoinedDate,
    this.advertiserProfilePicture,
    required this.description,
    required this.isWatchlisted,
    required this.adStatus,
    required this.district,
    required this.parish,
    required this.listingID,
  });
}
