import 'package:limitless/view/account.dart';
import 'package:limitless/view/cart_screen.dart';
import 'package:limitless/view/mainScreen.dart';
import 'package:limitless/view/tab_screen.dart';
import 'package:limitless/view_model/products_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/orders.dart';
import 'provider/carts.dart';
import 'view/home.dart';
import 'view/login.dart';
import 'view/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductsViewModel(),
        ),
        ChangeNotifierProvider.value(
          value: Carts(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Limitless shop',
        theme: ThemeData(
            fontFamily: "Brand Bold",
            primarySwatch: Theme.of(context).primaryColor,
            primaryColor: Color(0xffF851AD),
            accentColor: Color(0xffF851AD),
            primaryColorDark: Color(0xffAA0560),
            buttonColor: Color(0xffF851AD),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                color: Theme.of(context).primaryColor,
                fontFamily: "Brand Bold",
              ),
              bodyText2: TextStyle(
                fontSize: 20,
                fontFamily: "Brand Bold",
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            )),
        home: MainScreen(),
        routes: {
          Home.routeName: (ctx) => Home(),
          TabScreen.routeName: (ctx) => TabScreen(),
          Login.routeName: (ctx) => Login(),
          Register.routeName: (ctx) => Register(),
          Account.routeName: (ctx) => Account(),
          MainScreen.routeName: (ctx) => MainScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
