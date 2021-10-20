import 'package:limitless/model/my_order_model.dart';
import 'package:limitless/model/produects_model.dart';
import 'package:limitless/services/api.dart';
import 'package:flutter/cupertino.dart';

class ProductsViewModel with ChangeNotifier {
  List<ProductsModel> _productsList = [];
  List<MyOrderModel> _myOrderlist = [];

  Future<void> fetchProducts() async {
    _productsList = await Api().fetchProducts();
    notifyListeners();
  }

  Future<void> fetchMyOrderlist(String phone) async {
    _myOrderlist = await Api().fetchMyOrderlist(phone);
    notifyListeners();
  }

  List<ProductsModel> get productsList => _productsList;
  List<MyOrderModel> get myOrderlist => _myOrderlist;
}
