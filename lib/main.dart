import 'package:flutter/material.dart';
import 'package:port/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'models/product_model.dart';
import 'screens/home_screen.dart';
import 'package:flutter/services.dart';

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (ctx) => Home(),
          ProductDetails.routeName: (ctx) => ProductDetails(),
        },
      ),
    );
  }
}
