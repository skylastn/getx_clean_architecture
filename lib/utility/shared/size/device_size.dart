import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceSize {
  static double getMobileSize() {
    var deviceWidth = MediaQuery.of(Get.context!).size.shortestSide;
    if (deviceWidth > 599) {
      return 600;
    }
    return deviceWidth;
  }
}
