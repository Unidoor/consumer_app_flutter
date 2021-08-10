import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabController extends GetxController with SingleGetTickerProviderMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'PURCHASE'),
    Tab(text: 'SALES'),
  ];

  RxInt tabIndex = 0.obs;

  TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: myTabs.length);
  }

  void getTabIndex(index) {
    tabIndex.value = index;
    // return tabIndex.value;
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
