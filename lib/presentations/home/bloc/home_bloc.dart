import 'dart:async';

import 'package:flutter_app_sale_02022023/common/bases/base_bloc.dart';
import 'package:flutter_app_sale_02022023/common/bases/base_event.dart';
import 'package:flutter_app_sale_02022023/data/datasources/models/product_model.dart';
import 'package:flutter_app_sale_02022023/data/datasources/repositories/product_repository.dart';
import 'package:flutter_app_sale_02022023/presentations/home/bloc/home_event.dart';

class HomeBloc extends BaseBloc {
  StreamController<List<Product>> _listProductsController = StreamController();
  ProductRepository? _productRepository;

  void setProductRepo(ProductRepository repository) {
    _productRepository = repository;
  }

  Stream<List<Product>> get listProductsStream => _listProductsController.stream;

  @override
  void dispatch(BaseEvent event) {
    switch (event.runtimeType) {
      case FetchProductsEvent:
        executeFetchProducts();
        break;
    }
  }

  void executeFetchProducts() {
    loadingSink.add(true);
    _productRepository?.fetchProducts().then((listProductDto) {
      if (listProductDto.isEmpty) return;
      var listProduct = List<Product>.empty(growable: true);
      listProductDto.forEach((productDto) {
        listProduct.add(Product(
            productDto.id ?? "",
            productDto.name ?? "",
            productDto.address ?? "",
            productDto.price ?? -1,
            productDto.img ?? "",
            productDto.quantity ?? -1,
            productDto.gallery ?? List.empty()
        ));
      });
      _listProductsController.sink.add(listProduct);
    }).catchError((e) {
      messageSink.add(e.toString());
    }).whenComplete(() => loadingSink.add(false));
  }
}
