import 'package:flutter/material.dart';
import 'package:port/services/favourite.dart';
import 'package:provider/provider.dart';

class FavouriteItem extends StatefulWidget {
  final Favourite userFavourite;
  FavouriteItem(this.userFavourite);

  @override
  _FavouriteItemState createState() => _FavouriteItemState();
}

class _FavouriteItemState extends State<FavouriteItem> {
  @override
  Widget build(BuildContext context) {
    bool isNotFav = true;
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      height: 100,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage:
                AssetImage('assets/images/${widget.userFavourite.imagePath}'),
          ),
          title: FittedBox(
              child: Text(
            widget.userFavourite.name,
          )),
          subtitle: Text(
            'Rs ${widget.userFavourite.price}/-',
            style: TextStyle(color: Colors.green),
          ),
          trailing: IconButton(
              icon: Icon(
                isNotFav ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  isNotFav = false;
                });
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Item successfully deleted',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'RobotoCondensed'),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
