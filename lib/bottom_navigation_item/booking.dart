import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:weekend/farm_details.dart';

import '../controller/farm_controller.dart';
import 'farm_list_for_booking.dart';

class Booking extends StatefulWidget {
  final dynamic model;

  const Booking({super.key, this.model});

  @override
  State<Booking> createState() => _BookingState();
}

var _razorpay = Razorpay();

class _BookingState extends State<Booking> {
  FarmController farmController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    farmController.getBooking();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Booking Summary"),
        ),
        body: Obx(
          () => farmController.farmBookingList.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (context, index) {

                   return farmController.farmBookingList[index]['status'] == 1 ?
                     Container(
                      margin: EdgeInsets.all(10),
                      height: 500,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black26,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(FarmDetails(
                                model: farmController.farmBookingList[index],
                              ));
                            },
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Stack(
                                    alignment: AlignmentDirectional.topEnd,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: farmController
                                            .farmBookingList[index]
                                        ['farm_details']==null?"": farmController
                                                    .farmBookingList[index]
                                                ['farm_details']['image'] ?? "",
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
                                                  child:
                                                      CircularProgressIndicator()),
                                            ),
                                          );
                                        },
                                        height: 350,
                                        width: Get.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                                FutureBuilder(
                                  future: farmController.checkFavorite(
                                      farmController.farmBookingList[index]
                                          ['farm_id'],
                                      index),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return snapshot.data == false
                                          ? IconButton(
                                              onPressed: () {
                                                farmController.addToFavourite(
                                                    farmController
                                                            .farmBookingList[
                                                        index]['farm_id']);
                                                farmController.getFavorite();
                                                setState(() {});
                                              },
                                              icon: Icon(Icons.favorite_outline,
                                                  color: Colors.blue))
                                          : IconButton(
                                              onPressed: () {
                                                farmController
                                                    .removeFromFavourite(
                                                        farmController
                                                                .farmBookingList[
                                                            index]['farm_id']);
                                                farmController.getFavorite();
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                  Icons.favorite_outlined,
                                                  color: Colors.red));
                                    }
                                    return SizedBox();
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              farmController.farmBookingList[index]
                              ['farm_details']==null?'-': farmController.farmBookingList[index]
                                      ['farm_details']["farm_name"] ??
                                  "-",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
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
                                  farmController.farmBookingList[index]
                                  ['farm_details']==null?'-':
                                  farmController.farmBookingList[index]
                                      ['farm_details']["location"],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text( farmController.farmBookingList[index]
                            ['farm_details']==null?'-':
                              "  \₹ ${farmController.farmBookingList[index]['farm_details']["price_per_package"]}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              // style: ButtonStyle(),
                              onPressed: () {
                                farmController.cancelBooking(farmController.farmBookingList[index]["booking_id"]);
                                // farmController.getBooking();
                                setState(() {

                                });

                              },
                              child: Text("Cancel Booking"))
                        ],
                      ),
                    ):SizedBox.shrink();
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: farmController.farmBookingList.length)
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Nothing is Here Start Your Booking Now.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(
                            onPressed: () {
                              Get.to(FarmListForBooking());
                            },
                            child: Text("Book Now"))
                      ],
                    ),
                  ),
                ),
        ));
  }
}
