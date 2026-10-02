import 'dart:convert';

import 'package:get/get.dart';

class UserModel {
  final RxString token;
  final RxString email;
  final RxString name;
  final RxString noWa;
  final RxString kode;
  final RxInt cabangId;
  final RxString userLevel;
  final RxBool isVerified;
  final RxString profilePicture;

  UserModel({
    required String token,
    required String email,
    required String name,
    required String noWa,
    required String kode,
    required int cabangId,
    required String userLevel,
    required bool isVerified,
    required String profilePicture,
  })  : token = token.obs,
        email = email.obs,
        name = name.obs,
        noWa = noWa.obs,
        kode = kode.obs,
        cabangId = cabangId.obs,
        userLevel = userLevel.obs,
        isVerified = isVerified.obs,
        profilePicture = profilePicture.obs;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    Get.log('Creating UserModel from json: ${jsonEncode(json)}');
    return UserModel(
      token: json['token'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      noWa: json['no_wa'] ?? '',
      kode: json['kode'] ?? '',
      cabangId: json['cabang_id'] ?? 0,
      userLevel: json['user_lvl'] ?? '',
      isVerified: json['isVerified'] == 1,
      profilePicture: json['profile_picture'] ?? '',
    );
  }
}
