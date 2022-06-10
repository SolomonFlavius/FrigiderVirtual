import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('Got a message whilst in the background!');

    if (message.notification != null) {
      print('Message contained a notification!');
      print('Notification title: ${message.notification!.title}');
      print('Notification body: ${message.notification!.body}');
    }

    print('Handling a background message: ${message.messageId}');
  }
}

Future<void> _firebaseMessagingForegroundHandler(
    RemoteMessage message,
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    AndroidNotificationChannel channel) async {
  // If `onMessage` is triggered with a notification, construct our own
  // local notification to show to users using the created channel.
  if (message.notification != null && message.notification!.android != null) {
    flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification!.title,
        message.notification!.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
          ),
        ));
  }
  if (kDebugMode) {
    print('Got a message whilst in the foreground!');

    if (message.notification != null) {
      print('Message contained a notification!');
      print('Notification title: ${message.notification!.title}');
      print('Notification body: ${message.notification!.body}');
    }

    print('Handling a background message: ${message.messageId}');
  }
}

class NotificationManagement {
  static final NotificationManagement _notificationManagement =
      NotificationManagement._internal();
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  factory NotificationManagement() {
    return _notificationManagement;
  }

  NotificationManagement._internal();

  void configure() async {
    // show notification while app is in foreground for iOS
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    // request permission to show notifications
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    // configure the flutter local notification plugin for multiple platforms
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.max,
    );
    const initializationSettingsAndroid = AndroidInitializationSettings(
        '@mipmap/logo'); // <- default icon name is @mipmap/ic_launcher
    const initializationSettingsIOS = IOSInitializationSettings();
    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    if (kDebugMode) {
      // check authorization status
      print('User granted permission: ${settings.authorizationStatus}');
    }

    if (kDebugMode) {
      // test getting the fcm token
      final fcmToken = await FirebaseMessaging.instance.getToken();
      print(fcmToken);
    }

    // configure the handler for notifications in foreground and background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((event) => {
          _firebaseMessagingForegroundHandler(
              event, _flutterLocalNotificationsPlugin, channel),
        });
  }

  Future<String?> getFcmToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
}
