import 'package:get_storage/get_storage.dart';

class StorageController {

  final box = GetStorage();

  void saveToken(String token){
    box.write("token", token );
  }

  String? getToken(){
    return box.read("token");
  }

  void removeToken(){
    box.remove("token");
  }
}