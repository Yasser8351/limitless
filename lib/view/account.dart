import 'package:limitless/view/mainScreen.dart';
import 'package:limitless/view/my_order.dart';
import 'package:limitless/widget/alertDialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  const Account({Key key}) : super(key: key);
  static const routeName = "/account";

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "حسابي",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: Text(""),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).buttonColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: ListTile(
                title: Text(
                  _phoneFromSharedPref == null ? "" : "$_phoneFromSharedPref",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                leading:
                    Icon(Icons.navigate_before, size: 35, color: Colors.white),
                trailing: Icon(Icons.person_pin, size: 30, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).buttonColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) =>
                              MyOrder(phone: _phoneFromSharedPref)));
                    },
                    child: Container(
                      child: ListTile(
                        title: Text(
                          "الطلبات",
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        leading: Icon(Icons.navigate_before,
                            size: 35, color: Colors.white),
                        trailing: Icon(Icons.menu_open_sharp,
                            size: 25, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 7),
                  GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushNamed(Login.routeName);
                      showDialog(
                        context: context,
                        builder: (ctx) => CustemDialog(
                          title: "1.0 الاصدار الاول",
                          description:
                              "جميع الحقوق محفوظة @ متجر الكتروني 2021",
                          buttonText: "موافق",
                        ),
                      );
                    },
                    child: Container(
                      child: ListTile(
                        title: Text(
                          "عن التطبيق",
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        leading: Icon(Icons.navigate_before,
                            size: 35, color: Colors.white),
                        trailing:
                            Icon(Icons.info, size: 25, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 7),
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.clear();
                      Navigator.of(context).pushNamed(MainScreen.routeName);
                    },
                    child: Container(
                      child: ListTile(
                        title: Text(
                          "تسجيل خروج",
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        leading: Icon(Icons.navigate_before,
                            size: 35, color: Colors.white),
                        trailing:
                            Icon(Icons.logout, size: 25, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
