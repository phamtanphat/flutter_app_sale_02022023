import 'package:dio/dio.dart';
import 'package:flutter_app_sale_02022023/common/constants/app_constant.dart';

class DioClient {
  Dio? _dio;
  static final BaseOptions _options = BaseOptions(
    baseUrl: AppConstant.BASE_URL,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  static final DioClient instance = DioClient._internal();

  DioClient._internal() {
    if (_dio == null){
      _dio = Dio(_options);
      _dio!.interceptors.add(LogInterceptor(requestBody: true));
    }
  }

  Dio get dio => _dio!;
}