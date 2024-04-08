import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weekend/controller/farm_controller.dart';

class AddFarmHouse extends StatefulWidget {
  final dynamic model;
  Map<String, dynamic>? scw = {};

  AddFarmHouse({super.key, this.model, this.scw});

  @override
  State<AddFarmHouse> createState() => _AddFarmHouseState();
}

class _AddFarmHouseState extends State<AddFarmHouse> {
  FarmController farmController = Get.find();
  File? image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.model == null) {
      farmController.txtFarmName.clear();
      farmController.txtLocation.clear();
      farmController.txtMaximumCapacity.clear();
      farmController.txtMobile.clear();
      farmController.txtBedRooms.clear();
      farmController.txtDayCapacity.clear();
      farmController.txtNightCapacity.clear();
      farmController.txtCheckInDate.clear();
      farmController.txtCheckOutTime.clear();
      farmController.txtDiscount.clear();
      farmController.txtPricePerPackage.clear();
      farmController.isGamingZoneAvailable.value = false;
      farmController.isPlayGroundAvailable.value = false;
      farmController.isSwimmingPoolAvailable.value = false;
      farmController.image = null;
    } else {
      farmController.txtFarmName.text = widget.model['farm_name'];
      farmController.txtLocation.text = widget.model['location'];
      farmController.txtMaximumCapacity.text = widget.model['maximum_capacity'];
      farmController.txtMobile.text = widget.model['contact_number'];
      farmController.txtCheckInDate.text;
      farmController.txtCheckOutTime.text;
      farmController.txtDayCapacity.text = widget.model['day_capacity'];
      farmController.txtDayCapacity.text = widget.model['night_capacity'];
      farmController.txtPricePerPackage.text =
          widget.model['price_per_package'];
      farmController.txtDiscount.text = widget.model['discount_Price']??"0";
      farmController.isGamingZoneAvailable.value =
          widget.model['is_gaming_zone'];
      farmController.isPlayGroundAvailable.value =
          widget.model['is_play_ground'];
      farmController.isSwimmingPoolAvailable.value =
          widget.model['is_swimming_pool'];
      farmController.image = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Farm Details"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addDetails(
                    hintText: "Farm Name",
                    validator: (value) {
                      if (value == "") {
                        return "Please Enter Farm Name";
                      }
                      return null;
                    },
                    controller: farmController.txtFarmName),
                const SizedBox(
                  height: 10,
                ),
                addDetails(
                    hintText: "Location",
                    validator: (value) {
                      if (value == "") {
                        return "Please Enter Location";
                      }
                      return null;
                    },
                    controller: farmController.txtLocation),
                const SizedBox(
                  height: 10,
                ),
                addDetails(
                    hintText: "Contact Number",
                    validator: (value) {
                      if (value == "") {
                        return "Please Enter Mobile Number";
                      }
                      return null;
                    },
                    controller: farmController.txtMobile),
                const SizedBox(
                  height: 10,
                ),
                addDetails(
                    hintText: "Maximum Members",
                    validator: (value) {
                      if (value == "") {
                        return "Please Enter Maximun Members";
                      }
                      return null;
                    },
                    controller: farmController.txtMaximumCapacity),
                const SizedBox(
                  height: 10,
                ),
                addDetails(
                    hintText: "Package Price",
                    validator: (value) {
                      if (value == "") {
                        return "Please Enter Price";
                      }
                      return null;
                    },
                    controller: farmController.txtPricePerPackage),
                const SizedBox(
                  height: 10,
                ),
                addDetails(
                    hintText: "Bed Rooms",
                    validator: (value) {
                      if (value == "") {
                        return "Please Enter Number of Bedrooms";
                      }
                      return null;
                    },
                    controller: farmController.txtBedRooms),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: addDetails(
                          hintText: "Day Capacity",
                          validator: (value) {
                            if (value == "") {
                              return "Please Enter Day Capacity";
                            }
                            return null;
                          },
                          controller: farmController.txtDayCapacity),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: addDetails(
                          hintText: "Night Capacity",
                          validator: (value) {
                            if (value == "") {
                              return "Please Enter Night Capacity";
                            }
                            return null;
                          },
                          controller: farmController.txtNightCapacity),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: addDetails(
                          keyBoard: TextInputType.none,
                          validator: (value) {
                            if (value == "") {
                              return "Please Enter Check In Time";
                            }
                            return null;
                          },
                          hintText: "Check In Time",
                          onTap: () async {
                            farmController.txtCheckInTime.text =
                                await farmController.displayTimePicker(context);

                            setState(() {});
                          },
                          controller: farmController.txtCheckInTime),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: addDetails(
                          hintText: "Check Out Time",
                          validator: (value) {
                            if (value == "") {
                              return "Please Enter Check Out Time";
                            }
                            return null;
                          },
                          keyBoard: TextInputType.none,
                          onTap: () async {
                            farmController.txtCheckOutTime.text =
                                await farmController.displayTimePicker(context);
                            setState(() {});
                          },
                          controller: farmController.txtCheckOutTime),
                    )
                  ],
                ),
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: farmController.isSwimmingPoolAvailable.value,
                        onChanged: (bool? val) {
                          farmController.isSwimmingPoolAvailable.value = val!;
                        },
                      ),
                    ),
                    const Text(
                      "Swimming Pull",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: farmController.isGamingZoneAvailable.value,
                        onChanged: (bool? val) {
                          farmController.isGamingZoneAvailable.value = val!;
                        },
                      ),
                    ),
                    const Text(
                      "Gaming Zone",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: farmController.isPlayGroundAvailable.value,
                        onChanged: (bool? val) {
                          farmController.isPlayGroundAvailable.value = val!;
                        },
                      ),
                    ),
                    const Text(
                      "Play Ground",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                addDetails(
                    hintText: "Discount Price",
                    validator: (value) {
                      if (value == "") {
                        return "Please Enter Discount Price";
                      }
                      return null;
                    },
                    controller: farmController.txtDiscount),
                TextButton(
                    onPressed: () {
                      farmController.showOptions(context);
                    },
                    child: const Center(child: Text("Add Photos"))),
                Obx(() => farmController.isLoaderVisible.value
                    ? const CircularProgressIndicator()
                    : TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (widget.model == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                            } else
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Update Data')),
                              );
                            {}
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                          }
                          String? downloadUrl =
                              await farmController.uploadFile();

                          if (downloadUrl == "" && widget.model == null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Please Upload Image"),
                            ));
                          } else {
                            if (widget.model == null) {
                              farmController.addFarm(downloadUrl);
                            } else {
                              farmController.updateFarm(id: widget.model['id']);
                            }
                          }
                        },
                        child: const Center(child: Text("Add"))))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addDetails({hintText, controller, validator, onTap, keyBoard}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onTap: onTap,
      keyboardType: keyBoard,
      decoration: InputDecoration(
          labelText: hintText,
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black))),
    );
  }
}
