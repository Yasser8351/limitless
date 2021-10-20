class ProductsModel {
  final String id;
  final String name;
  final String description;
  final String price;
  final String image;
  final String category;

  ProductsModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.image,
    this.category,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductsModel(
      id: jsonData['id'],
      name: jsonData['name'],
      description: jsonData['description'],
      price: jsonData['price'],
      image: jsonData['image'],
      category: jsonData['category'],
    );
  }
}

class ProductsList {
  final List<dynamic> listProducts;
  ProductsList({this.listProducts});
  factory ProductsList.fromJson(Map<String, dynamic> jsonData) {
    return ProductsList(
      listProducts: jsonData['products'],
    );
  }
}
