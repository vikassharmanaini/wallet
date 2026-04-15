import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Local notification bootstrap and helpers.
class NotificationService {
  /// Creates service with a lazily-created plugin instance.
  NotificationService() : _plugin = FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;

  /// Initializes notification channels on supported platforms.
  Future<void> init() async {
    const AndroidInitializationSettings android =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings ios = DarwinInitializationSettings();
    const InitializationSettings settings = InitializationSettings(
      android: android,
      iOS: ios,
    );
    await _plugin.initialize(settings);
  }

  /// Shows a simple informational notification (used for tx events later).
  Future<void> showInfo({
    required int id,
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'sw3w_default',
      'SuperWeb3Wallet',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const NotificationDetails details = NotificationDetails(android: android);
    await _plugin.show(id, title, body, details);
  }
}
