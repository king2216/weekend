import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weekend/constant.dart';
import 'package:weekend/controller/user_controller.dart';

class FarmController extends GetxController {
  UserController userController = Get.find();

  TextEditingController txtFarmName = TextEditingController();
  TextEditingController txtLocation = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtMaximumCapacity = TextEditingController();
  TextEditingController txtPricePerPackage = TextEditingController();
  TextEditingController txtBedRooms = TextEditingController();
  TextEditingController txtDayCapacity = TextEditingController();
  TextEditingController txtNightCapacity = TextEditingController();
  TextEditingController txtCheckInDate = TextEditingController();
  TextEditingController txtCheckOutDate = TextEditingController();
  TextEditingController txtCheckInTime = TextEditingController();
  TextEditingController txtCheckOutTime = TextEditingController();
  TextEditingController txtGuestsCount = TextEditingController();
  TextEditingController txtDiscount = TextEditingController();
  TextEditingController txtReview = TextEditingController();

  File? image;
  RxBool isSwimmingPoolAvailable = false.obs;
  RxBool isGamingZoneAvailable = false.obs;
  RxBool isPlayGroundAvailable = false.obs;
  RxBool isLoaderVisible = false.obs;

  TimeOfDay timeOfDay = TimeOfDay.now();
  final TextEditingController _timeC = TextEditingController();

  FirebaseStorage storage = FirebaseStorage.instance;

  RxList<dynamic> farmList = <dynamic>[].obs;
  RxList<dynamic> farmBookingList = <dynamic>[].obs;
  RxList<dynamic> favoriteList = <dynamic>[].obs;
  RxList<dynamic> favoriteFarmList = <dynamic>[].obs;

  void addFarm(downloadUrl) {
    isLoaderVisible.value = true;
    try {
      FirebaseFirestore.instance.collection('Farm').add({
        "farm_name": txtFarmName.text,
        "location": txtLocation.text,
        "contact_number": txtMobile.text,
        "maximum_capacity": txtMaximumCapacity.text,
        "price_per_package": txtPricePerPackage.text,
        "is_swimming_pool": isSwimmingPoolAvailable.value,
        "is_gaming_zone": isGamingZoneAvailable.value,
        "is_play_ground": isPlayGroundAvailable.value,
        "image": downloadUrl,
        "check_in_time" : txtCheckInTime.text,
        "check_out_time" : txtCheckOutTime.text,
        "bedroom_count": txtBedRooms.text,
        "day_capacity": txtDayCapacity.text,
        "night_capacity": txtNightCapacity.text,
      });
      getFarm();
      Get.back();
      isLoaderVisible.value = false;
    } catch (e) {
      debugPrint(e.toString());
      isLoaderVisible.value = false;
    }
  }

  void updateFarm({id, downloadUrl}) {
    isLoaderVisible.value = true;
    try {
      Map<String, dynamic> data = {
        "farm_name": txtFarmName.text,
        "location": txtLocation.text,
        "contact_number": txtMobile.text,
        "maximum_capacity": txtMaximumCapacity.text,
        "price_per_package": txtPricePerPackage.text,
        "is_swimming_pool": isSwimmingPoolAvailable.value,
        "is_gaming_zone": isGamingZoneAvailable.value,
        "is_play_ground": isPlayGroundAvailable.value,
        "discount_Price": txtDiscount.text,
        "bedroom_count": txtBedRooms.text,
        "day_capacity": txtDayCapacity.text,
        "check_in_time" : txtCheckInTime.text,
        "check_out_time" : txtCheckOutTime.text,
        "night_capacity": txtNightCapacity.text,
      };
      if (downloadUrl != null) {
        data["image"] = downloadUrl;
      }
      FirebaseFirestore.instance.collection('Farm').doc(id).update(data);
      getFarm();
      Get.back();
      isLoaderVisible.value = false;
    } catch (e) {
      debugPrint(e.toString());
      isLoaderVisible.value = false;
    }
  }

  // void insertFarm(downloadUrl) {
  //   isLoaderVisible.value = true;
  //   try {
  //     FirebaseFirestore.instance.collection('Farm').add({
  //       "farm_name": txtFarmName.text,
  //       "location": txtLocation.text,
  //       "contact_number": txtMobile.text,
  //       "maximum_capacity": txtMaximumCapacity.text,
  //       "price_per_package": txtPricePerPackage.text,
  //       "is_swimming_pool": isSwimmingPoolAvailable.value,
  //       "is_gaming_zone": isGamingZoneAvailable.value,
  //       "is_play_ground": isPlayGroundAvailable.value,
  //       "image": downloadUrl,
  //       "bedroom_count": txtBedRooms.text,
  //       "day_capacity": txtDayCapacity.text,
  //       "night_capacity": txtNightCapacity.text,
  //       "discount_Price": txtDiscount.text
  //     });
  //     getFarm();
  //     Get.back();
  //     isLoaderVisible.value = false;
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     isLoaderVisible.value = false;
  //   }
  // }

  void deleteFarm(String docId) {
    isLoaderVisible.value = true;
    try {
      FirebaseFirestore.instance.collection('Farm').doc(docId).delete();
      getFarm();
      isLoaderVisible.value = false;
    } catch (e) {
      debugPrint(e.toString());
      isLoaderVisible.value = false;
    }
  }

  Future getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
  }

  Future getImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);

      // debugPrint(image?.path.toString());
    }
  }

  Future showOptions(context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  Future<String> uploadFile() async {
    if (image == null) return "";
    final fileName = basename(image!.path);
    final destination = 'Images/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination);
      await ref.putFile(image!);
      var downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint('error occurred');
      return "";
    }
  }

  getFarm() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Farm').get();

    farmList.clear();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      dynamic item = querySnapshot.docs[i].data();

      item["id"] = querySnapshot.docs[i].id;
      item["favorite_loading"] = false;
      farmList.add(item);
    }
    debugPrint("");
  }

  getBooking() async {
    farmBookingList.clear();

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Booking')
        .where("user_id", isEqualTo: userId)
        .get();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      dynamic item = querySnapshot.docs[i].data();

      item["booking_id"] = querySnapshot.docs[i].id;
      item["favorite_loading"] = false;

      var farmDetails = await FirebaseFirestore.instance
          .collection("Farm")
          .doc('${item['farm_id']}')
          .get();

      item["farm_details"] = farmDetails.data();

      if (item['status'] == 1) {
        farmBookingList.add(item);
      }
    }
    debugPrint("");
    // 7600978848
  }

  Future<DateTime?> openDatePicker(context,
      {required DateTime firstDate, lastDate}) async {
    return await showDatePicker(
      context: context,
      // initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    );
  }

  String getDateInDDMMYY(date) {
    var d12 = DateFormat.yMd().format(date);
    return d12.toString().replaceAll("/", "-");
  }

  String getTime(time) {
    return _timeC.text = "${time.hour}:${time.minute}";
    // var d12 = TimeOfDay.fromDateTime(time);
    // return d12.toString().replaceAll("/", "-");
  }

  addToFavourite(id) {
    FirebaseFirestore.instance
        .collection("Favourite")
        .add({"farmId": id, "userId": userId});
  }

  getFavorite() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Favourite').get();

    favoriteList.clear();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      dynamic item = querySnapshot.docs[i].data();

      item["id"] = querySnapshot.docs[i].id;
      favoriteList.add(item);
    }
    debugPrint("");
  }

  getFavoriteList() async {
    favoriteFarmList.clear();

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Favourite")
        .where("userId", isEqualTo: userId)
        .get();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      dynamic item = querySnapshot.docs[i].data();

      item["id"] = querySnapshot.docs[i].id;
      String farmId = item['farmId'];
      var farmDetails =
          await FirebaseFirestore.instance.collection("Farm").doc(farmId).get();
      item['farmDetails'] = farmDetails.data();
      favoriteFarmList.add(item);
    }
  }

  removeFromFavourite(id) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Favourite")
        .where("farmId", isEqualTo: id)
        .where("userId", isEqualTo: userId)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return;
    }
    FirebaseFirestore.instance
        .collection("Favourite")
        .doc(querySnapshot.docs[0].id)
        .delete();
  }

  cancelBooking(id) {
    debugPrint(id);
    FirebaseFirestore.instance
        .collection("Booking")
        .doc(id)
        .update({'status': '2'});
  }

  addReview() {
    FirebaseFirestore.instance
        .collection("Review")
        .add({"review": txtReview.text, "user_id": userId});
  }

  checkFavorite(id, index) async {
    farmList[index]['favorite_loading'] = true;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Favourite")
        .where("farmId", isEqualTo: id)
        .where("userId", isEqualTo: userId)
        .get();
    farmList[index]['favorite_loading'] = true;
    if (querySnapshot.docs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  displayTimePicker(BuildContext context) async {
    var time = await showTimePicker(context: context, initialTime: timeOfDay);

    if (time != null) {
      _timeC.text = "${time.hour}:${time.minute}";
    }
    return _timeC.text;
  }

  void addBooking(model, userId) {
    isLoaderVisible.value = true;
    try {
      FirebaseFirestore.instance.collection('Booking').add({
        "farm_name": model['farm_name'],
        "mobile_number": model['contact_number'],
        "check_in_date": model['check_in_date'],
        "check_out_date": model['check_out_date'],
        "members": model['maximum_capacity'],
        "price": model['price_per_package'],
        "farm_id": model["id"],
        "user_id": userId,
        "image": model['image'],
        "status": 1,
      });
    } catch (e) {}
  }

  openDialPad(String phoneNumber) async {
    Uri url = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Can't open dial pad.");
    }
  }

  void shareAppLink() {
    // Replace 'Your App Link Here' with the link you want to share

    Share.share('Kinal');
  }

  void shareAppLinkViaWhatsApp() async {
    // Replace 'Your App Link Here' with the link you want to share
    String appLink = 'https://yourapp.com';

    // Use the share package to compose the message with the app link
    String text = 'Check out this cool app: $appLink';

    // Use the URL launcher to launch WhatsApp with the composed message
    String whatsappUrl = 'whatsapp://send?text=$text';

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      // If WhatsApp is not installed, share the message using other apps
      // debugPrint("Please Install Whatsapp");
      Share.share(text);
    }
  }
}
