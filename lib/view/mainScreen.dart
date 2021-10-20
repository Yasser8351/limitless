import 'package:limitless/view/tab_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

import 'login.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);
  static const routeName = "/main";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _phoneFromSharedPref;

  @override
  void initState() {
    super.initState();

    _loadPhone();
  }

  Future<void> _loadPhone() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _phoneFromSharedPref = pref.getString("phone");
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_phoneFromSharedPref == null) {
      return Login();
    } else {
      return TabScreen();
    }
  }
}
