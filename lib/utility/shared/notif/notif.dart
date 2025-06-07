import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../../core/session.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
String? selectedNotificationPayload;

class Notif {
  Future<void> initNotif() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        kIsWeb || Platform.isLinux || Platform.isWindows
            ? null
            : await flutterLocalNotificationsPlugin
                .getNotificationAppLaunchDetails();

    // String initialRoute = '/';
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationPayload =
          notificationAppLaunchDetails!.notificationResponse?.payload;
      // initialRoute = "/login";
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launcher_icon');

    final DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      // onDidReceiveLocalNotification: (
      //   int id,
      //   String? title,
      //   String? body,
      //   String? payload,
      // ) async {
      //   // didReceiveLocalNotificationSubject.add(
      //   //   ReceivedNotification(
      //   //     id: id,
      //   //     title: title,
      //   //     body: body,
      //   //     payload: payload,
      //   //   ),
      //   // );
      // }
    );
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(
      defaultActionName: 'Open notification',
      defaultIcon: AssetsLinuxIcon('assets/images/logo.png'),
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsIOS,
      linux: initializationSettingsLinux,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      if ((notificationResponse.payload ?? '').isNotEmpty) {
        Get.log('notification payload: $notificationResponse.payload');
        // Get.find<NotificationController>().initPayload(payload);
      }
      // selectedNotificationPayload = payload;
      // selectNotificationSubject.add(payload);
    });
  }

  Future<void> showNotification(RemoteMessage? message) async {
    // RemoteNotification? notification = message?.notification;
    Map<String, dynamic> data = message?.data ?? {};
    String? title = data['title'] ?? '';
    String? body = data['body'] ?? '';

    const AndroidNotificationDetails androidplatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const DarwinNotificationDetails iOSplatformChannelSpecifics =
        DarwinNotificationDetails(
      presentSound: false,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidplatformChannelSpecifics,
      iOS: iOSplatformChannelSpecifics,
    );
    String payload = message?.data['type'] ?? '';

    await flutterLocalNotificationsPlugin.show(
      await Session().getidNotif(),
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
