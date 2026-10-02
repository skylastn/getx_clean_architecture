import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../features/auth/domain/model/response/user/user_response.dart';
import '../../../../features/auth/domain/model/response/cabang/sub_cabang_user_response.dart';

class SharedPreferencesLogic extends GetxController {
  static const String _tokenKey = 'token';
  static const String _userIdKey = 'user_id';
  static const String _usernameKey = 'username';
  static const String _emailKey = 'email';
  static const String _passwordKey = 'password';
  static const String _userKey = 'user';
  static const String _subCabangUserKey = 'sub_cabang_user';
  late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveToken(String token) async {
    try {
      await prefs.setString(_tokenKey, token);
      Get.log('Token saved: $token');
    } catch (e) {
      Get.log('Error saving token: $e');
    }
  }

  String? get getToken {
    try {
      String? token = prefs.getString(_tokenKey);
      Get.log('Token fetched from SharedPreferences: $token');
      return token;
    } catch (e) {
      Get.log('Error getting token: $e');
      return null;
    }
  }

  Future<void> removeToken() async {
    try {
      await prefs.remove(_tokenKey);
    } catch (e) {
      Get.log('Error removing token: $e');
    }
  }

  Future<void> saveTokenPOS(String token) async {
    try {
      await prefs.setString('${_tokenKey}_POS', token);
    } catch (e) {
      Get.log('Error saving token POS: $e');
    }
  }

  String? get getTokenPOS {
    try {
      String? token = prefs.getString('${_tokenKey}_POS');
      Get.log('Token POS fetched from SharedPreferences: $token');
      return token;
    } catch (e) {
      Get.log('Error getting token POS: $e');
      return null;
    }
  }

  Future<void> removeTokenPOS() async {
    try {
      await prefs.remove('${_tokenKey}_POS');
    } catch (e) {
      Get.log('Error removing token: $e');
    }
  }

  Future<void> saveUserId(int userId) async {
    await prefs.setInt(_userIdKey, userId);
  }

  Future<int?> getUserId() async {
    int? userId = prefs.getInt(_userIdKey);
    Get.log('User ID fetched from SharedPreferences: $userId');
    return userId;
  }

  Future<void> saveUsername(String username) async {
    try {
      await prefs.setString(_usernameKey, username);
    } catch (e) {
      Get.log('Error saving username: $e');
    }
  }

  Future<String?> getUsername() async {
    try {
      return prefs.getString('username') ?? '';
    } catch (e) {
      Get.log('Error getting username: $e');
      return null;
    }
  }

  Future<void> saveEmail(String email) async {
    try {
      await prefs.setString(_emailKey, email);
    } catch (e) {
      Get.log('Error saving email: $e');
    }
  }

  Future<String?> getEmail() async {
    try {
      return prefs.getString(_emailKey); // Menggunakan kunci email yang benar
    } catch (e) {
      Get.log('Error getting email: $e');
      return null;
    }
  }

  Future<void> savePassword(String password) async {
    try {
      await prefs.setString(_passwordKey, password);
    } catch (e) {
      Get.log('Error saving password: $e');
    }
  }

  String? get password {
    try {
      return prefs.getString(_passwordKey);
    } catch (e) {
      Get.log('Error getting password: $e');
      return null;
    }
  }

  Future<void> saveUser(UserResponse user) async {
    try {
      await prefs.setString(_userKey, jsonEncode(user.toMap()));
    } catch (e) {
      Get.log('Error saving password: $e');
    }
  }

  UserResponse? get user {
    try {
      var storage = prefs.getString(_userKey);
      return UserResponse.fromMap(jsonDecode(storage ?? ''));
    } catch (e) {
      Get.log('Error getting password: $e');
      return null;
    }
  }

  Future<void> clearAll() async {
    try {
      await prefs.clear();
    } catch (e) {
      Get.log('Error clearing SharedPreferences: $e');
    }
  }

  Future<void> saveField(String key, String value) async {
    await prefs.setString(key, value);
  }

  Future<String?> getNoWa() async {
    return prefs.getString('noWa');
  }

  Future<String?> getAvatarUrl() async {
    return prefs.getString('avatarUrl');
  }

  Future<void> clearSession() async {
    try {
      await prefs.remove(_tokenKey);
      await prefs.remove(_userIdKey);
      Get.log('User session cleared from SharedPreferences');
    } catch (e) {
      Get.log('Errorr clearing session: $e');
    }
  }

  Future<void> saveSubCabangUser(SubCabangUserResponse? subCabangUser) async {
    await prefs.setString(
        _subCabangUserKey, jsonEncode(subCabangUser?.toMap()));
  }

  SubCabangUserResponse? get subCabangUser {
    var storage = prefs.getString(_subCabangUserKey);
    if (storage == null) return null;
    return SubCabangUserResponse.fromMap(jsonDecode(storage));
  }
}
