import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:port/models/user_model.dart';
import 'package:port/services/favourite.dart';
import 'package:port/services/user.dart';
import 'package:port/widgets/loader.dart';
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
  void initState() {
    user = Provider.of<UserModel>(context, listen: false);
    Provider.of<Favoruites>(context, listen: false)
        .loadFavourites(user.uid)
        .then((value) {
      setState(() {
        _list = value;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ?  SpinKitWave(
              color: Color(0xff2B3252),
            )
            : Text(_list.toString()),
      ),
    );
  }
}
