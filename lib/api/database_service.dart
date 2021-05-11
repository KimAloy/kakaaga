import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/models/models.dart';

class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final String? uid;
  DatabaseService({this.uid});

  /// COLLECTION users
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  /// this is also used to create user in firestore in the sign up screen
  Future updateUserModel({
    required String name,
    required String email,
    required String profilePicture,
    required String phoneNumber,
    required DateTime joinedDate,
    required int accountBalance,
  }) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
      'phoneNumber': phoneNumber,
      'joinedDate': joinedDate,
      'accountBalance': accountBalance,
    });
  }

  // user data from snapshot
  UserModel _userDataModelFromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      uid: uid,
      name: snapshot.data()!['name'],
      email: snapshot.data()!['email'],
      accountBalance: snapshot.data()!['accountBalance'],
      phoneNumber: snapshot.data()!['phoneNumber'],
      joinedDate: Utils.toDateTime(snapshot.data()!['joinedDate']),
      profilePicture: snapshot.data()!['profilePicture'],
    );
  }

  // get user doc stream
  Stream<UserModel> get userModel {
    return usersCollection.doc(uid).snapshots().map(_userDataModelFromSnapshot);
  }

  // update profile picture
  Future<void> updateProfilePicture(String data) {
    return usersCollection
        .doc(uid)
        .update({'profilePicture': data})
        .then((value) => print('Profile picture updated'))
        .catchError((error) => print('Failed to update profilePicture:$error'));
  }

  // // delete user
  Future<void> deleteUserFirestoreData() {
    final User? currentUser = _auth.currentUser;
    return usersCollection
        .doc(currentUser!.uid)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
