import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:port/models/product_model.dart';

class Products with ChangeNotifier {
  final CollectionReference _firestore = Firestore.instance.collection('Arts');
  Future<List<ProductModel>> getData() async {
    List<ProductModel> products = [];
    await _firestore.getDocuments().then((QuerySnapshot snapshot) => {
          snapshot.documents.forEach((element) {
            products.add(ProductModel(
                element.data['name'],
                element.data['imagePath'],
                element.data['price'],
                element.data['stock'],
                element.data['typeOfPortrait'],
                element.data['isPurchased'],
                element.data['rating'].toString()));
          })
        });
    return products;
  }
}
