import 'package:dio/dio.dart';
import 'package:flutter_app_sale_02022023/common/constants/app_constant.dart';

import 'dio_client.dart';

class ApiRequest {
  late Dio _dio;
  
  ApiRequest(){
    _dio = DioClient.instance.dio;
  }

  Future signInRequest({required String email, required String password}) {
    return _dio.post(AppConstant.SIGN_IN_URL, data: {
      "email" : email,
      "password" : password
    });
  }
}