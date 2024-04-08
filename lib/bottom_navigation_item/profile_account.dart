import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weekend/bottom_navigation_item/profile_edit.dart';
import 'package:weekend/controller/farm_controller.dart';
import 'package:weekend/log_in_regoster/log_in_page.dart';

import '../controller/user_controller.dart';

class Profile extends StatefulWidget {
  var data;

  Profile({Key? key, this.data = ""}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserController userController = Get.find();
  FarmController farmController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: (){
              Get.to(const ProfileEdit())?.then((value){
                setState(() {

                });
              });
            },
            child: Container(
              height: 150,
              width: Get.width,
              decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userController.userDetails['phone'] ?? "",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  Text(
                    userController.userDetails['email'] ?? "",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          option(icon1: Icons.account_balance_wallet, data: "Wallet"),
          option(icon1: Icons.help_center, data: "FAQs"),
          option(
              icon1: Icons.feedback_rounded,
              data: "Give us Feedback",
              onTap: () {
                farmController.txtReview.clear();
                return showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          top: 15,
                          right: 15,
                          left: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                                "Share your experience with us, it helps us to provide better service"),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextField(
                                controller: farmController.txtReview,
                                maxLines: 10,
                                decoration: InputDecoration(
                                    enabled: true, hintText: "Enter Here"),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  farmController.addReview();
                                  Get.back();
                                },
                                child: Text("Submit"))
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
          option(icon1: Icons.policy, data: "Privacy Policy"),
          option(icon1: Icons.privacy_tip, data: "Cancellation Policy"),
          option(
              icon1: Icons.call,
              data: "Call us",
              onTap: () {
                return showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  context: context,
                  builder: (context) {
                    return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Call Us"),
                          SizedBox(height: 20,),
                          Text("7046512232"),
                          SizedBox(height: 20,),

                          TextButton(onPressed: () {
                            // _makePhoneCall;
                            farmController.openDialPad('7046512232');
                          }, child: Text("Call"))
                        ]);
                  },
                );
                farmController.openDialPad('7046512232');
              }),
          option(
              icon1: Icons.logout,
              data: "Logout",
              onTap: () {
                showLogoutDialog(context);
              }),
        ],
      ),
    ));
  }

  Widget option({icon1, data, onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon1,
                  size: 22,
                ),
                SizedBox(
                  width: 18,
                ),
                Text(
                  data,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
            Icon(
              Icons.chevron_right_outlined,
              size: 24,
            )
          ],
        ),
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log Out'),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform log out logic here
                // For now, just close the dialog
                GetStorage().write("isLogin", false);
                Get.offAll(LogIn());
                // You might want to navigate to the login screen or perform other log out actions
              },
              child: Text('Log Out'),
            ),
          ],
        );
      },
    );
  }
  void _makePhoneCall() async {
    final String telScheme = 'tel:${7046512232}';
    if (await canLaunch(telScheme)) {
      await launch(telScheme);
    } else {
      throw 'Could not launch $telScheme';
    }
  }
}
