import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gat_cs_trainer_app/utils/Routes/routes.dart';
import 'package:get/get.dart';

@pragma('vm:entry-point')
Future<void> _localNotificationBackgroundHandler(
    NotificationResponse message) async {
  Get.toNamed(
    Routes.getHomePage(),
  );
}

class CustomNotification {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    final androidSetting = AndroidInitializationSettings("mipmap/ic_launcher");
    final iosSetting = DarwinInitializationSettings();
    final initializationSettings =
        InitializationSettings(android: androidSetting, iOS: iosSetting);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _localNotificationBackgroundHandler,
      onDidReceiveBackgroundNotificationResponse:
          _localNotificationBackgroundHandler,
    );
  }

  static Future scheduleNotification(
      {required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      required scheduleTime}) async {
    const androidNotificationDetail = AndroidNotificationDetails(
      "scheduled_notification",
      "Scheduled Notifications",
      actions: [
        AndroidNotificationAction("MARK_DONE", "Mark Done"),
      ],
      channelShowBadge: true,
      enableLights: true,
      importance: Importance.high,
      priority: Priority.high,
      category: AndroidNotificationCategory.reminder,
      playSound: true,
      ongoing: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
      visibility: NotificationVisibility.public,
    );
    const myNotification = NotificationDetails(
      android: androidNotificationDetail,
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      DateTime.now().millisecondsSinceEpoch.remainder(10000),
      "Inactive Usage of Gate CS Train App",
      "Haven't used our GAT(CS) TRAINER for a day? Explore features for an enhanced learning experience!",
      scheduleTime,
      myNotification,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
