import 'package:flutter/material.dart';
import 'package:port/screens/favourite_screen.dart';
import 'package:port/services/auth.dart';

class SideDrawer extends StatelessWidget {
  final String name;
  final String phNumber;
  // final Function signout;
  SideDrawer(this.name, this.phNumber);
  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      radius: 30,
      backgroundImage: AssetImage('assets/logo.png'),
      backgroundColor: Colors.white,
    );

    final namewidget =
        Text(name, style: TextStyle(color: Colors.white, fontSize: 20));
    final phNumberwidget = Text(
      phNumber,
      style: TextStyle(color: Colors.white, fontSize: 15),
    );
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Color(0xff2B3252),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              rowWithSpace(10, avatar),
              SizedBox(height: 10),
              rowWithSpace(10, namewidget),
              SizedBox(height: 10),
              rowWithSpace(10, phNumberwidget),
            ],
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              rowWithName(context, Icons.home, 'Home', '/'),
              SizedBox(
                height: 15,
              ),
              rowWithName(context, Icons.shopping_basket, 'Orders', '/orders'),
              SizedBox(
                height: 15,
              ),
              rowWithName(
                  context, Icons.shopping_cart, 'Shoping cart', '/shopingCart'),
              Divider(),
              SizedBox(height: 20),
              rowWithName(context, Icons.settings, 'Settings', '/settings'),
              SizedBox(
                height: 15,
              ),
              rowWithName(context, Icons.favorite, 'My favorites',
                  UserFavourites.routeName),
              Divider(),
              Center(
                child: FlatButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black),
                    ),
                    color: Colors.white,
                    textColor: Colors.black,
                    onPressed: () {
                      Auth().signOut();
                    },
                    icon: Icon(Icons.lock),
                    label: Text('Sign out')),
              )
            ],
          ),
        )
      ],
    );
  }

  GestureDetector rowWithName(
      BuildContext context, IconData icon, String name, String routeName) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
      },
      child: Row(
        children: <Widget>[
          SizedBox(width: 25),
          Icon(
            icon,
            color: Colors.grey,
            size: 35,
          ),
          SizedBox(width: 30),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  Row rowWithSpace(double space, Widget widget) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 10,
        ),
        widget
      ],
    );
  }
}
