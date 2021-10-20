import 'dart:convert';

import 'package:limitless/model/my_order_model.dart';
import 'package:limitless/model/produects_model.dart';
import 'package:http/http.dart' as http;

class Api {
  String url = "https://madeinsudan2.com/e-commerce/php_code/show_products.php";
  Future<List<ProductsModel>> fetchProducts() async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        ProductsList products = ProductsList.fromJson(jsonData);
        List<ProductsModel> productsList = products.listProducts
            .map((e) => ProductsModel.fromJson(e))
            .toList();
        return productsList;
      } else {
        print('status code = ${response.statusCode}');
      }
    } catch (ex) {
      print(ex);
    }
  }

  Future<List<MyOrderModel>> fetchMyOrderlist(String phone) async {
    try {
      http.Response response = await http.get(
          'https://madeinsudan2.com/e-commerce/php_code/my_orders.php?phone=$phone'); //=$_phone
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        MyOrderList orders = MyOrderList.fromJson(jsonData);
        List<MyOrderModel> myBookingList =
            orders.listOrders.map((e) => MyOrderModel.fromJson(e)).toList();

        return myBookingList;
      } else {
        print('status code = ${response.statusCode}');
      }
    } catch (ex) {
      print(ex);
    }
  }

  Future<String> login(String phone, String password) async {
    var url =
        "https://madeinsudan2.com/e-commerce/php_code/login.php?phone=$phone&password=$password";
    String data;
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          "phone": phone,
          "password": password,
        },
      );

      data = json.decode(response.body);
      print(data);
    } catch (error) {
      print(error.toString());
    }
    return data;
  }

  Future<String> register(String phone, String password) async {
    var url =
        "https://madeinsudan2.com/e-commerce/php_code/register.php?phone=$phone&password=$password";
    String data;
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          "phone": phone,
          "password": password,
        },
      );

      data = json.decode(response.body);
      print(data);
    } catch (error) {
      print(error.toString());
    }
    return data;
  }
}
