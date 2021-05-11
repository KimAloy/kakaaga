class UserModel {
  String? uid;
  String? name;
  String? email;
  String? profilePicture;
  String? phoneNumber;
  DateTime? joinedDate;
  int? accountBalance;
  UserModel({
    this.uid,
    this.name,
    this.email,
    this.profilePicture,
    this.phoneNumber,
    this.joinedDate,
    this.accountBalance,
  });

  // UserModel.fromDocumentSnapShot(DocumentSnapshot doc) {
  //   uid = doc.id;
  //   name = doc["name"];
  //   email = doc["email"];
  //   profilePicture = doc["userProfilePicture"];
  //   phoneNumber = doc["userPhoneNumber"];
  //   joinedDate = doc["joinedDate"];
  //   accountBalance = doc["accountBalance"];
  // }
}
