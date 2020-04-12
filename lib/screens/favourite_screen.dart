import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  @override
  List<Favourite> _list;
  UserModel user;
  bool isLoading = true;
  bool isFavExist = true;
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

  removeItem(String id) {
    _list.removeWhere((element) => element.productUid == id);
  }

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2B3252),
        title: Text('Favourites'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: isFavExist
            ? isLoading
                ? SpinKitWave(
                    color: Color(0xff2B3252),
                  )
                : ListView.builder(
                    itemBuilder: (ctx, i) {
                      return FavouriteItem(_list[i]);
                    },
                    itemCount: _list.length,
                  )
            : noFavouritesNotice,
      ),
    );
  }
}
