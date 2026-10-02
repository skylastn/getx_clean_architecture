import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../application/forgot_password_service.dart';

class NewPasswordLogic extends GetxController {
  final forgotPasswordService = ForgotPasswordService();
  RxBool isVerified =
      Get.parameters['isVerified'] == 'true' ? true.obs : false.obs;
  String email = Get.parameters['email'] ?? '';
  RxBool isLoading = false.obs;
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> changePassword(String password) async {
    isLoading.value = true;

    final response = await forgotPasswordService.changePassword(
      email,
      password,
    );

    if (response != null && response.status) {
      Get.snackbar('Success', response.message);
    } else {
      Get.snackbar('Error', response?.message ?? 'Failed to change password');
    }

    isLoading.value = false;
  }
}
