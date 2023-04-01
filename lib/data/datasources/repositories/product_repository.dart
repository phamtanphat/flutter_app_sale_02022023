import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_app_sale_02022023/data/datasources/remote/api_request.dart';
import 'package:flutter_app_sale_02022023/data/datasources/remote/app_response.dart';
import 'package:flutter_app_sale_02022023/data/datasources/remote/dto/product_dto.dart';

class ProductRepository {
  ApiRequest? _apiRequest;

  void setApiRequest(ApiRequest apiRequest) {
    _apiRequest = apiRequest;
  }

  Future<List<ProductDto>> fetchProducts() async {
    Completer<List<ProductDto>> completerUserDto = Completer();
    try {
      Response response = await _apiRequest?.fetchListProductRequest();
      AppResponse<List<ProductDto>> appResponse = AppResponse.fromJson(response.data, ProductDto.convertJson);
      completerUserDto.complete(appResponse.data);
    } on DioError catch (e) {
      completerUserDto.completeError(e.response?.data["message"]);
    } catch (e) {
      completerUserDto.completeError(e);
    }
    return completerUserDto.future;
  }
}
