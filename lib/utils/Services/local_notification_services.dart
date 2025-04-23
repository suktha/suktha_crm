import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

// Top-level function for handling background notification taps
@pragma('vm:entry-point')
void backgroundNotificationTapHandler(NotificationResponse details) {
  print("Background notification tapped with payload: ${details.payload}");
}

class LocalNotificationService {
  static final LocalNotificationService _instance = LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _instance;
  }

  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final AndroidNotificationChannel _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.max,
  );

  Future<void> init() async {
    // Initialize timezone for scheduling notifications
    tz.initializeTimeZones();

    // Initialize local notifications for Android and iOS
    const androidInitSettings = AndroidInitializationSettings('suktha_logo');
    const iosInitSettings = DarwinInitializationSettings();

    final initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    // Initialize the local notifications plugin
    await _localNotificationsPlugin.initialize(initSettings, onDidReceiveNotificationResponse: (details) {
      // Foreground notification tap handling
      print('Foreground notification tapped');
      onSelectNotification(details.payload); // Call handler for foreground
    }, onDidReceiveBackgroundNotificationResponse: backgroundNotificationTapHandler);

    // Create the notification channel for Android
    final platform = _localNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  // Handle when a notification is tapped in the foreground
  Future<void> onSelectNotification(String? payload) async {
    print('Notification tapped in the foreground: $payload');
    if (payload != null) {
      // Handle navigation or other logic when the notification is tapped
    }
  }

  // Stores the hash codes of scheduled notifications
  Set<int> scheduledNotificationIds = {};

  // Cancel a notification by its lead's hashCode ID
  Future<void> cancelLeadNotification(String leadId) async {
    await _localNotificationsPlugin.cancel(leadId.hashCode);
    scheduledNotificationIds.remove(leadId.hashCode); // Remove the hashCode ID from the set
  }

  // Schedule a notification for a specific date and time
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    await _localNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          "0",
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          importance: Importance.max,
          priority: Priority.high,
          icon: 'suktha_logo',
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: "ajith kumar s",
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      // uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      // For daily reminders
    );
  }

  // Show an immediate notification
  Future<void> showNotificationNow({
    required int id,
    required String title,
    required String body,
  }) async {
    await _localNotificationsPlugin.show(
        id,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            importance: Importance.max,
            priority: Priority.high,
            icon: 'suktha_logo',
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: "add a payload");
  }

  // Cancel a notification by its ID
  Future<void> cancelNotification(int id) async {
    await _localNotificationsPlugin.cancel(id);
  }

  // Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _localNotificationsPlugin.cancelAll();
  }
}
