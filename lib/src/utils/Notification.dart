import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  final flutterLocalNotificationsPluginO = FlutterLocalNotificationsPlugin();
  RemoteNotification? notification = message.notification;
  print(message.hashCode);
  const settings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  );
  await flutterLocalNotificationsPluginO.initialize(settings);
  const details = NotificationDetails(
    android: AndroidNotificationDetails(
      "default_notification_channel_quakeinfo",
      "地震情報",
      channelDescription: "地震情報を通知します",
      importance: Importance.max,
      priority: Priority.high,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
      playSound: true,
    ),
  );
  await flutterLocalNotificationsPluginO.show(message.hashCode, notification?.title, notification?.body, details);
  print("Handling a background message: ${message.messageId}");
}