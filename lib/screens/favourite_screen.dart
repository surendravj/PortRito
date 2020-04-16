import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:port/constants/loader.dart';
import 'package:port/models/user_model.dart';
import 'package:port/services/favourite.dart';
import 'package:port/widgets/favourite_item.dart';
import 'package:provider/provider.dart';

class UserFavourites extends StatefulWidget {
  static const routeName = '/userFavourites';
  @override
  _UserFavouritesState createState() => _UserFavouritesState();
}

class _UserFavouritesState extends State<UserFavourites> {
  List<Favourite> _list;
  UserModel user;
  bool isLoading = true;
  bool isFavExist = true;
  int favLength = 0;
  void initState() {
    user = Provider.of<UserModel>(context, listen: false);
    Provider.of<Favoruites>(context, listen: false)
        .checkFavouritesStatus(user.uid)
        .then((value) {
      if (value) {
        Provider.of<Favoruites>(context, listen: false)
            .loadFavourites(user.uid)
            .then((value) {
          setState(() {
            _list = value;
            favLength = _list.length;
            isLoading = false;
          });
        });
      } else {
        setState(() {
          isFavExist = false;
        });
      }
    });

    super.initState();
  }

  void removeItem(String productId) {
    _list.removeWhere((element) => element.productUid == productId);
    setState(() {});
    Provider.of<Favoruites>(context, listen: false)
        .removeFavoruiteFromDb(productId, user.uid);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xff2B3252),
        statusBarIconBrightness: Brightness.light));
    final noFavouritesNotice = Container(
      height: 700,
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 300),
            Icon(
              Icons.sentiment_very_dissatisfied,
              color: Colors.red,
              size: 30,
            ),
            Text(
              'No favoruites',
              style: TextStyle(
                  fontFamily: 'RobodoCondended',
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 25),
            ),
          ],
        ),
      ),
    );
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
              SizedBox(width: 70),
              Text(
                'My Favourites',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 80),
              Tooltip(
                message: 'Cart size',
                child: Chip(
                  label: Text(
                    '$favLength',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: Colors.orange[300],
                ),
              ),
              SizedBox(width: 5)
            ],
          )),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            topBar,
            isFavExist
                ? Container(
                    height: 700,
                    child: isLoading
                        ? Loader('Preparing Favourites')
                        : _list.length == 0
                            ? noFavouritesNotice
                            : ListView.builder(
                                itemBuilder: (ctx, i) {
                                  return FavouriteItem(_list[i], removeItem);
                                },
                                itemCount: _list.length,
                              ))
                : noFavouritesNotice,
          ],
        ),
      ),
    );
  }
}
