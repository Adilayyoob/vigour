// initialising notification settings and services for doctor visit reminder
import 'dart:ffi';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifivations = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    const sound = 'notification_sound';
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'Channel id 2',
        'DoctorVisit channel',
        channelDescription: 'DoctorVisit Reminders',
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
    final details = await _notifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotifivations.add(details.payload);
    }
    await _notifications.initialize(
      initilizationsSettings,
      onSelectNotification: (payload) async {
        onNotifivations.add(payload);
      },
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(id, title, body, await _notificationDetails(),
          payload: payload);

  static Future showScheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async =>
      _notifications.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduledDate, tz.local),
          await _notificationDetails(),
          payload: payload,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);

  static cancel(int id) => _notifications.cancel(id);
}
