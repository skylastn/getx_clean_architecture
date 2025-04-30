import 'package:get/get.dart';
import '../utility/log/log.dart';
import 'application.dart';
import 'env.dart';
import 'package:logging/logging.dart';

class AppStoreApplication implements Application {
  @override
  Future<void> onCreate() async {
    _initLog();
  }

  void _initLog() {
    Log.init();

    switch (Env.value.environmentType) {
      case EnvType.development:
        break;
      case EnvType.production:
        Log.setLevel(Level.INFO);
        break;
    }
  }

  @override
  Future<void> onTerminate() async {
    Get.log('''
=============================================================
               APP KILLED
=============================================================
''');
  }
}
