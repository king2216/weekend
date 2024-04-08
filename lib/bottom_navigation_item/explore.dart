import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weekend/constant.dart';

import '../add_farm_house.dart';
import '../controller/farm_controller.dart';
import '../farm_details.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  FarmController farmController = Get.find();
  int index = 0;

  void toggleFavorite(String item) {
    setState(() {
      if (farmController.farmList.contains(item)) {
        farmController.farmList
            .remove(item); // Remove from favorites if already favorited
      } else {
        farmController.farmList.add(item); // Add to favorites if not favorited
      }
    });
  }

  @override
  void initState() {
    super.initState();
    farmController.getFarm();
    farmController.getFavorite();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          isAdminLogin
              ? IconButton(
                  onPressed: () {
                    Get.to( AddFarmHouse());
                  },
                  icon: const Icon(Icons.add))
              : const SizedBox()
        ],
        title: const Text("Farm List"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          child: Stack(
            // alignment: Alignment.bottomCenter ,
            children: [
              Image.asset(
                "assets/images/farmhousebg.jpg",
                // height: Get.height ,
                width: Get.width,
                height: 300,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 250,
                child: Container(
                  height: Get.height,
                  // height: 100,
                  width: Get.width,
                  decoration: BoxDecoration(
                      // borderRadius: const BorderRadius.only(
                      //     topRight: Radius.circular(30),
                      //     topLeft: Radius.circular(30)),
                      border: Border.all(color: Colors.black26),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Most Recommended",
                          style: TextStyle(
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 300,
                          child: Obx(() => ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height: 300,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(FarmDetails(
                                              model: farmController
                                                  .farmList[index],
                                            ));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            child: Stack(
                                              alignment:
                                              AlignmentDirectional.topEnd,
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: farmController
                                                      .farmList[index]
                                                  ['image'] ??
                                                      "",
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return Container(
                                                      height: 150,
                                                      width: 200,
                                                      color:
                                                      Colors.grey.shade100,
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
                                                            child:
                                                            CircularProgressIndicator()),
                                                      ),
                                                    );
                                                  },
                                                  height: 150,
                                                  width: 200,
                                                  fit: BoxFit.cover,
                                                ),
                                                !isAdminLogin
                                                    ? FutureBuilder(
                                                  future: farmController
                                                      .checkFavorite(
                                                      farmController
                                                          .farmList[
                                                      index]
                                                      ['id'],
                                                      index),
                                                  builder: (context,
                                                      snapshot) {
                                                    if (snapshot
                                                        .hasData) {
                                                      return snapshot.data ==
                                                          false
                                                          ? IconButton(
                                                          onPressed:
                                                              () {
                                                            farmController.addToFavourite(
                                                                farmController.farmList[index]
                                                                [
                                                                'id']);
                                                            farmController
                                                                .getFavorite();
                                                            setState(
                                                                    () {});
                                                          },
                                                          icon: const Icon(
                                                              Icons
                                                                  .favorite_outline,
                                                              color: Colors
                                                                  .blue))
                                                          : IconButton(
                                                          onPressed:
                                                              () {
                                                            farmController.removeFromFavourite(
                                                                farmController.farmList[index]
                                                                [
                                                                'id']);
                                                            farmController
                                                                .getFavorite();
                                                            setState(
                                                                    () {});
                                                          },
                                                          icon: const Icon(
                                                              Icons
                                                                  .favorite_outlined,
                                                              color: Colors
                                                                  .red));
                                                    }
                                                    return const SizedBox();
                                                  },
                                                )
                                                    : Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          Get.to(AddFarmHouse(model: farmController.farmList[index],
                                                          scw: {
                                                            "kinal":"kinal"
                                                          },
                                                          ));
                                                        },
                                                        icon: const Icon(
                                                          Icons.edit,
                                                          color: Colors.red,
                                                          size: 30,
                                                        )),
                                                    IconButton(
                                                        onPressed: () {
                                                          farmController.deleteFarm(
                                                              farmController
                                                                  .farmList[
                                                              index]['id']);
                                                        },
                                                        icon: const Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                          size: 30,
                                                        )),
                                                  ],
                                                )
                                                // Row(children: [

                                                //   if (!isAdminLogin) ...[
                                                //     if (!farmController
                                                //             .farmList[index][
                                                //         'favorite_loading']) ...[
                                                //       if (farmController
                                                //           .checkFavorite(
                                                //               farmController
                                                //                       .farmList[
                                                //                   index]['farmId'],
                                                //               index)) ...[
                                                //         IconButton(
                                                //             onPressed: () {
                                                //               farmController.addToFavourite(
                                                //                   farmController
                                                //                           .farmList[
                                                //                       index]['id']);
                                                //               farmController
                                                //                   .getFavorite();
                                                //               setState(() {});
                                                //             },
                                                //             icon: Icon(
                                                //                 Icons
                                                //                     .favorite_outlined,
                                                //                 color: Colors
                                                //                     .red)),
                                                //       ] else ...[
                                                //         IconButton(
                                                //             onPressed: () {
                                                //               farmController.addToFavourite(
                                                //                   farmController
                                                //                           .farmList[
                                                //                       index]['id']);
                                                //               farmController
                                                //                   .getFavorite();
                                                //               setState(() {});
                                                //             },
                                                //             icon: Icon(
                                                //                 Icons
                                                //                     .favorite_border,
                                                //                 color: Colors
                                                //                     .black)),
                                                //       ]
                                                //     ],
                                                //
                                                //     isAdminLogin
                                                //         ? IconButton(
                                                //             onPressed: () {
                                                //               farmController.deleteFarm(
                                                //                   farmController
                                                //                           .farmList[
                                                //                       index]['id']);
                                                //             },
                                                //             icon: const Icon(
                                                //               Icons.delete,
                                                //               color: Colors.red,
                                                //               size: 30,
                                                //             ))
                                                //         : SizedBox()
                                                //   ],
                                                // ])
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(farmController.farmList[index]
                                        ["farm_name"]),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Icon(
                                              Icons.location_on_outlined,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(farmController.farmList[index]
                                            ["location"]),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            "  \₹ ${farmController.farmList[index]["price_per_package"]}"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    width: 10,
                                  );
                                },
                                itemCount: farmController.farmList.length,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
