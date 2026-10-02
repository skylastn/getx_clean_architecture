import 'package:get/get.dart';

import '../../../../shared/core/presentation/logic/shared_preferences_logic.dart';
import '../../../core/presentation/homepage/home_ui.dart';
import '../controller/auth_logic.dart';
import '../login/login_page.dart';

class SplashLogic extends GetxController {
  final localDb = Get.find<SharedPreferencesLogic>();
  final authLogic = Get.find<AuthLogic>();

  @override
  void onReady() {
    init();
    super.onReady();
  }

  Future<void> init() async {
    bool result = await isLoggedIn();
    if (!result) {
      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed(LoginPage.routeName);
      return;
    }
    await authLogic.fetchUser();
    Get.offAllNamed(HomePage.routeName);
  }

  Future<bool> isLoggedIn() async {
    Get.log('Running here');
    final token = await localDb.getToken;
    Get.log('is LogingedIn: $token');
    return token != null && token.isNotEmpty;
  }
}
