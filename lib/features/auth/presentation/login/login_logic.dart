import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../application/auth_service.dart';
import '../../../core/presentation/homepage/home_ui.dart';
import '../../../../shared/core/presentation/logic/auth_logic.dart';
import '../verify/otp/verify_otp_page.dart';

class LoginLogic extends GetxController {
  final AuthService _authService = AuthService();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool rememberMe = false.obs;
  RxBool isPasswordVisible = false.obs;
  var isLoading = false.obs;
  final authLogic = Get.find<AuthLogic>();

  @override
  void onInit() {
    if (kDebugMode) {
      usernameController.text = 'testsahid3@example.com';
      passwordController.text = 'qwerty';
      // Get.log('running here : ${usernameController.text}');
    }
    super.onInit();
  }

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    try {
      var result = await _authService.login(username, password);
      result.fold((l) {
        Get.snackbar('Error', l);
        if (l == 'Email belum diverifikasi') {
          Get.toNamed(VerifyOtpPage.routeName, parameters: {'email': username});
          return;
        }
      }, (r) async {
        try {
          await _authService.loginPOS(
            username,
            password,
          );
        } catch (e) {
          Get.log('Error during POS login: $e');
        }
        isLoading.value = false;
        await authLogic.fetchUser();
        Get.offAllNamed(HomePage.routeName);
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
