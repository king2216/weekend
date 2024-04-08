import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weekend/controller/farm_controller.dart';

import '../add_farm_house.dart';
import '../constant.dart';
import '../farm_details.dart';

class FarmListForBooking extends StatefulWidget {
  const FarmListForBooking({super.key});

  @override
  State<FarmListForBooking> createState() => _FarmListForBookingState();
}

class _FarmListForBookingState extends State<FarmListForBooking> {
  FarmController farmController = Get.find();
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    farmController.getFarm();
    farmController.getFavoriteList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farm List"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(FarmDetails(
                  model: farmController.farmList[index],
                ));
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 450,
                width: Get.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                farmController.farmList[index]['image'] ?? "",
                            errorWidget: (context, url, error) {
                              return Container(
                                height: 150,
                                width: 200,
                                color: Colors.grey.shade100,
                              );
                            },
                            placeholder: (context, url) {
                              return Container(
                                height: 150,
                                width: 200,
                                child: const Center(
                                  child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator()),
                                ),
                              );
                            },
                            height: 350,
                            width: Get.width,
                            fit: BoxFit.cover,
                          ),
                          FutureBuilder(
                            future: farmController.checkFavorite(
                                farmController.farmList[index]['id'], index),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data == false
                                    ? IconButton(
                                        onPressed: () {
                                          farmController.addToFavourite(
                                              farmController.farmList[index]
                                                  ['id']);
                                          farmController.getFavorite();
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.favorite_outline,
                                            color: Colors.blue))
                                    : IconButton(
                                        onPressed: () {
                                          farmController.removeFromFavourite(
                                              farmController.farmList[index]
                                                  ['id']);
                                          farmController.getFavorite();
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.favorite_outlined,
                                            color: Colors.red));
                              }
                              return SizedBox();
                            },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        farmController.farmList[index]["farm_name"],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            farmController.farmList[index]["location"],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "  \₹ ${farmController.farmList[index]["price_per_package"]}",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: farmController.farmList.length),
    );
  }
}
// 7600978848