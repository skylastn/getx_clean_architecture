import 'dart:io';
import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:sample_app/core/dependency_injection.dart';
import 'package:sample_app/firebase_options.dart';
import 'package:get/get.dart';
import '../utility/shared/notif/notif.dart';

// import 'notification_services.dart';

class FirebaseTraits {
  Future<void> init() async {
    /// Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
      return;
    }
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Pass all uncaught errors from the framework to Crashlytics.
    if (GetPlatform.isAndroid || GetPlatform.isIOS) {
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

      /// Catch errors that happen outside of the Flutter context,
      Isolate.current.addErrorListener(
        RawReceivePort((List<dynamic> pair) async {
          final List<dynamic> errorAndStacktrace = pair;
          await FirebaseCrashlytics.instance.recordError(
            errorAndStacktrace.first,
            errorAndStacktrace.last as StackTrace,
          );
        }).sendPort,
      );
    }

    // FirebaseMessaging.instance.subscribeToTopic("${currentUser.value?.id}");
    // FirebaseMessaging.instance.subscribeToTopic("all");

    await FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (kDebugMode) {
        print('Firebase Connect');
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Get.log('On Message');
      if (kDebugMode) {
        print(message.toMap());
      }
      Notif().showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      Get.log('On Message Open');
      if (kDebugMode) {
        print(message.toMap());
      }
      Notif().showNotification(message);
    });
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await DenpendencyInjection.init();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // Get.lazyPut(() => GlobalVariables());
  // await setupLocalNotifications();
  if (kDebugMode) {
    print('Handling a background message ${message.toMap()}');
  }

  Notif().showNotification(message);
}
