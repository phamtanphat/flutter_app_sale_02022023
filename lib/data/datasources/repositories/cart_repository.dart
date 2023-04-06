import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_app_sale_02022023/data/datasources/remote/api_request.dart';
import 'package:flutter_app_sale_02022023/data/datasources/remote/app_response.dart';
import 'package:flutter_app_sale_02022023/data/datasources/remote/dto/cart_dto.dart';

class CartRepository {
  ApiRequest? _apiRequest;

  void setApiRequest(ApiRequest apiRequest) {
    _apiRequest = apiRequest;
  }

  Future<CartDto> fetchCart() async {
    Completer<CartDto> completerCartDto = Completer();
    try {
      Response response = await _apiRequest?.fetchCart();
      AppResponse<CartDto> appResponse = AppResponse.fromJson(response.data, CartDto.fromJson);
      completerCartDto.complete(appResponse.data);
    } on DioError catch (e) {
      completerCartDto.completeError(e.response?.data["message"]);
    } catch (e) {
      completerCartDto.completeError(e);
    }
    return completerCartDto.future;
  }

  Future<CartDto> addCart(String idProduct) async {
    Completer<CartDto> completerCartDto = Completer();
    try {
      Response response = await _apiRequest?.addCart(idProduct: idProduct);
      AppResponse<CartDto> appResponse = AppResponse.fromJson(response.data, CartDto.fromJson);
      completerCartDto.complete(appResponse.data);
    } on DioError catch (e) {
      completerCartDto.completeError(e.response?.data["message"]);
    } catch (e) {
      completerCartDto.completeError(e);
    }
    return completerCartDto.future;
  }
}