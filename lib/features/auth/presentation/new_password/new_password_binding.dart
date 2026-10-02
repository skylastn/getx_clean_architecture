import 'package:get/get.dart';

import 'new_password_logic.dart';

class NewPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewPasswordLogic>(() => NewPasswordLogic());
  }
}
