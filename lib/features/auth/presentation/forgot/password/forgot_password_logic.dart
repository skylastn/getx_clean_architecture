import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../application/forgot_password_service.dart';
import 'otp_forgot_password/otp_forgot_password_page.dart';

class ForgotPasswordLogic extends GetxController {
  final ForgotPasswordService forgotPasswordService = ForgotPasswordService();
  var isLoading = false.obs;
  var email = ''.obs;
  var otpSent = false.obs;
  final TextEditingController emailController = TextEditingController();
  StreamSubscription<bool>? otpSentSubscription;

  @override
  void onClose() {
    emailController.dispose();
    otpSentSubscription?.cancel();
    super.onClose();
  }

  void sendOtp(String emailInput) async {
    if (emailController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text)) {
      Get.snackbar('Error', 'Please enter a valid email address');
      return;
    }
    listenOtpSent();
    isLoading.value = true;
    final response = await forgotPasswordService.sendOtp(emailInput);
    if (response != null && response.status) {
      otpSent.value = true;
      email.value = response.email;
    } else {
      Get.snackbar('Error', response?.message ?? 'Failed to send OTP');
    }

    isLoading.value = false;
  }

  void listenOtpSent() {
    otpSentSubscription?.cancel();
    otpSentSubscription = otpSent.listen((sent) {
      if (sent) {
        Get.toNamed(
          OtpForgotPasswordPage.routeName,
          parameters: {'email': email.value},
        );
      } else {
        Get.snackbar('Error', 'Failed to send OTP');
      }
    });
  }
}
