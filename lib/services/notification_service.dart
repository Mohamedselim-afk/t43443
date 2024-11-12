// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:t43443/services/location_service.dart';
//
// class NotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   final LocationService locationService;
//
//   NotificationService(this.locationService);
//
//   Future<void> initialize() async {
//     await _firebaseMessaging.requestPermission();
//     String? token = await _firebaseMessaging.getToken();
//     print("Token: $token");
//
//
//     // Initialize local notifications
//     const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const InitializationSettings initSettings = InitializationSettings(android: androidSettings);
//
//     await _localNotificationsPlugin.initialize(
//       initSettings,
//       onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
//     );
//
//     // Listen for incoming foreground messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       _showNotificationWithAction(message);
//     });
//   }
//
//   Future<void> _showNotificationWithAction(RemoteMessage message) async {
//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'channel_id', 'channel_name', channelDescription: 'channel_description',
//       importance: Importance.max,
//       priority: Priority.high,
//       actions: [AndroidNotificationAction('send_location', 'Send Location')],
//     );
//
//     const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);
//
//     await _localNotificationsPlugin.show(
//       message.notification.hashCode,
//       message.notification?.title,
//       message.notification?.body,
//       notificationDetails,
//       payload: 'send_location', // Set payload as 'send_location' to trigger action
//     );
//   }
//
//   // Handle notification action tap to send location
//   Future<void> _onDidReceiveNotificationResponse(NotificationResponse response) async {
//     if (response.payload == 'send_location') {
//       // Get the current location
//       Position position = await Geolocator.getCurrentPosition(
//         // desiredAccuracy: LocationAccuracy.high,
//       );
//
//       // Send the location to the server
//       await locationService.sendLocationToServer(
//         latitude: position.latitude,
//         longitude: position.longitude,
//       );
//     }
//   }
// }
