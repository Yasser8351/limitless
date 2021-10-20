import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'carts.dart';

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<void> addOrder(
      List<CartItem> cartProduct, double total, String phone) async {
    final time = DateTime.now();
    final url = "https://madeinsudan2.com/e-commerce/php_code/create_cart.php";
    await http.post(url,
        body: json.encode(
          {
            "amount": total,
            "dateTime": time.toIso8601String(),
            "order_id": getRandomString(8),
            "user_name": phone,
            "data": cartProduct
                .map((ca) => {
                      "title": ca.title,
                      "price": ca.price,
                      "quantity": ca.quantity
                    })
                .toList(),
          },
        ),
        headers: getHader());

    _orders.insert(
      0,
      OrderItem(amount: total, dateTime: time, products: cartProduct),
    );
    notifyListeners();
  }

  static Map<String, String> getHader() {
    return <String, String>{
      'Content-Type': 'application/json',
    };
  }
}

class OrderItem {
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.amount,
      @required this.products,
      @required this.dateTime});
}
