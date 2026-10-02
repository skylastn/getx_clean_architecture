import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'local_logic.dart';
// import 'package:package_info_plus/package_info_plus.dart';
import 'package:get/get.dart';
import '../../../shared/notif/notif.dart';

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
    // await getMyProfile();
    // await versionCheck();
    await Future.delayed(const Duration(seconds: 1));
    Get.log(Get.currentRoute);
    // if (['/auth-splash-screen', '/auth-login'].contains(Get.currentRoute)) {
    //   routeAfterLogin();
    // }
  }

  // getMyProfile() async {
  //   var response = await UserService().getMyProfile();
  //   response.fold(
  //     (l) => currentUser.value = null,
  //     (r) => currentUser.value = r,
  //   );
  // }

  // versionCheck() async {
  //   try {

  //     PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //     String appName = packageInfo.appName;
  //     String packageName = packageInfo.packageName;
  //     String version = packageInfo.version;
  //     String buildNumber = packageInfo.buildNumber;
  //     if (kDebugMode) {
  //       Get.log(
  //         'name app : $appName\npackage name : $packageName\nversion : $version\n build number : $buildNumber',
  //       );
  //     }
  //     nobuild.value = buildNumber;
  //     versiApk.value = version;
  //   } catch (e) {
  //     Toast.showInfoSnackbar(
  //       message: 'Mohon Maaf, Server sedang bermasalah \n\n$e',
  //       title: 'Info',
  //     );
  //   }
  // }

  // Future<void> routeAfterLogin() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   if (currentUser.value == null) {
  //     Get.offAllNamed(Routes.AUTH_LOGIN);
  //   } else {
  //     Get.offAllNamed(Routes.DASHBOARD);
  //   }
  // }

  // void logout() {
  //   Session().saveToken('');
  //   Get.offAllNamed(Routes.AUTH_LOGIN);
  // }
}
