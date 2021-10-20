import 'package:limitless/view/cart_screen.dart';

import 'account.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key key}) : super(key: key);
  static const routeName = "/tab";

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  void initState() {
    super.initState();
  }

  DateTime timeBackPressed = DateTime.now();
  List<Widget> _pages = [
    Account(),
    CartScreen(),
    Home(),
  ];
  int _currentPage = 2;
  void _selectedPage(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: WillPopScope(
              onWillPop: () async {
                final differenc = DateTime.now().difference(timeBackPressed);
                final exitApp = differenc >= Duration(seconds: 2);

                timeBackPressed = DateTime.now();

                if (exitApp) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      duration: Duration(seconds: 2),
                      content: Text(
                        "اضغط مرة أخري للخروج",
                        textAlign: TextAlign.right,
                      ),
                    ),
                  );
                  return false;
                } else {
                  return true;
                }
              },
              child: Scaffold(
                body: _pages[_currentPage],
                bottomNavigationBar: BottomNavigationBar(
                  onTap: _selectedPage,
                  selectedItemColor: Theme.of(context).accentColor,
                  unselectedItemColor: Colors.black38,
                  currentIndex: _currentPage,
                  items: [
                    BottomNavigationBarItem(
                      label: "حسابي",
                      backgroundColor: Colors.white,
                      icon: Icon(
                        Icons.person,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "سلة التسوق",
                      backgroundColor: Colors.white,
                      icon: Icon(
                        Icons.shopping_cart,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "الرئيسية",
                      backgroundColor: Colors.white,
                      icon: Icon(
                        Icons.home,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
