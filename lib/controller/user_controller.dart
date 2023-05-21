import 'package:get/get.dart';

class UserController extends GetxController {
  var userName = ''.obs;

  void updateUserName(String name) {
    userName.value = name;
  }
}
