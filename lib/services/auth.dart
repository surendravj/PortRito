import 'package:firebase_auth/firebase_auth.dart';
import 'package:port/models/user_model.dart';

import 'user.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserModel getUser(FirebaseUser user) {
    return user != null ? UserModel(user.uid) : null;
  }

  Stream<UserModel> get userStatus {
    return _firebaseAuth.onAuthStateChanged
        .map((FirebaseUser user) => getUser(user));
  }

  Future<void> signIn(String name, String phNumber) async {
    try {
      final AuthResult authResult = await _firebaseAuth.signInAnonymously();
      final FirebaseUser user = authResult.user;
      User(user.uid, name, phNumber).addUser();
      return getUser(user);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
