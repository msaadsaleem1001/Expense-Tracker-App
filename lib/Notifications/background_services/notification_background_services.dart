
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:personal_expense_tracker_app/Notifications/notification_services.dart';

class AppBackgroundServices {

  // this will be used as notification channel id
  static const notificationChannelId = 'my_foreground';
  // this will be used for notification id, So you can update your custom notification with this id.
  static const notificationId = 888;

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId, // id
    'Reminder of Expense', // title
    description:
    'This Notification is used to remind you to add daily expenses.', // description
    importance: Importance.high, // importance must be at low or higher level
  );

  static NotificationService notificationService = NotificationService();

  static Future<void> initializeBackgroundServices (FlutterBackgroundService service) async {

    notificationService.initializePlatformNotifications(channel);

    await service.configure(
        androidConfiguration: AndroidConfiguration(
          // this will be executed when app is in foreground or background in separated isolate
          onStart: onStart,
          // auto start service
          autoStart: true,
          isForegroundMode: true,
          notificationChannelId: notificationChannelId,
          // this must match with notification channel you created above.
          initialNotificationTitle: 'Add Expense',
          initialNotificationContent: 'Add the all expenses of today.',
          foregroundServiceNotificationId: notificationId,
        ),
        iosConfiguration: IosConfiguration(
            autoStart: true,
            onBackground: onBackground,
            onForeground: onStart
        )
    );
  }

  static Future<void> onStart(ServiceInstance service) async {
      // Only available for flutter 3.0.0 and later
      // DartPluginRegistrant.ensureInitialized();

      try{
        notificationService.showPeriodicNotification(
          id: notificationId,
          title: 'Add Expense',
          body: 'Add the all expenses of today',
          payload: 'add',
        );
      }
      catch(e) {
        debugPrint('Error of Notifications: ${e.toString()}');
      }
    }

  static Future<bool> onBackground(ServiceInstance service) async {
    // Only available for flutter 3.0.0 and later
    // DartPluginRegistrant.ensureInitialized();
    try{
      notificationService.showPeriodicNotification(
        id: notificationId,
        title: 'Add Expense',
        body: 'Add the all expenses of today',
        payload: 'add',
      );
    }
    catch(e) {
      debugPrint('Error of Notifications: ${e.toString()}');
    }
    return true;
  }

}