import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void NotificationFunction () async {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  var messagingToken = await _firebaseMessaging.getToken();
  print(messagingToken);

  await _firebaseMessaging.subscribeToTopic("earthquakeNotification");


}