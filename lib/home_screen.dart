import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weekend/bottom_navigation_item/booking.dart';
import 'package:weekend/bottom_navigation_item/explore.dart';
import 'package:weekend/bottom_navigation_item/favourite.dart';
import 'package:weekend/bottom_navigation_item/profile_account.dart';
import 'package:weekend/bottom_navigation_item/reewards.dart';
import 'package:weekend/constant.dart';
import 'package:weekend/controller/user_controller.dart';

import 'controller/farm_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FarmController farmController = Get.find();
  UserController userController = Get.find();
  int index = 0;
  final itemBody = [];
  List<BottomNavigationBarItem> bottomItem = [];

  @override
  void initState() {
    super.initState();
    farmController.getFarm();
    farmController.getFavorite();

    itemBody.add(const Explore());
    // itemBody.add(Favourite());
    if (!isAdminLogin) {
      itemBody.add(const Favourite());
    } else {
      const SizedBox();
    }
    // // isAdminLogin ? SizedBox() : ;
    itemBody.add(const Booking());
    itemBody.add(const Reewards());
    itemBody.add(Profile(
      data: userId,
    ));

    bottomItem.add(const BottomNavigationBarItem(
        icon: Icon(Icons.explore_rounded), label: "Explore"));
    isAdminLogin
        ? const SizedBox()
        : bottomItem.add(const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outlined), label: "Favorite"));

    bottomItem.add(
      const BottomNavigationBarItem(icon: Icon(Icons.book), label: "Bookings"),
    );
    bottomItem.add(
      const BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: "Rewards"),
    );
    bottomItem.add(
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle_rounded,
          ),
          label: "Profile"),
    );

    //
    // BottomNavigationBarItem(
    // icon: Icon(Icons.favorite), label: "Favorite"),
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          selectedItemColor: Colors.green,
          type: BottomNavigationBarType.fixed,
          items: bottomItem),
      body: itemBody[index],
    );
  }
}
