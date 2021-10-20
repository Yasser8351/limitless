import 'package:limitless/provider/carts.dart';
import 'package:limitless/view_model/products_view_model.dart';
import 'package:limitless/widget/badge.dart';
import 'package:limitless/widget/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';

class Home extends StatefulWidget {
  static const routeName = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int guantity = 1;
  Future _data;
  var _isInit = true;
  var _isLoading = false;
  List<Item> listCategory = [
    Item(title: 'جمال', icon: Icons.pages),
    Item(title: 'فاشون', icon: Icons.cached_rounded),
    Item(title: 'ديكور', icon: Icons.graphic_eq_rounded),
    Item(title: 'هدايا', icon: Icons.wallet_giftcard),
    Item(title: 'جرافيك ديزاين', icon: Icons.grass_sharp),
    Item(title: 'دورات تعليمية', icon: Icons.grading_sharp),
  ];
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
          .fetchProducts()
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
        Provider.of<ProductsViewModel>(context, listen: false).productsList;
    final cart = Provider.of<Carts>(context, listen: false);

    final sizedBoxHeight = 24.0;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [],
        leading: Consumer<Carts>(
          builder: (_, cart, ch) => Badge(
            child: ch,
            value: cart.itemCount.toString(),
          ),
          child: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              "assets/image/f3.png",
              width: 350,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 7),
                  SizedBox(height: sizedBoxHeight),
                  Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: Text(
                      "التصنيفات",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listCategory.length,
                  itemBuilder: (ctx, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          child: Icon(listCategory[index].icon,
                              color: Colors.white),
                          decoration: BoxDecoration(
                            color: Theme.of(context).buttonColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          listCategory[index].title,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 34, top: 20, left: 34),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "عرض الكل",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {},
                    child: Text(
                      "المنتجات",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            _isLoading
                ? Center(
                    child: Image.asset("assets/image/a.gif"),
                  )
                : GestureDetector(
                    onTap: () {},
                    child: list == null
                        ? Text("")
                        : Container(
                            color: Colors.grey[100],
                            height: size.height - 180,
                            child: FutureBuilder(
                              future: _data,
                              builder: (_, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                  //Center(
                                  //   child: Image.asset("assets/image/.gif"))
                                } else {
                                  if (snapshot.hasError) {
                                    return Text("some error");
                                  } else if (snapshot.hasData == null) {
                                    return Text("No data found");
                                  } else if (snapshot.hasData) {
                                    return Text("No data found");
                                  }
                                  return GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.all(10.0),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 1 / 1.5,
                                            mainAxisSpacing: 20,
                                            crossAxisSpacing: 10),
                                    itemCount: list.length,
                                    itemBuilder: (ctx, index) => Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                            child: FadeInImage(
                                              placeholder: AssetImage(
                                                  "assets/image/placeholder.png"),
                                              image: NetworkImage(
                                                "${list[index].image}",
                                              ),
                                              width: 200,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Text(
                                            "${list[index].name}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "${list[index].price}",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                icon:
                                                    Icon(Icons.favorite_border),
                                                onPressed: () {},
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              IconButton(
                                                  icon:
                                                      Icon(Icons.shopping_cart),
                                                  onPressed: () {
                                                    cart.addItem(
                                                      list[index].id.toString(),
                                                      list[index].name,
                                                      double.parse(
                                                          list[index].price),
                                                    );
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .hideCurrentSnackBar();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            "تم اضافة المنتج الي السلة"),
                                                        duration: Duration(
                                                            seconds: 2),
                                                        action: SnackBarAction(
                                                          label: "إلغاء",
                                                          onPressed: () {
                                                            cart.cancelOrder(
                                                                list[index]
                                                                    .id
                                                                    .toString());
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ],
                                          ),
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
