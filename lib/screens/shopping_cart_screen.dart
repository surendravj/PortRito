import 'package:flutter/material.dart';
import 'package:port/constants/loader.dart';
import 'package:port/models/user_model.dart';
import 'package:port/services/cart.dart';
import 'package:port/widgets/cart_item.dart';
import 'package:provider/provider.dart';

class ShoppingCartScreen extends StatefulWidget {
  static const routeName = '/cart';
  @override
  _ShoppingCartScreen createState() => _ShoppingCartScreen();
}

class _ShoppingCartScreen extends State<ShoppingCartScreen> {
  var data = [];
  bool isLoading = true;
  UserModel _user;
  int cartLength = 0;
  @override
  void initState() {
    _user = Provider.of<UserModel>(context, listen: false);
    ShoppingCart().loadData(_user.uid).then((value) {
      if (!value.exists) {
        setState(() {
          data = [];
          cartLength = 0;
          isLoading = false;
        });
      }
      setState(() {
        data = value.data['data'];
        cartLength = value.data['data'].length;
        isLoading = false;
      });
    });
    super.initState();
  }

  void removeItem(String productId) {
    data.removeWhere((element) => element['productId'] == productId);
    setState(() {
      cartLength -= 1;
    });
    ShoppingCart().removeFromDb(productId, _user.uid);
  }

  @override
  Widget build(BuildContext context) {
    final noCartNotice = Container(
        child: Center(
      child: Column(
        children: <Widget>[
          Icon(
            Icons.sentiment_very_dissatisfied,
            color: Colors.red,
            size: 30,
          ),
          Text(
            'Cart is empty',
            style: TextStyle(
                fontFamily: 'RobodoCondended',
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 25),
          ),
        ],
      ),
    ));
    final topBar = Container(
      padding: EdgeInsets.all(10),
      height: 100,
      child: Card(
          elevation: 8,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(width: 100),
              Text(
                'My Cart',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 110),
              Tooltip(
                message: 'Cart size',
                child: Chip(
                  label: Text(
                    '$cartLength',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: Colors.orange[300],
                ),
              ),
            ],
          )),
    );
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Loader('Preparing Cart')
            : Column(
                children: <Widget>[
                  topBar,
                  data.length == 0
                      ? noCartNotice
                      : Container(
                          height: 650,
                          child: ListView.builder(
                            itemBuilder: (ctx, i) =>
                                (CartItem(data[i], removeItem)),
                            itemCount: data.length,
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
