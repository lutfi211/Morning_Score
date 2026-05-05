import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidSettings);
    await _plugin.initialize(settings);
    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> showMorningNotification(List<String> lines) async {
    if (lines.isEmpty) return;

    final body = lines.take(8).join('\n');
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'morning_skor_daily',
        'Morning Skor Daily',
        channelDescription: 'Daily football score digest',
        importance: Importance.high,
        priority: Priority.high,
        styleInformation: BigTextStyleInformation(body),
      ),
    );

    await _plugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      '⚽ Morning Skor',
      body,
      details,
    );
  }
}
