import 'package:flutter/foundation.dart';
import '../app/global/logic/local_logic.dart';
import 'package:get/get.dart';

class Session {
  var storage = Get.find<LocalLogic>().storage;

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
