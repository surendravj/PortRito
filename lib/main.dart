import 'package:flutter/material.dart';
import 'package:port/services/favourite.dart';
import 'package:port/screens/favourite_screen.dart';
import 'package:port/screens/wrapper.dart';
import 'package:port/services/auth.dart';
import 'package:provider/provider.dart';
import 'models/product_model.dart';
import 'package:flutter/services.dart';
import 'models/user_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductsList(),
        ),
        StreamProvider<UserModel>.value(value: Auth().userStatus),
        ChangeNotifierProvider.value(
          value: Favoruites(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (ctx) => Wrapper(),
          UserFavourites.routeName: (ctx) => UserFavourites(),
        },
      ),
    );
  }
}
