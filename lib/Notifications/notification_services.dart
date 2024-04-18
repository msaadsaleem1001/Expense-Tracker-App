
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../res/app_colors/app_colors.dart';

class NotificationService {

  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  // Initialize Platform Notifications.
  Future<void> initializePlatformNotifications(AndroidNotificationChannel channel) async {

    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    tz.initializeTimeZones();
    tz.setLocalLocation(
      tz.getLocation(
        await FlutterTimezone.getLocalTimezone(),
      ),
    );

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettingsIOS = DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true);

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: selectNotification,
        onDidReceiveBackgroundNotificationResponse: selectNotification,
    );
  }
  // Setting up the Notification Details for IOS and Android.
  Future<NotificationDetails> _notificationDetails() async {

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      ticker: 'ticker',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      color: AppColors.lightModeAppBarColor,
    );

    const iosNotificationDetails = DarwinNotificationDetails(
        threadIdentifier: "Add Expense",
        attachments: <DarwinNotificationAttachment>[
          DarwinNotificationAttachment('AppIcon/Icon-App'),
        ]);

    NotificationDetails platformChannelSpecifics = const NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);

    return platformChannelSpecifics;
  }

  Future<void> showPeriodicNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    final platformChannelSpecifics = await _notificationDetails();
    await _localNotifications.periodicallyShow(
      id,
      title,
      body,
      RepeatInterval.daily,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  static void selectNotification(NotificationResponse response) {
    debugPrint('Select Notification');
    if(response.payload == 'add'){
      debugPrint('PayLoad Matched ${response.payload.toString()}');
    }
    else{
      debugPrint('PayLoad Not Match');
    }
  }
}