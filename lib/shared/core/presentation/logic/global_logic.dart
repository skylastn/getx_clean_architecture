import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'local_logic.dart';
// import 'package:package_info_plus/package_info_plus.dart';
import 'package:get/get.dart';
import '../../../notif/notif.dart';

class GlobalLogic extends GetxController {
  RxBool isUserLogin = false.obs;
  LocalLogic localCtrl = Get.find<LocalLogic>();
  RxString versiApk = ''.obs,
      versiServer = ''.obs,
      nobuild = ''.obs,
      urlApk = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initFirstTime();
  }

  Future<void> initFirstTime() async {
    if (GetPlatform.isMacOS || GetPlatform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
    await initData();
  }

  Future<void> initData() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.log(Get.currentRoute);
  }
}
