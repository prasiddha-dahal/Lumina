import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OrderController extends GetxController{
  Rx<bool> isLoading = false.obs;
  ImagePicker imagePicker = ImagePicker();

  Rx<File?> image = null.obs;


  //Image Picker
  Future pickImage() async{
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null){
      image.value = File(pickedFile.path);    //type casting from XFile to File
    }
  }

  //Place Order

  
}