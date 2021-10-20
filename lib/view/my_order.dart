import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:limitless/view_model/products_view_model.dart';
import 'package:provider/provider.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key key, @required this.phone}) : super(key: key);
  final phone;

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  DateTime timeBackPressed = DateTime.now();

  Future _data;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      _data = Provider.of<ProductsViewModel>(context)
          .fetchMyOrderlist(widget.phone)
          .then((_) => setState(() {
                _isLoading = false;
              }));
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var list =
        Provider.of<ProductsViewModel>(context, listen: false).myOrderlist;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "طلباتي",
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.navigate_before,
              size: 35,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: _isLoading
          ? Center(
              child: Image.asset("assets/image/a.gif"),
            )
          : WillPopScope(
              onWillPop: () async {
                final differenc = DateTime.now().difference(timeBackPressed);
                final exitApp = differenc >= Duration(seconds: 2);

                timeBackPressed = DateTime.now();

                if (exitApp) {
                  Fluttertoast.showToast(
                      msg: "اضغط مرة اخري للخروج",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      fontSize: 16.0);

                  return false;
                } else {
                  return true;
                }
              },
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Colors.white,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0, 1],
                        ),
                      ),
                      child: list == null
                          ? Center(
                              child: Text(
                                "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : FutureBuilder(
                              future: _data,
                              builder: (_, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: Center(
                                          child: Image.asset(
                                              "assets/image/a.gif")));
                                } else {
                                  if (snapshot.hasError) {
                                    return Text("some error");
                                  } else if (snapshot.hasData == null) {
                                    return Text("No data found");
                                  } else if (snapshot.hasData) {
                                    return Text("No data found");
                                  }
                                  return ListView.builder(
                                    itemCount: list.length,
                                    itemBuilder: (ctx, index) => Card(
                                      elevation: 10,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      color: list[index].status.contains("0")
                                          ? Colors.green
                                          : Colors.red,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "اسم المنتج",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                ":",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                "${list[index].title}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "كود الطلب",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                ":",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                "${list[index].orderId}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "سعر الفاتورة",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                ":",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                "ج.س ${list[index].price}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "الكمية",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                ":",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                "${list[index].quantity}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "تاريخ الطلب",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                ":",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                "${list[index].date}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          list[index].status.contains("0")
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "حالة الطلب",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      ":",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      "تم التأكيد",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "حالة الطلب",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      ":",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      "قيد الانتظار",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Icon(
                                                      Icons.schedule_sharp,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
