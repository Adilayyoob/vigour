import 'dart:ffi';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApiWater {
  static final _notificationsWater = FlutterLocalNotificationsPlugin();
  static final onNotifivationsWater= BehaviorSubject<String?>();
  

  static Future _notificationDetails() async {
     const sound = 'notification_sound';
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'Channel id 3',
        'DrinkWater channel',
        channelDescription: 'DrinkWater Reminders',
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound(sound),
        enableVibration: true,
        enableLights: true,
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
    final details = await _notificationsWater.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotifivationsWater.add(details.payload);
    }
    await _notificationsWater.initialize(
      initilizationsSettings,
      onSelectNotification: (payload) async {
        onNotifivationsWater.add(payload);
      },
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notificationsWater.show(id, title, body, await _notificationDetails(),
          payload: payload);

  static Future showScheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async =>
      _notificationsWater.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduledDate, tz.local),
          await _notificationDetails(),
          payload: payload,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
        static cancelAll() => _notificationsWater.cancelAll();

}
