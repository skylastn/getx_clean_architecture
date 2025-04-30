import 'package:get/get.dart';
import '../app/global/controller/global_controller.dart';
// import '../app/global/local_controller.dart';

class DenpendencyInjection {
  static Future<void> init() async {
    try {
      // Get.put(LocalController());
      Get.put(GlobalController(), permanent: true);
    } catch (e) {
      Get.log('error Init Dependency $e');
    }
  }
}
