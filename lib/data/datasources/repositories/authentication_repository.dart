import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_app_sale_02022023/data/datasources/remote/api_request.dart';
import 'package:flutter_app_sale_02022023/data/datasources/remote/app_response.dart';
import 'package:flutter_app_sale_02022023/data/datasources/remote/dto/user_dto.dart';

class AuthenticationRepository {
  ApiRequest? _apiRequest;
  
  void setApiRequest(ApiRequest apiRequest) {
    _apiRequest = apiRequest;
  }
  
  Future<UserDto> signIn({required String email, required String password}) async{
    Completer<UserDto> completerUserDto = Completer();
    try {
      Response response = await _apiRequest?.signInRequest(email: email, password: password);
      AppResponse<UserDto> appResponse = AppResponse.fromJson(response.data, UserDto.fromJson);
      completerUserDto.complete(appResponse.data);
    } on DioError catch (e){
      completerUserDto.completeError(e.response?.data["message"]);
    } catch (e){
      completerUserDto.completeError(e);
    }
    return completerUserDto.future;
  }
}