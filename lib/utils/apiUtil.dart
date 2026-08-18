import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Apiutil {
  static Dio dio = Dio(
    BaseOptions(baseUrl: dotenv.env['BASE_URL'] ?? "https://ecommerce.codeitappsware.com/api"),
  );
}  