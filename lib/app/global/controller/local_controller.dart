import 'dart:io';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalController extends GetxController {
  late SharedPreferences storage;
  late Directory dir;
  String dbFolder = '/IsarDb';

  Future<void> initLocalDatabase() async {
    storage = await SharedPreferences.getInstance();
    Get.log('Isar Open');
  }
}
