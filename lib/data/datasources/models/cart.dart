import 'package:flutter_app_sale_02022023/data/datasources/models/product_model.dart';

class Cart {
  String id = "";
  List<Product> products = List.empty(growable: true);
  num price = 0;

  Cart(this.id, this.products, this.price);
}
