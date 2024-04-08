import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weekend/bottom_navigation_item/profile_account.dart';
import 'package:weekend/log_in_regoster/register_page.dart';

import '../OTPLOGIN/log_in.dart';
import '../controller/user_controller.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final RegExp _mobileRegExp = RegExp(r'^[789]\d{9}$');

  final formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  UserController userController = Get.find();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Find Your Nearby \nFarmHouse",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Image.asset(
              "assets/images/farmhousehub.jpeg",
              // fit: BoxFit.cover,
            ),
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  textField(
                    obscureText: false,
                      keyboard: TextInputType.number,
                      text: "  Enetr Your Mobile Number",
                      errorText: "Please Enter Mobile Number",
                      validator: (text) {
                        if (text == '') {
                          return 'Please Enter Mobile Number';
                        }
                        return null;
                      },
                      controller: userController.userMobile),
                  const SizedBox(
                    height: 15,
                  ),
                  textField(
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: _togglePasswordVisibility,
                      ),
                      obscureText: _obscureText,
                      text: "  Enetr Your Password",
                      errorText: "Please Enter Password",
                      controller: userController.userPassword),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                      onPressed: (() {
                        if (formKey.currentState!.validate()) {
                          userController.login(context);
                        }

                      }),
                      child: const Text("Log In")),
                  TextButton(
                      onPressed: (() {
                        Get.to(const Register());
                        // Get.to(Login());
                      }),
                      child: const Text("Register"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget textField(
      {text,
      Widget? suffixIcon,
      errorText,
      bool? obscureText,
      controller,
      String? Function(String?)? validator,
      TextInputType? keyboard}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.black26),
      child: TextFormField(
        keyboardType: keyboard,
        controller: controller,
        validator: validator,

        obscureText: obscureText ?? false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // validator:(value) {
        //   validation;
        // },
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: text,
            hintStyle: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w500)),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
