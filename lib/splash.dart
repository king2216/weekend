import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weekend/constant.dart';
import 'package:weekend/controller/user_controller.dart';
import 'package:weekend/home_screen.dart';
import 'package:weekend/log_in_regoster/log_in_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final box = GetStorage();
  @override
  void initState() {
    super.initState();
    timer();

  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Weekend",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 30, color: Colors.black),
        ),
      ),
    );
  }

  timer() {
    isLogin=box.read("isLogin")??false;
    Future.delayed(const Duration(seconds: 2),() {
      if(isLogin==true){
        UserController userController=Get.find();
        userController.userDetails=box.read("userDetails");
        // userId= userController.userDetails['id']??'';

        isAdminLogin=box.read("isAdminLogin");
        Get.off(const HomeScreen());
      }else{
        Get.to(const LogIn());
      }


    },);
  }
}
