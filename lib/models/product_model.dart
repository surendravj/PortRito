import 'package:flutter/cupertino.dart';
import 'package:port/services/products.dart';

class ProductModel with ChangeNotifier {
  final String name;
  final String imagePath;
  final String price;
  final String quantity;
  final String typeOfPortrait;
  final bool isPuchased;
  final String rating;
  final String id;
  final String description;
  final String dimensions;
  ProductModel(this.name, this.imagePath, this.price, this.quantity,
      this.typeOfPortrait, this.isPuchased, this.rating, this.id,this.description,this.dimensions);
}

class ProductsList with ChangeNotifier {
  List<ProductModel> _products = [];
  Future<List<ProductModel>> getProducts() async {
    _products = [];
    await Products().getData().then((value) => (_products = value));
    return _products;
  }

  ProductModel getProduct(String id) {
    return _products.firstWhere((element) => element.id == id);
  }
}
