import 'package:limitless/provider/carts.dart';
import 'package:flutter/material.dart';
import 'package:limitless/provider/orders.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/cart_item.dart' as w;

class CartScreen extends StatefulWidget {
  static const routeName = "/CartScreen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
    final cart = Provider.of<Carts>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("سلة التسوق"),
        centerTitle: true,
      ),
      body: cart.totalAmount == 00.0
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    color: Theme.of(context).buttonColor,
                    size: 100,
                  ),
                  Text(
                    "سلة المشتريات فارغة حالياً",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.item.length,
                    itemBuilder: (context, i) => w.CartItem(
                      cart.item.values.toList()[i].id,
                      cart.item.keys.toList()[i],
                      cart.item.values.toList()[i].price,
                      cart.item.values.toList()[i].quantity,
                      cart.item.values.toList()[i].title,
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: Card(
        margin: EdgeInsets.all(15),
        child: Container(
          height: size.height / 10,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Spacer(),
                Chip(
                  label: Text(
                    "\$${cart.totalAmount.toStringAsFixed(2)}",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                OrderButton(cart: cart, phone: _phoneFromSharedPref),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
    this.phone,
  }) : super(key: key);

  final Carts cart;
  final String phone;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Text(
              "شراء الآن",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.item.values.toList(),
                  widget.cart.totalAmount,
                  widget.phone);
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear();
            },
    );
  }
}
