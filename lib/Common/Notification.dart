// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

class NotificationCommon {
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> startClass() async {
    await setup();
  }

  Future<void> setup() async {
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInitializationSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: androidSetting, iOS: iosInitializationSettings);

    await _localNotificationsPlugin.initialize(initSettings);
  }

  Future<void> creteNotification(String title, String body, endTime, String channel) async {
    tzData.initializeTimeZones();
    final scheduleTime = tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, endTime);

    final androidDetail = AndroidNotificationDetails(channel, channel);

    final iosDetail = DarwinNotificationDetails();

    final noticeDetail = NotificationDetails(
      iOS: iosDetail,
      android: androidDetail,
    );

    // final id = 0;

    await _localNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      scheduleTime,
      noticeDetail,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }
}
