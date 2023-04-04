import 'package:flutter_app_sale_02022023/data/datasources/remote/dto/product_dto.dart';

class CartDto {
  String? id;
  List<ProductDto>? productDTOs;
  num? price;

  CartDto({this.id, this.productDTOs, this.price});

  CartDto.fromJson(dynamic json) {
    id = json['_id'];
    if (json['products'] != null) {
      productDTOs = [];
      json['products'].forEach((v) {
        productDTOs?.add(ProductDto.fromJson(v));
      });
    }
    price = json['price'];
  }
}
