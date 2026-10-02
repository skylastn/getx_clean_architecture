import 'package:get/get.dart';

import 'verify_otp_logic.dart';

class VerifyOtpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyOtpLogic>(() => VerifyOtpLogic());
  }
}
