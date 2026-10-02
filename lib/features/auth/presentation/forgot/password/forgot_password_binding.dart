import 'package:get/get.dart';

import 'forgot_password_logic.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordLogic>(() => ForgotPasswordLogic());
  }
}
