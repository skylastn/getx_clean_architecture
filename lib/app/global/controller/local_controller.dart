import 'dart:io';
import 'package:isar/isar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

import '../../../features/core/infrastructure/model/recent_chapter_komik_model.dart';

class LocalController extends GetxController {
  late SharedPreferences storage;
  late Directory dir;
  late Isar db;
  String dbFolder = '/IsarDb';

  Future<void> initLocalDatabase() async {
    storage = await SharedPreferences.getInstance();
    // dir = await getApplicationDocumentsDirectory();
    // db = await Isar.open(
    //   [
    //     RecentChapterKomikModelSchema,
    //   ],
    //   directory: dir.path,
    // );
    Get.log('Isar Open');
  }
}
