import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constant.dart';
import '../controller/farm_controller.dart';
import '../farm_details.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  FarmController farmController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    farmController.getFavoriteList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Favourites",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
        ),
        body: Obx(() => GridView.builder(
              itemCount: farmController.favoriteFarmList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2 / 3.00),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(FarmDetails(
                            model: farmController.favoriteFarmList[index]
                                ['farmDetails'],
                          ));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              CachedNetworkImage(
                                imageUrl: farmController.favoriteFarmList[index]
                                        ['farmDetails']['image'] ??
                                    "",
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
                                height: 150,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                              IconButton(
                                  onPressed: () {
                                    farmController.removeFromFavourite(
                                        farmController.favoriteFarmList[index]
                                            ['farmId']);
                                    farmController.getFavoriteList();
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.favorite_outlined,
                                      color: Colors.red))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("  ${farmController.favoriteFarmList[index]['farmDetails']["farm_name"]}"),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(farmController.favoriteFarmList[index]
                              ['farmDetails']["location"]),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                          "  \₹ ${farmController.favoriteFarmList[index]['farmDetails']["price_per_package"]}"),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
                
              },
            )));
  }
}
