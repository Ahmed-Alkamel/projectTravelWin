import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchTripController extends GetxController
    with GetSingleTickerProviderStateMixin {
// final TabController controlTab=TabController(initialIndex: 0,length: 2, vsync: null, );
  List<Tab> tabTrip = const [
    Tab(
      text: 'ذهاب فقط',
    ),
    Tab(
      text: 'ذهاب و اياب',
    ),
  ];
  late TabController controllerbar;

  @override
  void onInit() {
    controllerbar = TabController(length: tabTrip.length, vsync: this);
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
