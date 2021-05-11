import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kakaaga/brews/brew_model.dart';
import 'package:kakaaga/brews/user_data.dart';

class DatabaseServiceBrew {
  final String? uid;
  DatabaseServiceBrew({this.uid});

  // collection reference
  CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  /// this is also used to create user in firestore in the sign up screen
  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Brew(
              name: doc.data()['name'] ?? '',
              strength: doc.data()['strength'] ?? 0,
              sugars: doc.data()['sugars'] ?? '',
            ))
        .toList();
  }

  // get brews stream : Flutter & Firebase App Tutorial #18 - Firestore Streams
  // i'm currently testing this stream in my_profile_and_account_screen
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapShot);
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()!['name'],
      sugars: snapshot.data()!['sugars'],
      strength: snapshot.data()!['strength'].toString(),
    );
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
