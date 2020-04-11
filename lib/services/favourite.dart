import 'package:flutter/cupertino.dart';
import 'package:port/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Favourite {
  final String productUid;
  final String name;
  final String imagePath;
  final String price;
  final String rating;
  final String typeOfProduct;

  Favourite(this.productUid, this.name, this.imagePath, this.price, this.rating,
      this.typeOfProduct);
}

class Favoruites with ChangeNotifier {
  List<Favourite> _list = [];
  bool checkFavoruiteStatus = false;
  final CollectionReference _collectionReference =
      Firestore.instance.collection('Favoruites');

  Future<bool> checkFavouritesStatus(String userUid) async {
    await _collectionReference.document(userUid).get().then((value) {
      checkFavoruiteStatus = value.exists;
    });
    return checkFavoruiteStatus;
  }

  Future<bool> isFavoruite(String userUid, String uid) async {
    var isFound = false;
    await _collectionReference.document(userUid).get().then((value) {
      for (var i = 0; i < value.data['data'].length; i++) {
        if (value.data['data'][i]['productId'] == uid) {
          isFound = true;
          break;
        }
      }
    });
    return isFound;
  }

  Future updateFavourite(String uid, ProductModel product) async {
    await checkFavouritesStatus(uid).then((value) {
      if (value) {
        var obj = [
          {
            'productId': product.id,
            'name': product.name,
            'imagePath': product.imagePath,
            'price': product.price,
            'rating': product.rating,
            'typeOfPortrait': product.typeOfPortrait
          }
        ];
        _collectionReference
            .document(uid)
            .updateData({'data': FieldValue.arrayUnion(obj)});
      } else {
        _collectionReference.document(uid).setData({
          'data': [
            {
              'productId': product.id,
              'name': product.name,
              'imagePath': product.imagePath,
              'price': product.price,
              'rating': product.rating,
              'typeOfPortrait': product.typeOfPortrait
            }
          ]
        });
      }
    });
  }

  Future<List<Favourite>> loadFavourites(String uid) async {
    _list = [];
    await _collectionReference.document(uid).get().then((value) {
      var obj = value.data['data'];
      for (var i = 0; i < obj.length; i++) {
        _list.add(Favourite(
            obj[i]['productId'],
            obj[i]['name'],
            obj[i]['imagePath'],
            obj[i]['price'],
            obj[i]['rating'],
            obj[i]['typeOfPortriat']));
      }
    });
    return _list;
  }
}
