import 'package:flutter/material.dart';
import 'package:port/models/product_model.dart';
import 'package:port/widgets/product_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  List<ProductModel> _products = [];
  @override
  void initState() {
    Provider.of<ProductsList>(context, listen: false)
        .getProducts()
        .then((value) {
      setState(() {
        isLoading = false;
        _products = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff2B3252),
        title: Text(
          'Explore',
          style: TextStyle(fontFamily: 'RobotoCondensed'),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: null),
        ],
      ),
      drawer: Drawer(),
      body: isLoading
          ? SpinKitWave(
              color: Color(0xff2B3252),
            )
          : Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 780,
                  child: ListView.builder(
                    itemBuilder: (ctx, i) {
                      return ProductItem(_products[i]);
                    },
                    itemCount: _products.length,
                  ),
                ),
              ],
            ),
    );
  }
}
