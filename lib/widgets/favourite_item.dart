import 'package:flutter/material.dart';
import 'package:port/services/favourite.dart';

class FavouriteItem extends StatefulWidget {
  final Favourite userFavourite;
  final Function removeItem;
  FavouriteItem(this.userFavourite, this.removeItem);

  @override
  _FavouriteItemState createState() => _FavouriteItemState();
}

class _FavouriteItemState extends State<FavouriteItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        height: 100,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () {
                widget.removeItem(widget.userFavourite.productUid);
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Succesfully deleted the item')));
              },
            ),
          ),
        ));
  }
}
