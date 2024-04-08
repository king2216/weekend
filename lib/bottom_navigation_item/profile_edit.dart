import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weekend/controller/farm_controller.dart';

import '../controller/user_controller.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final ImagePicker _picker = ImagePicker();
  UserController userController = Get.find();
  FarmController farmController = Get.find();
  String selectedGender = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.firstName.text = userController.userDetails['first_name']??'';
    userController.lastName.text = userController.userDetails['last_name']??'';
    userController.dateOfBirth.text = userController.userDetails['date_of_birth']??'';
    userController.userMobile.text = userController.userDetails['phone']??'';
    userController.userEmail.text = userController.userDetails['email']??'';
    userController.gender = userController.userDetails['gender']??'';
    userController.imgUrl = userController.userDetails['image']??'';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    userController.image
                        != null ?
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.all(Radius.circular(80)),
                        child: Image.network(
                          userController.imgUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ) :
                    userController.userDetails['image'] != ""
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(250),
                      child: Image.network(
                        userController.userDetails['image']??'',
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    )

                   :
                    SizedBox(
                            height: 120,
                            width: 120,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(80)),
                              child: Image.file(
                                userController.image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    Positioned(
                      bottom: 5,
                      child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.blue,
                          child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Upload File"),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            uploadFile(Icons.camera_alt,
                                                "Camera", ImageSource.camera),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            uploadFile(Icons.photo, "Gallery",
                                                ImageSource.gallery),
                                          ],
                                        ),
                                        SizedBox(height: 30),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Icon((Icons.mode_edit_rounded)))),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: textField(
                        text: "First Name",
                        txt: "First Name",
                        keyboard: TextInputType.name,
                        controller: userController.firstName),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: textField(
                          text: "Last Name",
                          txt: "Last Name",
                          controller: userController.lastName,
                          keyboard: TextInputType.name))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Gender",
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              RadioListTile(
                title: Text('Male'),
                value: 'Male',
                groupValue: userController.gender,
                onChanged: (value) {
                  setState(() {
                    userController.gender = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: Text('Female'),
                value: 'Female',
                groupValue: userController.gender,
                onChanged: (value) {
                  setState(() {
                    userController.gender = value.toString();
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              textField(
                  text: "Date Of Birth",
                  txt: "Date of birth",
                  controller: userController.dateOfBirth,
                  keyboard: TextInputType.phone),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: textField(
                        // txt: userController.userDetails["phone"] ??
                        //     "Phone Number",
                        text: "Phone Number",
                        controller: userController.userMobile,
                        keyboard: TextInputType.phone),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: textField(
                      text: "Email",
                      controller: userController.userEmail,
                    ),
                  )
                ],
              ),
              Center(child: TextButton(onPressed: () {
                userController.uploadFile();
                if(userController.imgUrl!=""){
                  userController.updateProfile(userController.userDetails['id']);
                }



              }, child: Text("Update")))
            ],
          ),
        ),
      ),
    );
  }

  Widget uploadFile(IconData? icon, text, ImageSource source) {
    return InkWell(
      onTap: () async {
        try {
          final pickedFile = await _picker.pickImage(source: source);

          setState(() {
            if (pickedFile != null) {
              userController.image = File(pickedFile.path);
            } else {
              print('No image selected.');
            }
          });
        } catch (e) {
          print('Error picking image: $e');
        }
        Get.back();
      },
      child: Column(
        children: [
          Icon(icon),
          SizedBox(
            height: 10,
          ),
          Text(text)
        ],
      ),
    );
  }

  Future<void> _getImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);

      setState(() {
        if (pickedFile != null) {
          userController.image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Widget textField(
      {txt, TextEditingController? controller, text, TextInputType? keyboard}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
              color: Colors.black45, fontSize: 15, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextField(
            controller: controller,
            keyboardType: keyboard,
            decoration: InputDecoration(
                hintText: txt,
                hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
                enabledBorder: InputBorder.none,
                border: OutlineInputBorder(borderSide: BorderSide())),
          ),
        ),
      ],
    );
  }
}
