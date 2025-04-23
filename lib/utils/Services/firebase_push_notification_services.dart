// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// @pragma('vm:entry-point')
// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   print('-----hello------: ${message.notification?.title} - ${message.notification?.body}');
//   print("--message-$message");

//   // try {
//   //   String? transTypeId = message.data['transTypeId'];
//   //   String? transNum = message.data['transNumber'];

//   //   log("Transaction Type ID: $transTypeId");
//   //   log("Transaction Number: $transNum");

//   //   if (transTypeId != null && transNum != null) {
//   //     print("hello civics");
//   //     checkTransType(int.parse(transTypeId), transNum);
//   //   }
//   // } catch (e) {
//   //   print(e);
//   // }
// }

// class FirebasePushNotificationServices {
//   static final FirebasePushNotificationServices _instance = FirebasePushNotificationServices._internal();

//   factory FirebasePushNotificationServices() {
//     return _instance;
//   }

//   FirebasePushNotificationServices._internal();

//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

//   final AndroidNotificationChannel _androidChannel = const AndroidNotificationChannel(
//     'high_important_channel',
//     'High Importance Notifications',
//     description: 'This channel is used for important notifications',
//     importance: Importance.max,
//   );

//   final DarwinNotificationDetails _iosChannel = const DarwinNotificationDetails();

//   Future<void> initNotification() async {
//     await _firebaseMessaging.requestPermission();

//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     String? FCMToken;

//     if (Platform.isIOS) {
//       FCMToken = await messaging.getAPNSToken();
//     } else {
//       FCMToken = await messaging.getToken();
//     }

//     log('FCM Token: $FCMToken');

//     String fcmToken = FCMToken ?? "";

//     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

//     sharedPreferences.setString('fcmToken', fcmToken);

//     await _initLocalNotifications();
//     _initPushNotifications();
//   }

//   /// 🔹 Initialize Push Notifications (FCM)
//   void _initPushNotifications() {
//     FirebaseMessaging.onMessage.listen((message) {
//       print('Got a message whilst in the foreground!');
//       log('📩 Full Message: ${jsonEncode(message.toMap())}');

//       if (message.notification != null) {
//         print('Message also contained a notification: ${message.toString()}');
//       }

//       _handleForegroundNotification(message);
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       print("hello onmesssageopened");
//       _handleNotificationTap(message);
//     });

//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       if (message != null) {
//         _handleNotificationTap(message);
//       }
//     });
//   }

//   /// 🔹 Initialize Local Notifications
//   Future<void> _initLocalNotifications() async {
//     const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@drawable/ic_notification');

//     final DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );

//     final InitializationSettings settings = InitializationSettings(android: androidSettings, iOS: iosSettings);

//     await _localNotifications.initialize(settings, onDidReceiveNotificationResponse: (response) {
//       print(response);
//       print("ontapped");
//       if (response.payload != null) {
//         print("ontapped");
//         _handleNotificationPayload(jsonDecode(response.payload!));
//       }
//     });

//     final androidImplementation = _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
//     await androidImplementation?.createNotificationChannel(_androidChannel);
//   }

//   /// 🔹 Handle Foreground Notifications
//   void _handleForegroundNotification(RemoteMessage message) {
//     final RemoteNotification? notification = message.notification;
//     final Map<String, dynamic> data = message.data;
//     print("hii");

//     if (notification != null) {
//       String? imageUrl;
//       if (data.containsKey('image')) {
//         imageUrl = data['image'];
//         print(imageUrl);
//       }

//       _showLocalNotification(notification.title ?? "No Title", notification.body ?? "No Body", data, imageUrl);
//     }
//   }

//   void _handleNotificationTap(RemoteMessage message) {
//     log("🔔 Notification Clicked: ${message.data}");
//     _handleNotificationPayload(message.data);
//   }

//   /// 🔹 Show Local Notification (With Optional Image)
//   Future<void> _showLocalNotification(String title, String body, Map<String, dynamic> data, String? imageUrl) async {
//     BigPictureStyleInformation? bigPictureStyle;

//     if (imageUrl != null && imageUrl.isNotEmpty) {
//       bigPictureStyle = BigPictureStyleInformation(
//         FilePathAndroidBitmap(imageUrl), // Use network image or local path
//         contentTitle: title,
//         summaryText: body,
//       );
//     }

//     final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       _androidChannel.id,
//       _androidChannel.name,
//       channelDescription: _androidChannel.description,
//       importance: Importance.max,
//       priority: Priority.high,
//       icon: '@drawable/ic_notification',
//       styleInformation: bigPictureStyle,
//     );

//     final NotificationDetails notificationDetails = NotificationDetails(
//       android: androidDetails,
//       iOS: _iosChannel,
//     );

//     await _localNotifications.show(
//       title.hashCode,
//       title,
//       body,
//       notificationDetails,
//       payload: jsonEncode(data),
//     );
//   }

//   void _handleNotificationPayload(Map<String, dynamic> data) {
//     print("🔔 Notification Payload: $data");
//     print("typeid ${data['transTypeId']}");

//     try {
//       String? transTypeId = data['transTypeId'];
//       String? transNum = data['transNumber'];

//       log("Transaction Type ID: $transTypeId");
//       log("Transaction Number: $transNum");

//       if (transTypeId != null && transNum != null) {
//         print("hello civics");
//         checkTransType(int.parse(transTypeId), transNum);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }
