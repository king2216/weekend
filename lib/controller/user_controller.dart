import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:weekend/constant.dart';
import 'package:weekend/home_screen.dart';

class UserController extends GetxController{

  TextEditingController userMobile = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  final box = GetStorage();
  var userDetails={};
  File? image;
  String imgUrl = "";


  void registerUser() {
    FirebaseFirestore.instance.collection("users").add({
      "email" : userEmail.text,
      "password": userPassword.text,
      "phone" : userMobile.text
    });
  }

  login(context) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').where("phone",isEqualTo:userMobile.text).where("password",isEqualTo: userPassword.text).get();

    if(querySnapshot.docs.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Username or Password")));
    }else{
      isLogin=true;
      box.write("isLogin", true);
      userId=querySnapshot.docs[0].id;
      userDetails=querySnapshot.docs[0].data() as Map<String,dynamic>;
      userDetails['id']=userId;
      if(querySnapshot.docs[0]['email']=="admin@gmail.com"){
        isAdminLogin=true;
      }else{
        isAdminLogin=false;
      }
      box.write("userDetails",userDetails);
      // box.write("userId", querySnapshot.docs[0].id);
      box.write("isAdminLogin", isAdminLogin);
      // box.write("email", querySnapshot.docs[0]['email']);
      Get.to(const HomeScreen());
    }

    // box.write("isLogin", true);

  }

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();

  String gender = "Male";


  updateProfile(id)  async {
    debugPrint(id);
    FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({'first_name':firstName.text,
      'last_name' : lastName.text,
      'date_of_birth': dateOfBirth.text,
      'phone' : userMobile.text,
      'email': userEmail.text,
      'gender' : gender,
      'image' : imgUrl

    }).then((value) async {
      DocumentSnapshot variable = await FirebaseFirestore.instance.collection('users').doc(id).get();


      debugPrint("ID${variable.id}");
      userDetails=variable.data() as Map<String,dynamic>;
      userDetails['id'] = variable.id;
      box.write("userDetails",userDetails);
      Get.back();

    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });



    debugPrint(userDetails.toString());

  }

  Future uploadFile() async {
    if (image == null) return "";
    final fileName = basename(image!.path);
    final destination = 'UserImage/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination);
      await ref.putFile(image!);
      imgUrl = await ref.getDownloadURL();
      debugPrint("imgURL=>${imgUrl}");

    }  catch (e) {
      debugPrint('error occurred');
    }
  }
}