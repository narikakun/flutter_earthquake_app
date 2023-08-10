import 'dart:convert';

import 'package:earthquake_app/src/screens/detail.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'firebase_options.dart';
import 'dart:async';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.hashCode);
  if (message.notification != null) return;
  final flutterLocalNotificationsPluginO = FlutterLocalNotificationsPlugin();
  Map<String, dynamic> notificationData = message.data;
  const settings = InitializationSettings(
    android: AndroidInitializationSettings('@drawable/ic_stat_logo'),
  );
  await flutterLocalNotificationsPluginO.initialize(settings,
      onDidReceiveNotificationResponse: (NotificationResponse res) {
        if (res.payload == null) return;
        Map<String, dynamic> payloadJson = jsonDecode(res.payload as String);
        print(payloadJson);
      });
  var details = NotificationDetails(
    android: AndroidNotificationDetails(
      "default_notification_channel_quakeinfo",
      "地震情報",
      channelDescription: "地震情報を通知します",
      importance: Importance.max,
      priority: Priority.max,
      timeoutAfter: 5000,
      largeIcon: notificationData["maxInt"]!=null?DrawableResourceAndroidBitmap("@drawable/int_s${notificationData["maxInt"]}"):const DrawableResourceAndroidBitmap("@drawable/ic_stat_logo"),
      styleInformation: const MediaStyleInformation(),
      playSound: true,
    ),
  );
  await flutterLocalNotificationsPluginO.show(message.hashCode, notificationData["title"], notificationData["body"], details, payload: jsonEncode(notificationData));
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true
  );
  await FirebaseMessaging.instance.subscribeToTopic("quakeInfo");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}