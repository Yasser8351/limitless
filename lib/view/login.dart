import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:limitless/services/api.dart';
import 'package:limitless/view/register.dart';
import 'package:flutter/material.dart';
import 'package:limitless/view/tab_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);
  static const routeName = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _phone = TextEditingController();
  final _password = TextEditingController();
  var api = Api();
  bool _isLoading = true;

  @override
  void dispose() {
    super.dispose();
    _phone.dispose();
    _password.dispose();
  }

  displayToast(String message, bool istrue) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: istrue ? Colors.green : Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _savePhone(String phone) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() async {
      await pref.setString("phone", phone);
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizedBoxHeight = 24.0;

    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 22.0),
      child: Column(
        children: [
          Image.asset(
            "assets/image/f1.png",
            width: 350,
            height: 300,
          ),
          SizedBox(height: sizedBoxHeight),
          TextField(
            controller: _phone,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Colors.grey[400],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              prefixIcon: Icon(
                Icons.email,
              ),
              labelText: "رقم الهاتف",
              labelStyle: TextStyle(fontSize: 14),
              hintStyle: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
          SizedBox(height: sizedBoxHeight),
          TextField(
            obscureText: true,
            controller: _password,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Colors.grey[400],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              prefixIcon: Icon(
                Icons.lock_open_outlined,
              ),
              labelText: "كلمة المرور",
              labelStyle: TextStyle(fontSize: 14),
              hintStyle: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
          SizedBox(height: sizedBoxHeight),
          _isLoading
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      shadowColor: Theme.of(context).primaryColorDark),
                  onPressed: () {
                    if (_phone.text.length < 10 ||
                        _phone.text.length > 10 ||
                        _phone.text.isEmpty) {
                      displayToast("يجب ادخال رقم هاتف من 10 خانات", false);
                    } else if (_password.text.length < 6) {
                      displayToast("كلمة المرور لايجب أن تقل عن 6", false);
                    } else {
                      setState(() {
                        _isLoading = false;
                      });
                      api.login(_phone.text, _password.text).then((value) {
                        setState(() {
                          _isLoading = true;
                        });
                        if (value == "success") {
                          displayToast("تم تسجيل الدخول بنجاح", true);
                          _savePhone(_phone.text);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              TabScreen.routeName, (route) => false);
                        } else if (value == "error") {
                          displayToast(
                              "خطأ في اسم المستخدم او كلمة المرور", false);
                        }
                      });
                    }
                  },
                  child: Center(
                    child: Text(
                      "تسجيل الدخول",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Brand Bold",
                          color: Colors.white),
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
          SizedBox(height: sizedBoxHeight),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Register.routeName, (route) => false);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "انشاء حساب",
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: "Brand Bold",
                        color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "ليس لديك حساب؟",
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: "Brand Bold",
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )));
  }
}
