import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'presentation/logic/local_logic.dart';
import '../notif/notif.dart';
import 'app_component.dart';
import 'app_pages.dart';
import 'app_store_application.dart';
import 'dependency_injection.dart';

enum EnvType {
  development,
  production,
}

// Config via --dart-define (defaults = development):
// flutter run --dart-define=APP_ENV=production --dart-define=APP_NAME=SkyKomik ...
class Env {
  static late Env value;

  static const _appEnv = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'development',
  );

  String get appName =>
      const String.fromEnvironment('APP_NAME', defaultValue: 'SkyKomik Dev');

  String get appUsername =>
      const String.fromEnvironment('APP_USERNAME', defaultValue: '');

  String get beUrl => const String.fromEnvironment(
        'BE_URL',
        defaultValue: 'https://be.demo.my.id',
      );

  String get baseUrl => const String.fromEnvironment(
        'BASE_URL',
        defaultValue: 'https://demo.id',
      );

  String get imageUrl => const String.fromEnvironment(
        'IMAGE_URL',
        defaultValue: 'https://demo.id/file/',
      );

  String get logo => 'assets/images/logo.png';

  String get articleUrl => '';

  String get socketUrl => '';

  String get websocket => const String.fromEnvironment(
        'WEBSOCKET_URL',
        defaultValue: 'wss://demo.id/websocket',
      );

  String get callinkChat => '';

  String get tnc => '';

  Color get primarySwatch => Colors.teal;

  EnvType get environmentType => _appEnv == 'production'
      ? EnvType.production
      : EnvType.development;

  // Database Config
  int get dbVersion => 1;

  String get dbName =>
      const String.fromEnvironment('DB_NAME', defaultValue: 'DemoAppsDev');

  Env() {
    value = this;
    _init();
  }

  void _init() async {
    if (GetPlatform.isWeb || Platform.isWindows) {
      initAllPackage();
      return;
    }
    runZonedGuarded<Future<void>>(
      () async {
        initAllPackage();
      },
      (error, stack) {
        if (GetPlatform.isWeb) {
          return;
        }
      },
    );
  }

  Future<void> initAllPackage() async {
    WidgetsFlutterBinding.ensureInitialized();
    Get.put(LocalLogic(), permanent: true);
    await Get.find<LocalLogic>().initLocalDatabase();
    if (!GetPlatform.isWeb) {
      /// Set status bar icon color
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      );
    }

    var application = AppStoreApplication();
    await application.onCreate();
    var initialRoute = AppPages.INITIAL;

    await Notif().initNotif();

    await DenpendencyInjection.init();
    // await initializeDateFormatting('id_ID', null);
    // await CapabilityProfile.ensureProfileLoaded(); //printer

    runApp(AppComponent(application, initialRoute));
  }
}
