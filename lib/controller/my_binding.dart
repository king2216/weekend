import 'package:get/get.dart';
import 'package:weekend/controller/farm_controller.dart';
import 'package:weekend/controller/user_controller.dart';

class MyBinding with Bindings{
  @override
  void dependencies() {
    Get.lazyPut<FarmController>(() => FarmController(),fenix: true);
    Get.lazyPut<UserController>(() => UserController(),fenix: true);
  }

}