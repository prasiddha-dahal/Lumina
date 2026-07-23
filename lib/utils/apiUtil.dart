import 'package:dio/dio.dart';

class Apiutil {

     static Dio dio = Dio(
      BaseOptions(baseUrl: "https://ecommerce.codeitappsware.com/api"),
    );
}  