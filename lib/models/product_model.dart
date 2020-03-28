import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier {
  final String name;
  final String imagePath;
  final String price;
  final String quantity;
  final String typeOfPortrait;
  final bool isPuchased;
  final String rating;

  ProductModel(this.name, this.imagePath, this.price, this.quantity,
      this.typeOfPortrait, this.isPuchased, this.rating);
}
