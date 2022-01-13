class Product {
  String name;
  String short_description;
  String price;
  String regular_price;
  String sale_price;
  int total_sales;
  List image;
  bool on_sale;

  Product({
    required this.name,
    required this.short_description,
    required this.price,
    required this.regular_price,
    required this.sale_price,
    required this.total_sales,
    required this.image,
    required this.on_sale,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      short_description: json['short_description'],
      price: json['price'],
      regular_price: json['regular_price'],
      sale_price: json['sale_price'],
      total_sales: json['total_sales'],
      image: json['images'],
      on_sale: json['on_sale'],
    );
  }
}

class ProductList {
  List<Product> products;

  ProductList({
    required this.products,
  });

  factory ProductList.fromJson(List<dynamic> parsedJson) {
    List<Product> products;
    products = parsedJson.map((i) => Product.fromJson(i)).toList();

    return ProductList(products: products);
  }
}
