import 'package:fluttertoast/fluttertoast.dart';
import 'package:limitless/services/api.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);
  static const routeName = "/register";

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  var api = Api();
  bool _isLoading = true;

  @override
  void dispose() {
    super.dispose();
    phone.dispose();
    password.dispose();
  }

  displayToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
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
                "assets/image/f2.png",
                width: 350,
                height: 300,
              ),
              SizedBox(height: sizedBoxHeight),
              TextField(
                controller: phone,
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
                    Icons.person,
                  ),
                  labelText: "رقم الهاتف",
                  labelStyle: TextStyle(fontSize: 14),
                  hintStyle: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ),
              SizedBox(height: sizedBoxHeight),
              TextField(
                obscureText: true,
                controller: password,
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
                  labelText: "كلمة المرور",
                  labelStyle: TextStyle(fontSize: 14),
                  hintStyle: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ),
              SizedBox(height: sizedBoxHeight),
              TextField(
                controller: confirmPassword,
                obscureText: true,
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
                  labelText: "تأكيد كلمة المرور",
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
                        if (phone.text.length < 10 ||
                            phone.text.length > 10 ||
                            phone.text.isEmpty) {
                          displayToast("يجب ادخال رقم هاتف من 10 خانات");
                        } else if (password.text.length < 6) {
                          displayToast("كلمة المرور لايجب أن تقل عن 6");
                        } else if (password.text != confirmPassword.text) {
                          displayToast("يجب ادخال تأكيد كلمة المرور بشكل صحيح");
                        } else {
                          setState(() {
                            _isLoading = false;
                          });
                          api.register(phone.text, password.text).then((value) {
                            setState(() {
                              _isLoading = true;
                            });
                            if (value == "success") {
                              displayToast("تم انشاء حساب بنجاح");
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  Login.routeName, (route) => false);
                            } else if (value == "error") {
                              displayToast("حدث خطأ اثناء انشاء الحساب");
                            }
                          });
                        }
                      },
                      child: Center(
                        child: Text(
                          "إنشاء حساب",
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
                        Login.routeName, (route) => false);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: "Brand Bold",
                            color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "لديك حساب مسبق؟",
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
        ),
      ),
    );
  }
}
