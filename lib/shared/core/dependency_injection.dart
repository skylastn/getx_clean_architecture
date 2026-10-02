import 'package:get/get.dart';
import 'presentation/logic/global_logic.dart';
// import '../app/global/local_logic.dart';

class DenpendencyInjection {
  static Future<void> init() async {
    try {
      // Get.put(LocalLogic());
      Get.put(GlobalLogic(), permanent: true);
    } catch (e) {
      Get.log('error Init Dependency $e');
    }
  }
}
