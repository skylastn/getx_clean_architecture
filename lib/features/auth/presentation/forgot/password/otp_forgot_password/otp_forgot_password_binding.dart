import 'package:get/get.dart';

import 'otp_forgot_password_logic.dart';

class OtpForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpForgotPasswordLogic>(
      () => OtpForgotPasswordLogic(),
    );
  }
}
