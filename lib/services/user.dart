import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

final CollectionReference _fireStore = Firestore.instance.collection('Users');

class User with ChangeNotifier {
  final String uid;
  final String name;
  final String phNumber;
  final List<dynamic> myFavourites;

  User(this.uid, this.name, this.phNumber, this.myFavourites);

  Future<void> addUser() async {
    try {
      await _fireStore.document(uid).setData(
          {'name': name, 'phNumber': phNumber, 'myFavs': myFavourites});
    } catch (e) {
      print(e);
    }
  }
}

class UserDb {
  final String uid;
  List<dynamic> myFavs = [];
  UserDb(this.uid);
  Future<User> getUser() async {
    return await _fireStore.document(uid).get().then((DocumentSnapshot value) {
      myFavs = value.data['myFavs'];
      return User(value.documentID, value.data['name'], value.data['phNumber'],
          value.data['myFavs']);
    });
  }
}
