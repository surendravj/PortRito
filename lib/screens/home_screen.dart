import 'package:flutter/material.dart';
import 'package:port/models/product_model.dart';
import 'package:port/services/products.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('PortRito'),
        backgroundColor: Colors.brown[200],
      ),
      drawer: Drawer(),
      body:ListView.builder(itemBuilder: null)
    ));
  }
}
