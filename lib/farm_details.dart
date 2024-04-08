import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weekend/bottom_navigation_item/booking.dart';
import 'package:weekend/bottom_navigation_item/explore.dart';
import 'package:weekend/constant.dart';

import 'controller/farm_controller.dart';

class FarmDetails extends StatefulWidget {
  final dynamic model;

  const FarmDetails({super.key, this.model});

  @override
  State<FarmDetails> createState() => _FarmDetailsState();
}

class _FarmDetailsState extends State<FarmDetails>
    with TickerProviderStateMixin {
  FarmController farmController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Farm Name"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
              child: Stack(fit: StackFit.expand, children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.model['image'],
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
                          child: Center(
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
                    )),
                Positioned(
                  bottom: 0,
                  right: 16,
                  child: InkWell(
                    onTap: () async {
                      openDialPad("7046512232");
                    },
                    child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.call,
                          color: Colors.green,
                        )),
                  ),
                ),
              ]),
            ),
            widget.model['farm_details'] != null
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.model['farm_name'],
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "\₹ ${widget.model['farm_details']['price_per_package']}",
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.model['farm_details']['location'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green,
                                  fontSize: 20),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 170,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.deepOrange,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.stars,
                                color: Colors.white,
                                size: 25,
                              ),
                              Text(
                                " 4.5 | 68 Reviews",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const DottedLine(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          lineLength: double.infinity,
                          lineThickness: 1.5,
                          dashLength: 10.0,
                          dashColor: Colors.black38,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  numbers(
                                      num: widget.model['farm_details']
                                              ["bedroom_count"] ??
                                          ""),
                                  widgetFacilites(text: "Bedrooms"),
                                ],
                              ),
                              Column(
                                children: [
                                  numbers(
                                      num: widget.model['farm_details']
                                              ["day_capacity"] ??
                                          ""),
                                  widgetFacilites(text: "Day Capacity"),
                                ],
                              ),
                              Column(
                                children: [
                                  numbers(
                                      num: widget.model['farm_details']
                                              ["night_capacity"] ??
                                          ""),
                                  widgetFacilites(text: "Night Capacity"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const DottedLine(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          lineLength: double.infinity,
                          lineThickness: 1.5,
                          dashLength: 10.0,
                          dashColor: Colors.black38,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          height: 450,
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent.withOpacity(.15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: widgetFacilites(
                                          text: "Check in Date")),
                                  Expanded(
                                      child: widgetFacilites(
                                          text: "Check out Date"))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: widgetTextField(
                                      controller: farmController.txtCheckInDate,
                                      onTap: () async {
                                        DateTime? date = await farmController
                                            .openDatePicker(context,
                                                firstDate: DateTime(2023),
                                                lastDate: DateTime(2025));
                                        farmController.txtCheckInDate.text =
                                            farmController
                                                .getDateInDDMMYY(date);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: widgetTextField(
                                    controller: farmController.txtCheckOutTime,
                                    onTap: () async {
                                      DateTime? date = await farmController
                                          .openDatePicker(context,
                                              firstDate: DateTime(2023),
                                              lastDate: DateTime(2025));
                                      farmController.txtCheckOutDate.text =
                                          farmController.getDateInDDMMYY(date);
                                      setState(() {});
                                    },
                                  ))
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: widgetFacilites(
                                          text: "Check In Time")),
                                  Expanded(
                                      child: widgetFacilites(
                                          text: "Check Out Time"))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: widgetTextField(
                                        controller: TextEditingController(
                                            text: widget.model['farm_details']
                                                ['check_in_time'])),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: widgetTextField(
                                        controller: TextEditingController(
                                            text: widget.model['farm_details']
                                                ['check_out_time'])),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              widgetFacilites(text: "Number of Guests"),
                              SizedBox(
                                height: 10,
                              ),
                              widgetTextField(enable: true),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  widgetFacilites(text: "Property Rent"),
                                  widgetFacilites(
                                      text: widget.model['farm_details']
                                          ['price_per_package'])
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  widgetFacilites(text: "Today's Discount"),
                                  // numbers(num: widget.model['discount_Price']??"")
                                  widgetFacilites(
                                      text: widget.model['farm_details']
                                              ['discount_Price'] ??
                                          "")
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.black26,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  titles(text: "Payable Amount"),
                                  titles(
                                      text:
                                          "${afterDiscountPrice().toString()}"),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.model['farm_name'],
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "\₹ ${widget.model['price_per_package']}",
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.model['location'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green,
                                  fontSize: 20),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 170,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.deepOrange,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.stars,
                                color: Colors.white,
                                size: 25,
                              ),
                              Text(
                                " 4.5 | 68 Reviews",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const DottedLine(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          lineLength: double.infinity,
                          lineThickness: 1.5,
                          dashLength: 10.0,
                          dashColor: Colors.black38,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  numbers(
                                      num: widget.model["bedroom_count"] ?? ""),
                                  widgetFacilites(text: "Bedrooms"),
                                ],
                              ),
                              Column(
                                children: [
                                  numbers(
                                      num: widget.model["day_capacity"] ?? ""),
                                  widgetFacilites(text: "Day Capacity"),
                                ],
                              ),
                              Column(
                                children: [
                                  numbers(
                                      num:
                                          widget.model["night_capacity"] ?? ""),
                                  widgetFacilites(text: "Night Capacity"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const DottedLine(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          lineLength: double.infinity,
                          lineThickness: 1.5,
                          dashLength: 10.0,
                          dashColor: Colors.black38,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          height: 450,
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent.withOpacity(.15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: widgetFacilites(
                                          text: "Check in Date")),
                                  Expanded(
                                      child: widgetFacilites(
                                          text: "Check out Date"))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: widgetTextField(
                                      controller: farmController.txtCheckInDate,
                                      onTap: () async {
                                        DateTime? date = await farmController
                                            .openDatePicker(context,
                                                firstDate: DateTime(2023),
                                                lastDate: DateTime(2025));
                                        farmController.txtCheckInDate.text =
                                            farmController
                                                .getDateInDDMMYY(date);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: widgetTextField(
                                    controller: farmController.txtCheckOutTime,
                                    onTap: () async {
                                      DateTime? date = await farmController
                                          .openDatePicker(context,
                                              firstDate: DateTime(2023),
                                              lastDate: DateTime(2025));
                                      farmController.txtCheckOutDate.text =
                                          farmController.getDateInDDMMYY(date);
                                      setState(() {});
                                    },
                                  ))
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: widgetFacilites(
                                          text: "Check In Time")),
                                  Expanded(
                                      child: widgetFacilites(
                                          text: "Check Out Time"))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: widgetTextField(
                                        controller: TextEditingController(
                                            text:
                                                widget.model['check_in_time'])),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: widgetTextField(
                                        controller: TextEditingController(
                                            text: widget
                                                .model['check_out_time'])),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              widgetFacilites(text: "Number of Guests"),
                              SizedBox(
                                height: 10,
                              ),
                              widgetTextField(enable: true),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  widgetFacilites(text: "Property Rent"),
                                  widgetFacilites(
                                      text: widget.model['price_per_package'])
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  widgetFacilites(text: "Today's Discount"),
                                  // numbers(num: widget.model['discount_Price']??"")
                                  widgetFacilites(
                                      text:
                                          widget.model['discount_Price'] ?? "")
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.black26,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  titles(text: "Payable Amount"),
                                  titles(
                                      text:
                                          "${afterDiscountPrice().toString()}"),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        height: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(spreadRadius: 10, blurRadius: 15, color: Colors.black54)
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${afterDiscountPrice().toString()}",
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                    Text("Inclusive of all charges")
                  ],
                )),
                InkWell(
                  onTap: () {
                    // Get.to( Booking());
                    // payNow();
                    widget.model['status'] == 1
                        ? farmController
                            .cancelBooking(widget.model["booking_id"])
                        : farmController.addBooking(widget.model, userId);
                    Get.back();
                  },
                  child: Container(
                    height: 45,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        widget.model['status'] == 1
                            ? "Cancel Booking"
                            : "Book Now",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              "By proceeding you agree to our T&C",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            ))
          ],
        ),
      ),
    );
  }

  openDialPad(String phoneNumber) async {
    Uri url = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Can't open dial pad.");
    }
  }

  Widget widgetFacilites({text}) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black38),
    );
  }

  Widget numbers({num}) {
    return Text(
      num,
      style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
    );
  }

  Widget titles({text}) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
    );
  }

  Widget widgetTextField(
      {TextEditingController? controller,
      Function()? onTap,
      bool enable = false}) {
    return InkWell(
      onTap: onTap,
      child: TextField(
        controller: controller,
        enabled: enable,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black26)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black26)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black26)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black26)),
        ),
      ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */

    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) =>
      showAlertDialog(
          context, "Payment Successful", "Payment ID: ${response.paymentId}");

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.of(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void payNow() {
    Razorpay razorpay = Razorpay();
    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'amount': 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }

  afterDiscountPrice() {
    int dis = 0;
    int totalRent =0;

    if (widget.model['farm_details'] != null) {
      if (widget.model['farm_details']['discount_Price'] != "") {
        dis = int.parse(widget.model['farm_details']['discount_Price'] ?? "0");
      }
      totalRent = int.parse(widget.model['farm_details']['price_per_package'] ?? "0");
    }else{
      if (widget.model['discount_Price'] != "") {
        dis = int.parse(widget.model['discount_Price'] ?? "0");
      }
      totalRent = int.parse(widget.model['price_per_package'] ?? "0");
    }




    int dValue = totalRent - dis;
    debugPrint("DIS=>${dValue}");

    return (totalRent - dis).toString();
  }
}
