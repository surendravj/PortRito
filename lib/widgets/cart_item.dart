import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final _cartItem;
  final Function removeItem;
  CartItem(this._cartItem, this.removeItem);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 5,
          bottom: 10,
        ),
        height: 150,
        width: 400,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          child: Row(
            children: <Widget>[
              Container(
                width: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  child: Image.asset(
                    'assets/images/${_cartItem['imagePath']}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 150,
                width: 220,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 8),
                        Text(
                          _cartItem['name'],
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8),
                        Text('Rs ${_cartItem['price']}/-',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.green)),
                        SizedBox(height: 8),
                        Text(
                          '${_cartItem['dimensions']}',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.red[300]),
                        ),
                        SizedBox(height: 8),
                        Text(
                          _cartItem['frameStatus'] ? 'With Frame' : 'No frame',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.brown),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                height: 150,
                color: Colors.grey[200],
                child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 30,
                    ),
                    onPressed: () => removeItem(_cartItem['productId'])),
              ))
            ],
          ),
        ));
  }
}
