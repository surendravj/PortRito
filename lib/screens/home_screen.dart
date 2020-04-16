import 'package:flutter/material.dart';
import 'package:port/constants/loader.dart';
import 'package:port/models/product_model.dart';
import 'package:port/models/user_model.dart';
import 'package:port/services/user.dart';
import 'package:port/widgets/drawer.dart';
import 'package:port/widgets/product_item.dart';
import 'package:provider/provider.dart';

import 'shopping_cart_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  List<ProductModel> _products = [];
  UserModel uid;
  User _user;
  bool drawerLoad = true;
  @override
  void initState() {
    uid = Provider.of<UserModel>(context, listen: false);
    UserDb(uid.uid).getUser().then((value) {
      setState(() {
        _user = value;
        drawerLoad = false;
      });
    });
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
              onPressed:()=>Navigator.of(context).pushNamed(ShoppingCartScreen.routeName),
          ),],
      ),
      drawer: Drawer(
        child: drawerLoad
            ? CircularProgressIndicator()
            : SideDrawer(_user.name, _user.phNumber),
      ),
      body: isLoading
          ? Loader('Loading...')
          : Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 780,
                  child: ListView.builder(
                    itemBuilder: (ctx, i) {
                      return ChangeNotifierProvider.value(
                        value: _products[i],
                        child: ProductItem(_products[i]),
                      );
                    },
                    itemCount: _products.length,
                  ),
                ),
              ],
            ),
    );
  }
}
