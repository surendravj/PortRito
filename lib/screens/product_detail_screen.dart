import 'package:flutter/material.dart';
import 'package:port/constants/rating.dart';
import 'package:port/models/product_model.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/productDetails';
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductModel _product;
  bool isFav = false;
  bool withFrame = false;
  @override
  Widget build(BuildContext context) {
    String productId = ModalRoute.of(context).settings.arguments as String;
    _product = Provider.of<ProductsList>(context).getProduct(productId);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 780,
                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                    Colors.white.withOpacity(0.8),
                    Colors.white.withOpacity(0.8),
                  ]),
                ),
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.teal[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 25,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                        Container(
                          height: 440,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 400,
                                width: 300,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  elevation: 10,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                        'https://obscure-bastion-97488.herokuapp.com/images/${_product.imagePath}',
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                _product.typeOfPortrait,
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontFamily: 'RobotoCondensed-Regular'),
                              ),
                              SizedBox(width: 10),
                              !_product.isPuchased
                                  ? Text(
                                      'In Stock',
                                      style: TextStyle(color: Colors.green),
                                    )
                                  : Text(
                                      '(No Stock)',
                                      style: TextStyle(color: Colors.red),
                                    ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 400,
                                child: Text(
                                  _product.name,
                                  style: buildTextStyle(Colors.black, 20,
                                      FontWeight.w600, 'RobotoCondensed-Bold'),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(width: 5),
                              Text(
                                'Description:-',
                                style: buildTextStyle(Colors.black, 12,
                                        FontWeight.w500, 'RobotoCondensed')
                                    .copyWith(
                                        decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(width: 5),
                              Container(
                                width: 400,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _product.description,
                                  style: buildTextStyle(Colors.grey, 13,
                                      FontWeight.w400, 'RobotoCondensed'),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: <Widget>[
                              Text(
                                'Size',
                                style: buildTextStyle(Colors.red[200], 15,
                                    FontWeight.w600, 'RobotoCondensed-Bold'),
                              ),
                              SizedBox(width: 10),
                              Container(
                                padding: EdgeInsets.all(8),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.teal[100]),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text(
                                  _product.dimensions,
                                  style: buildTextStyle(Colors.black, 13,
                                      FontWeight.w400, 'RobotoCondensed'),
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Rating().buildRow(_product.rating),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: <Widget>[
                              SizedBox(width: 5),
                              FlatButton.icon(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: !withFrame
                                      ? BorderSide(color: Colors.black)
                                      : BorderSide(color: Colors.teal[200]),
                                ),
                                color:
                                    withFrame ? Colors.teal[200] : Colors.white,
                                textColor: Colors.black,
                                onPressed: () {
                                  setState(() {
                                    withFrame = !withFrame;
                                  });
                                },
                                icon: Icon(Icons.filter_frames),
                                label: Text('With Frame'),
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Extra Cost 200/-',
                                style: buildTextStyle(Colors.red[200], 12,
                                    FontWeight.w400, 'RobotoCondensed-Bold'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                  child: Container(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 20),
                      Chip(
                          label: Text(
                            'Rs ${_product.price}/-',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Raleway-Bold'),
                          ),
                          backgroundColor: Colors.teal[200]),
                      SizedBox(width: 120),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 10,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                              splashColor: Colors.white,
                              color: Colors.red,
                              icon: isFav
                                  ? Icon(Icons.favorite)
                                  : Icon(Icons.favorite_border),
                              onPressed: () {
                                setState(() {
                                  isFav = !isFav;
                                });
                              }),
                        ),
                      ),
                      SizedBox(width: 10),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black)),
                        onPressed: () {},
                        color: Colors.black,
                        textColor: Colors.white,
                        child: Text(
                          'Order Now',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Raleway-Bold'),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  TextStyle buildTextStyle(
      Color colors, double size, FontWeight weight, String family) {
    return TextStyle(
        color: colors, fontSize: size, fontWeight: weight, fontFamily: family);
  }
}
