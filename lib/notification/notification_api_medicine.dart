// initialising notification settings and services for medicine reminder
import 'dart:ffi';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApiMedicine {
  static final _notificationsMedicine = FlutterLocalNotificationsPlugin();
  static final onNotifivationsMedicine = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    const sound = 'notification_sound';
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'Channel id 1',
        'MedicineReminder channel',
        channelDescription: 'Medicine Reminders',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound(sound),
        enableVibration: true,
        enableLights: true,
        fullScreenIntent: true,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initSchedule = false}) async {
    var androidInitilize = const AndroidInitializationSettings('app_logo');
    var iOSinitilize = const IOSInitializationSettings();
    var initilizationsSettings =
        InitializationSettings(android: androidInitilize, iOS: iOSinitilize);

    // When app is closed
    final details =
        await _notificationsMedicine.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotifivationsMedicine.add(details.payload);
    }
    await _notificationsMedicine.initialize(
      initilizationsSettings,
      onSelectNotification: (payload) async {
        onNotifivationsMedicine.add(payload);
      },
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notificationsMedicine.show(id, title, body, await _notificationDetails(),
          payload: payload);

  static Future showScheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async =>
      _notificationsMedicine.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduledDate, tz.local),
          await _notificationDetails(),
          payload: payload,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);

  static cancel(int id) => _notificationsMedicine.cancel(id);
}
