import 'package:flutter/material.dart';
import 'package:port/models/product_model.dart';

class ProductItem extends StatefulWidget {
  final ProductModel _product;
  const ProductItem(this._product);
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height:150,
      margin:EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Image.network(
                'https://obscure-bastion-97488.herokuapp.com/images/${widget._product.imagePath}'),
            title: Text(widget._product.name),
          ),
          Divider()
        ],
      ),
    );
  }
}
