import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier {
  final String name;
  final String imagePath;
  final int price;
  final int quantity;
  final String typeOfPortrait;
  final bool isPuchased;
  final int rating;

  ProductModel(this.name, this.imagePath, this.price, this.quantity,
      this.typeOfPortrait, this.isPuchased, this.rating);
}
