import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../shared/config/app_config.dart';
import '../../application/auth_service.dart';
import '../verify/otp/verify_otp_page.dart';
import '../controller/auth_logic.dart';

class RegisterLogic extends GetxController {
  final AuthService _authService = AuthService();
  final authLogic = Get.find<AuthLogic>();

  // Rxn<CabangResponse> cabang = Rxn();
  // Rxn<SubCabangResponse> subCabang = Rxn();
  // var email = ''.obs;
  var isLoading = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  // TextEditingController branchIdController = TextEditingController();
  TextEditingController subCabangController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    subCabangController.dispose();
    // branchIdController.dispose();
    super.onClose();
  }

  Future<void> register() async {
    if (subCabangController.text.isEmpty) {
      Get.snackbar('Error', 'Isi Dulu Sub Cabang');
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Password and Confirm Password do not match');
      return;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar('Error', 'Please enter a valid email address');
      return;
    }
    isLoading.value = true;
    try {
      Get.log('Attempting registration for email: ${emailController.text}');
      final result = await _authService.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        cPassword: confirmPasswordController.text,
        phone: phoneNumberController.text,
        // subCabangCode: subCabang.value?.code ?? '',
        subCabangCode: subCabangController.text,
        repositoryCode: AppConfig.repoCode,
      );
      result.fold((l) {
        Get.snackbar('Error', l);
        if (l == 'User Created Successfully, please verify your email') {
          Get.toNamed(
            VerifyOtpPage.routeName,
            parameters: {'email': emailController.text},
          );
        }
      }, (r) {
        Get.log('Registration successful, navigating to OTP page');
        // this.email.value = emailController.text;
        Get.toNamed(
          VerifyOtpPage.routeName,
          parameters: {'email': emailController.text},
        );
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
