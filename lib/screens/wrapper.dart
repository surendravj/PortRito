import 'package:flutter/material.dart';
import 'package:port/models/user_model.dart';
import 'package:port/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'Auth/login_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);
    return user != null ? Home() : LoginPage();
  }
}
