import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:lugu_pet/app/global/controller/local_controller.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;
import 'env.dart';

class Session {
  var storage = Get.find<LocalController>().storage;

  Future<void> saveAuth(bool value) async {
    await storage.setBool('isAuth', value);
  }

  bool getAuth() {
    return storage.getBool('isAuth') ?? false;
  }

  void saveIntroduction(bool isIntroduction) async {
    await storage.setBool('isIntroduction', isIntroduction);
  }

  bool getIntroduction() {
    return storage.getBool('isIntroduction') ?? false;
  }

  Future<void> saveToken(String value) async {
    await storage.setString('token', value);
  }

  String getToken() {
    return storage.getString('token') ?? '';
  }

  // Future<void> saveUser(UserModel user) async {
  //   await storage.setString('user', jsonEncode(user.toJson()));
  // }

  // UserModel? getUser() {
  //   var temp = storage.getString('user');
  //   if (temp == null) {
  //     return null;
  //   }
  //   return UserModel.fromJson(jsonDecode(temp));
  // }

  Future<void> saveFcmToken(String loginType) async {
    await storage.setString('fcmToken', loginType);
  }

  Future<String> initFcmToken() async {
    try {
      if (!kIsWeb &&
          (Platform.isWindows || Platform.isFuchsia || Platform.isLinux)) {
        return '';
      }
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission();
      Get.log(settings.authorizationStatus.name);

      String temp = storage.getString('fcmToken') ?? '';
      if (temp.isEmpty) {
        Get.log(Env.value.vapidKey);
        temp = await FirebaseMessaging.instance.getToken(
              vapidKey: (kIsWeb) ? Env.value.vapidKey : null,
            ) ??
            '';
        saveFcmToken(temp);
      }
      Get.log('Token Fcm : $temp');
      return temp;
    } catch (e) {
      Get.log('error init Fcm Token : $e');
      if (kIsWeb && kDebugMode) {
        await Future.delayed(const Duration(seconds: 1));
        html.window.location.reload();
      }
      return '';
    }
  }

  Future<void> saveidNotif(int value) async {
    await storage.setInt('idNotif', value);
    if (kDebugMode) {
      print('ID Notif : $value');
    }
  }

  Future<int> getidNotif() async {
    if (storage.getInt('idNotif') == null) {
      await saveidNotif(0);
    }
    int idNotif = storage.getInt('idNotif') ?? 0;
    saveidNotif(idNotif + 1);
    return idNotif;
  }
}
