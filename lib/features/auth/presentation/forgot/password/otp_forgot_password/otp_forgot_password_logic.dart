import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../application/forgot_password_service.dart';

class OtpForgotPasswordLogic extends GetxController {
  final ForgotPasswordService forgotPasswordService = ForgotPasswordService();
  final TextEditingController otpController = TextEditingController();
  var isLoading = false.obs;
  var isVerified = false.obs;
  var email = Get.parameters['email'] ?? '';

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }

  Future<bool> verifyOtp(String emailInput, String verificationCode) async {
    isLoading.value = true;

    final response = await forgotPasswordService.verifyOtp(
      emailInput,
      verificationCode,
    );

    if (response != null && response.status) {
      isVerified.value = true;
    } else {
      isVerified.value = false;
      Get.snackbar('Error', response?.message ?? 'Failed to verify OTP');
    }

    isLoading.value = false;
    return isVerified.value;
  }
}
