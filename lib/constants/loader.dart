import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  final String title;

  const Loader(this.title);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          alignment: Alignment.center,
          height: 150,
          width: 250,
          child: Column(
            children: <Widget>[
              SpinKitRotatingCircle(
                color: Color(0xff2B3252),
              ),
              SizedBox(height: 10),
              Text(title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ],
          )),
    );
  }
}
