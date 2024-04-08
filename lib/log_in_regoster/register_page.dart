import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:weekend/controller/user_controller.dart';
import 'package:weekend/log_in_regoster/log_in_page.dart';
import 'package:weekend/log_in_regoster/otp_page.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  UserController userController = Get.find();
  bool _obscureText = true;

  final RegExp _mobileRegExp = RegExp(r'^[789]\d{9}$');
  final RegExp _emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  );
  final RegExp _passwordRegExp = RegExp(
    r'^(?=.*?[0-9]).{8,}$',
    caseSensitive: false,
    multiLine: false,
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Find Your Nearby \nFarmHouse",
              style: const TextStyle(
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
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                textField(
                    lenght: 10,
                    keyboardType: TextInputType.phone,
                    text: "  Enter Your Mobile Number",
                    value: _validateMobileNumber,
                    errorText: "Please Enter Mobile Number",
                    controller: userController.userMobile),
                SizedBox(
                  height: 15,
                ),
                textField(
                    text: "  Enetr Your Email Id",
                    value: validEmailId,
                    errorText: "Please Enter Email Id",
                    controller: userController.userEmail),
                SizedBox(
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
                    value: _validatePassword,
                    controller: userController.userPassword),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: (() async {
                      if (_formKey.currentState!.validate()) {
                        if (await userPhoneExists(
                                    userController.userMobile.text) ==
                                false &&
                            await userEmailExists(
                                    userController.userEmail.text) ==
                                false) {
                          userController.registerUser();
                          Get.to(LogIn());
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("User Already Exists"),
                          ));
                        }
                      }
                    }),
                    child: Text("Sign In"))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget textField(
      {text,
      errorText,
      bool? obscureText,
      TextInputType? keyboardType,
      suffixIcon,
      controller,
      int? lenght,
      value}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.black26),
      child: TextFormField(
        maxLength: lenght,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        controller: controller,
        validator: value,
        decoration: InputDecoration(
            counterText: "",
            suffixIcon: suffixIcon,
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: text,
            hintStyle: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w500)),
      ),
    );
  }

  String? _validateMobileNumber(value) {
    if (value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!_mobileRegExp.hasMatch(value)) {
      return 'Please enter a valid 10-digit mobile number';
    }
    return null;
  }

  String? validEmailId(value) {
    if (value.isEmpty) {
      return 'Please enter email id';
    } else if (!_emailRegExp.hasMatch(value)) {
      return 'Please enter a valid Email Id';
    }
    return null;
  }

  String? _validatePassword(value) {
    if (value.isEmpty) {
      return 'Please enter a password';
    } else if (_passwordRegExp.hasMatch(value)) {
      return 'Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 digit, 1 special character, and be at least 8 characters long';
    }
    return null;
  }

  // FirebaseStorage? firebaseStorage;

  Future<bool> userPhoneExists(String phoneNo) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("phone", isEqualTo: phoneNo)
        .get();
    if (querySnapshot.docs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> userEmailExists(String emailId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: emailId)
        .get();
    if (querySnapshot.docs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
