import 'package:flutter/material.dart';

class Rating {
  Row buildRow(rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: iconChild(rating),
    );
  }

  List<Widget> iconChild(String rating) {
    if (rating == '3') {
      return <Widget>[
        Icon(
          Icons.star,
          color: Colors.orange,
        ),
        Icon(
          Icons.star,
          color: Colors.orange,
        ),
        Icon(
          Icons.star,
          color: Colors.orange,
        ),
        Icon(
          Icons.star_border,
          color: Colors.orange,
        ),
        Icon(
          Icons.star_border,
          color: Colors.orange,
        )
      ];
    }
    if (rating == '4') {
      return <Widget>[
        Icon(
          Icons.star,
          color: Colors.orange,
        ),
        Icon(
          Icons.star,
          color: Colors.orange,
        ),
        Icon(
          Icons.star,
          color: Colors.orange,
        ),
        Icon(
          Icons.star,
          color: Colors.orange,
        ),
        Icon(
          Icons.star_border,
          color: Colors.orange,
        )
      ];
    } else {
      return <Widget>[
        Icon(
          Icons.star,
          color: Colors.orange,
        ),
        Icon(
          Icons.star,
          color: Colors.orange,
        ),
        Icon(
          Icons.star,
          color: Colors.orange,
        ),
        Icon(
          Icons.star,
          color: Colors.orange,
        ),
        Icon(
          Icons.star,
          color: Colors.orange,
        )
      ];
    }
  }
}
