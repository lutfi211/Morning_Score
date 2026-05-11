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

  Future<void> showMorningNotifications(Map<String, List<String>> matchesByLeague) async {
    var offset = 0;
    for (final entry in matchesByLeague.entries) {
      await showMorningNotification(entry.key, entry.value, idOffset: offset);
      offset++;
    }
  }

  Future<void> showMorningNotification(
    String league,
    List<String> lines, {
    int idOffset = 0,
  }) async {
    if (lines.isEmpty) return;

    final body = lines.take(5).join('\n');
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'morning_skor_daily',
        'Morning Skor Daily',
        channelDescription: 'Daily football score digest by league',
        importance: Importance.high,
        priority: Priority.high,
        styleInformation: BigTextStyleInformation(body),
      ),
    );

    await _plugin.show(
      (DateTime.now().millisecondsSinceEpoch ~/ 1000) + idOffset,
      'Morning Skor - $league',
      body,
      details,
    );
  }
}
