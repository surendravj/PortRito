import 'package:flutter/material.dart';
import 'package:port/constants/rating.dart';
import 'package:port/models/product_model.dart';
import 'package:port/services/favourite.dart';
import 'package:port/models/user_model.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final String id;

  const ProductDetails(this.id);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFav = false;
  bool frameStatus = false;
  UserModel user;
  ProductModel _product;
  @override
  void initState() {
    user = Provider.of<UserModel>(context, listen: false);
    _product =
        Provider.of<ProductsList>(context, listen: false).getProduct(widget.id);
    Provider.of<Favoruites>(context, listen: false)
        .isFavoruite(user.uid, _product.id)
        .then((value) {
      setState(() {
        isFav = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    @override
    final topBar = Container(
      width: double.infinity,
      height: 80,
      child: Row(
        children: <Widget>[
          SizedBox(width: 25),
          Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.teal[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
                color: Colors.black,
                splashColor: Colors.white,
                focusColor: Colors.white),
          ),
          SizedBox(
            width: 260,
          ),
          Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    if (!isFav) {
                      setState(() {
                        isFav = true;
                      });
                      Provider.of<Favoruites>(context, listen: false)
                          .updateFavourite(user.uid, _product);
                    }
                  }))
        ],
      ),
    );

    //Image Container
    final imageHolder = Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Container(
        width: 300,
        height: 400,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 15,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              'assets/images/${_product.imagePath}',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );

    // nameTag
    final nameTag = Text(
      _product.name,
      style: commonTextStyle(23, FontWeight.w600, Colors.black)
          .copyWith(fontFamily: 'RobotoCondensed'),
    );

    // stockIndicator
    final stockIndicator = _product.quantity == '0'
        ? commonText('No stock', 15, FontWeight.normal, Colors.red)
        : commonText('In Stock', 15, FontWeight.normal, Colors.green);
    // Describe
    final describe = Text('Description',
        style: commonTextStyle(15, FontWeight.normal, Colors.black)
            .copyWith(decoration: TextDecoration.underline));

    // #Description
    final description = Container(
        width: 350,
        alignment: Alignment.centerLeft,
        child: commonText(
          _product.description,
          13,
          FontWeight.normal,
          Colors.grey,
        ));

    //priceTag
    final priceTag = Chip(
        label: commonText(
          'Rs ${_product.price}/-',
          14,
          FontWeight.normal,
          Colors.black,
        ),
        backgroundColor: Colors.teal[200]);
    // orderTag
    final orderTag = FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.black)),
      onPressed: () {},
      color: Colors.black,
      textColor: Colors.white,
      child: commonText('Order now', 15, FontWeight.w600, Colors.white),
    );

    //frameNotice for extra notice
    final frameNotice = commonText(
        'Extra cost 200/- for frame', 13, FontWeight.normal, Colors.red[400]);

    // dimensions widget
    final dimensions = commonText('Dimensions:${_product.dimensions}', 15,
        FontWeight.normal, Colors.black87);

    //typeofportrait widget

    final typeOfPortriat = commonText(
        _product.typeOfPortrait, 13, FontWeight.w400, Colors.black45);

    // rating widget
    final rating = Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 60,
      child: Rating().buildRow(_product.rating),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            topBar,
            Container(
              height: 710,
              child: ListView(
                children: <Widget>[
                  imageHolder,
                  Divider(),
                  commonRow(nameTag, 10, stockIndicator),
                  SizedBox(height: 5),
                  commonRow(typeOfPortriat, 0, Text('')),
                  SizedBox(height: 10),
                  commonRow(describe, 10, Text('')),
                  SizedBox(height: 5),
                  commonRow(description, 0, Text('')),
                  SizedBox(height: 5),
                  frameStatus ? commonRow(frameNotice, 0, Text('')) : Text(''),
                  commonRow(commonFlatButton(), 15, commonFlatButton2()),
                  SizedBox(height: 5),
                  commonRow(dimensions, 0, Text('')),
                  SizedBox(height: 5),
                  rating,
                ],
              ),
            ),
            SizedBox(height: 5),
            commonRow(priceTag, 190, orderTag),
          ],
        ),
      ),
    );
  }

  Text commonText(String text, double size, FontWeight weight, Color color) {
    return Text(
      text,
      style: commonTextStyle(size, weight, color),
    );
  }

  FlatButton commonFlatButton() {
    return FlatButton.icon(
      onPressed: () {
        setState(() {
          frameStatus = !frameStatus;
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: !frameStatus ? Colors.teal[200] : Colors.white),
      ),
      icon: Icon(Icons.filter_frames),
      label: Text(
        'No Frame',
        style: commonTextStyle(15, FontWeight.w400, Colors.black)
            .copyWith(fontFamily: 'RobotoCondensed'),
      ),
      color: !frameStatus ? Colors.teal[200] : Colors.white,
    );
  }

  FlatButton commonFlatButton2() {
    return FlatButton.icon(
      onPressed: () {
        setState(() {
          frameStatus = !frameStatus;
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: frameStatus ? Colors.teal[200] : Colors.white),
      ),
      icon: Icon(Icons.filter_frames),
      label: Text(
        'With Frame',
        style: commonTextStyle(15, FontWeight.w400, Colors.black)
            .copyWith(fontFamily: 'RobotoCondensed'),
      ),
      color: frameStatus ? Colors.teal[200] : Colors.white,
    );
  }

  TextStyle commonTextStyle(double size, FontWeight weight, Color color) =>
      TextStyle(fontSize: size, fontWeight: weight, color: color);

  Row commonRow(Widget widget, double width, Widget widget2) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 15,
        ),
        widget,
        SizedBox(
          width: width,
        ),
        widget2
      ],
    );
  }
}
