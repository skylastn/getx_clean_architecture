import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../application/auth_service.dart';
import '../../login/login_page.dart';

class VerifyOtpLogic extends GetxController {
  final AuthService _authService = AuthService();
  var isLoading = false.obs;
  var email = Get.parameters['email'] ?? '';
  final tokenController = TextEditingController();

  Future<bool> verifyEmail({
    required String email,
    required String verificationCode,
  }) async {
    isLoading.value = true;
    try {
      // Lakukan verifikasi email melalui AuthService
      final response = await _authService.verifyEmail(email, verificationCode);

      // Jika respons berhasil (tidak perlu cek token)
      if (response['status'] == true && response.containsKey('data')) {
        Get.until((r) => Get.currentRoute == LoginPage.routeName);
        return true; // Verifikasi berhasil
      } else {
        Get.snackbar(
            'Verifikasi Gagal', response['message'] ?? 'Terjadi kesalahan.');
        return false; // Verifikasi gagal
      }
    } catch (e) {
      // Tangani error lain
      Get.snackbar('Error', 'Terjadi kesalahan saat verifikasi.');
      Get.log('Error during verification: $e');
      return false;
    } finally {
      isLoading.value = false; // Selesai loading
    }
  }
}
