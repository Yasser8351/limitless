class MyOrderModel {
  final String orderId;
  final String title;
  final String price;
  final String quantity;
  final String date;

  final String status;

  MyOrderModel(
      {this.orderId,
      this.title,
      this.price,
      this.quantity,
      this.date,
      this.status});

  factory MyOrderModel.fromJson(Map<String, dynamic> jsonData) {
    return MyOrderModel(
      orderId: jsonData['order_id'],
      title: jsonData['title'],
      price: jsonData['amounts'],
      quantity: jsonData['quantity'],
      date: jsonData['dateTime'],
      status: jsonData['status'],
    );
  }
}

class MyOrderList {
  final List<dynamic> listOrders;
  MyOrderList({this.listOrders});
  factory MyOrderList.fromJson(Map<String, dynamic> jsonData) {
    return MyOrderList(
      listOrders: jsonData['orders'],
    );
  }
}
