import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:port/models/product_model.dart';

class ShoppingCart {
  final CollectionReference _collectionReference =
      Firestore.instance.collection('Cart');
  var cartLength;
  void addItemToCart(String userId, ProductModel _product, bool frameStatus) {
    _collectionReference.document(userId).get().then((value) {
      if (value.exists) {
        var obj = [
          {
            'name': _product.name,
            'userId': userId,
            'productId': _product.id,
            'imagePath': _product.imagePath,
            'price': _product.price,
            'typeOfPortrait': _product.typeOfPortrait,
            'dimensions': _product.dimensions,
            'frameStatus': frameStatus
          }
        ];
        _collectionReference
            .document(userId)
            .updateData({'data': FieldValue.arrayUnion(obj)});
      } else {
        _collectionReference.document(userId).setData({
          'data': [
            {
              'name': _product.name,
              'userId': userId,
              'productId': _product.id,
              'imagePath': _product.imagePath,
              'price': _product.price,
              'typeOfPortrait': _product.typeOfPortrait,
              'dimensions': _product.dimensions,
              'frameStatus': frameStatus
            }
          ]
        });
      }
    });
  }

  Future<bool> isItemExist(String uid, String userId) async {
    var isFound = false;
    await _collectionReference.document(userId).get().then((value) {
      for (var i = 0; i < value.data['data'].length; i++) {
        if (value.data['data'][i]['productId'] == uid) {
          isFound = true;
          break;
        }
      }
    });
    return isFound;
  }

  Future<DocumentSnapshot> loadData(String userId) async {
    return await _collectionReference.document(userId).get();
  }

  Future<void> removeFromDb(String uid, String userId) async {
    var _list = [];
    await _collectionReference.document(userId).get().then((value) {
      _list = value.data['data'];
    });
    _list.removeWhere((element) => element['productId'] == uid);
    await _collectionReference.document(userId).updateData({'data': _list});
  }
}
