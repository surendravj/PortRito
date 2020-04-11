import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:port/services/auth.dart';
import 'package:port/widgets/loader.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String name;
  String phNumber;
  bool isError = false;
  bool isLoading = false;
  validatetForm() {
    var result = _key.currentState;
    if (result.validate()) {
      FocusScope.of(context).unfocus();
      setState(() {
        isLoading = true;
      });
      Auth().signIn(name, phNumber).then(
        (_) {
          setState(
            () {
              isLoading = false;
            },
          );
        },
      ).catchError((e) {
        print(e.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final email = TextFormField(
      onChanged: (val) {
        name = val;
      },
      validator: (val) {
        if (val.isEmpty) {
          return 'This Field is required';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Name',
        hintText: 'Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      onChanged: (val) {
        phNumber = val;
      },
      autofocus: false,
      keyboardType: TextInputType.phone,
      validator: (val) {
        if (val.isEmpty) {
          return 'This Field is required';
        }
        if (val.length != 10) {
          return "Invalid Number";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Phone Number',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: validatetForm,
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _key,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              Container(
                alignment: Alignment.center,
                width: 70,
                height: 70,
                child: isLoading ? FlipLoader() : Text(""),
              ),
              SizedBox(height: 48.0),
              email,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 24.0),
              loginButton,
            ],
          ),
        ),
      ),
    );
  }
}
