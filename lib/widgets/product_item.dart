import 'package:flutter/material.dart';
import 'package:port/models/product_model.dart';
import 'package:port/screens/product_detail_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductItem extends StatefulWidget {
  final ProductModel _product;

  const ProductItem(this._product);
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  void changeScreen() {
    Navigator.of(context)
        .pushNamed(ProductDetails.routeName, arguments: widget._product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 150,
                height: 175,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                        Center(
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image:
                                'https://obscure-bastion-97488.herokuapp.com/images/${widget._product.imagePath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      widget._product.name,
                      style: TextStyle(
                        fontFamily: 'Raleway-Regular',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Chip(
                        label: Text('Rs ${widget._product.price}/-'),
                        backgroundColor: Colors.teal[200]),
                    FlatButton.icon(
                      onPressed: changeScreen,
                      icon: Icon(Icons.arrow_forward),
                      label: Text('More',
                          style: TextStyle(fontFamily: 'Raleway-Regular')),
                      // color:Colors.cyan[200],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        Icon(
                          Icons.star_half,
                          color: Colors.orange,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
// 'https://obscure-bastion-97488.herokuapp.com/images/${widget._product.imagePath}'
