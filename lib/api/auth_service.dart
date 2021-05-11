import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakaaga/api/database_service.dart';
import 'package:kakaaga/models/models.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebaseUser
  UserModel? _userFromFirebaseUser(User user) {
    return UserModel(uid: user.uid);
  }

  // auth state change user stream
  Stream<UserModel?> get user {
    // onAuthStateChanged = authStateChanges()
    /// we map this on a stream to a normal user based on our UserModel class
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  // // sign in annonymously
  // Future signInAnon() async {
  //   try {
  //     // AuthResult = UserCredential
  //     UserCredential result = await _auth.signInAnonymously();
  //     // FirebaseUser = User
  //     User user = result.user!;
  //
  //     /// This returns a custom user object instead of a firebase user
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // sign in with email and password
  Future signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;

      // /// create a new document/record for the user with the Firebase auto generated user uid
      // await DatabaseService(uid: user.uid)
      //     .updateUserData('0', 'new crew member', 100);
      // return _userFromFirebaseUser(user);

      /// create a new document/record for the user with the Firebase auto generated user uid
      await DatabaseService(uid: user.uid).updateUserModel(
          name: name,
          email: email,
          profilePicture: '',
          phoneNumber: phoneNumber,
          joinedDate: DateTime.now(),
          accountBalance: 0);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Delete account
  Future deleteAccount() async {
    User user = _auth.currentUser!;
    user.delete(); // deletes and signs out the user automatically
  }
}
