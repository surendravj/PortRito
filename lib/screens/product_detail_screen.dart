import 'package:flutter/material.dart';
import 'package:port/models/product_model.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/productDetails';
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    String productId = ModalRoute.of(context).settings.arguments as String;
    ProductModel _product =
        Provider.of<ProductsList>(context).getProduct(productId);
    return Scaffold(
      body: Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    ));
  }
}
