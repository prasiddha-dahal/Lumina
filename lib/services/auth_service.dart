import 'package:flutterecommerce/utils/apiUtil.dart';

class AuthService {
  //register

  static Future register(String name, String email, String password) async {
    final response = await Apiutil.dio.post(
      "/register",
      data: {"name": name, "email": email, "password": password},
    );
    return response;
  }

  static Future login(String email, String password) async {
    final response = await Apiutil.dio.post(
      "/login",
      data: {"email": email, "password": password},
    );
    return response;
  }

}
