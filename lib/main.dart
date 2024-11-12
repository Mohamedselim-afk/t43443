import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'nbloc/Event.dart';
import 'nbloc/State.dart';
import 'nbloc/bloc.dart';



final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);





  //local_notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(create: (context) => MessageBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _initializeFCM();
    BlocProvider.of<LocationBloc>(context).add(LoadLocation());
  }

  Future<void> _initializeFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission();
    print('User granted permission: ${settings.authorizationStatus}');
    String? token = await messaging.getToken();
    print("FCM Token: $token");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String messageBody = message.notification?.body ?? 'No message body';
      _showNotification(messageBody); // عرض الإشعار كتنبيه محلي
      BlocProvider.of<MessageBloc>(context).add(NewMessageReceived(messageBody));
      BlocProvider.of<LocationBloc>(context).add(LoadLocation()); // جلب الموقع عند استقبال الرسالة
    });
  }

  Future<void> _showNotification(String messageBody) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Message',
      messageBody,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FCM Location App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<MessageBloc, MessageState>(
              builder: (context, state) {
                String message = 'No new message';
                if (state is MessageReceived) {
                  message = state.message;
                }
                return Text('Message: $message', style: TextStyle(fontSize: 16));
              },
            ),
            SizedBox(height: 20),
            BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
                String latitude = 'Not available';
                String longitude = 'Not available';
                String address = 'Not available';
                if (state is LocationLoaded) {
                  latitude = state.latitude;
                  longitude = state.longitude;
                  address = state.address;
                }
                return Column(
                  children: [
                    Text('Latitude: $latitude', style: TextStyle(fontSize: 16)),
                    Text('Longitude: $longitude', style: TextStyle(fontSize: 16)),
                    Text('Address: $address', style: TextStyle(fontSize: 16)),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


