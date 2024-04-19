
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../res/app_colors/app_colors.dart';

class NotificationService {

  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  // Initialize Platform Specific Notifications (IOS & Android).
  Future<void> initializePlatformNotifications(AndroidNotificationChannel channel) async {

    // Define the channel for android notifications.
    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Define the App icon for notification.
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    // Define the settings for IOS.
    const initializationSettingsIOS = DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true);

    // Finally pass the defined notification settings prams and Define settings for Android and IOS.
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // Finally Initialize Notifications with settings and methods of response.
    await _localNotifications.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: selectNotification,
        onDidReceiveBackgroundNotificationResponse: selectNotification,
    );
    // End of Initialization of Notifications.
  }

  // Setting up the Notification Details for IOS and Android.
  Future<NotificationDetails> _notificationDetails() async {
    // Define the notification details for android.
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel', //Id
      'High Importance Notifications', // Title/Name
      channelDescription: 'This channel is used for important notifications', // Description
      importance: Importance.defaultImportance, //Importance
      priority: Priority.defaultPriority, // Priority
      playSound: true, // Enabled the sound
      ticker: 'ticker', // Ticker
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'), // You can pass any asset Icon image to it.
      color: AppColors.lightModeAppBarColor, // Color
    );

    // Define the IOS Notification Details.
    const iosNotificationDetails = DarwinNotificationDetails(
        threadIdentifier: "Add Expense",
        attachments: <DarwinNotificationAttachment>[
          DarwinNotificationAttachment('AppIcon/Icon-App'), // this Icon is for demo I'm not sure it works or not but you should pass your own asset Icon Image.
        ]);
    // Initialize the notification Details for both IOS and Android.
    NotificationDetails platformChannelSpecifics = const NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);

    // Finally Return details of notification.
    return platformChannelSpecifics;
  }

  // The method to show periodic Notification on each day and you can set its time
  // which is callback your interval.
  Future<void> showPeriodicNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    // Call the method of Notification Details and pass the details to notification.
    final platformChannelSpecifics = await _notificationDetails();
    await _localNotifications.periodicallyShow(
      id,
      title,
      body,
      RepeatInterval.daily, // Here you can change the RepeatInterval to any incoming options.
      platformChannelSpecifics,
      payload: payload,
    );
  }

  // When user tap or click on Notification these methods will be called and you can
  // perform any background tasks here to handle the app in better way.
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