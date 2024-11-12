import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _message = "";
  String _latitude = "";
  String _longitude = "";
  String _address = "";

  @override
  void initState() {
    super.initState();
    _initializeFCM();
    _loadSavedLocation();
  }

  // تهيئة Firebase Cloud Messaging
  Future<void> _initializeFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // طلب إذن الوصول للإشعارات
    NotificationSettings settings = await messaging.requestPermission();
    print('User granted permission: ${settings.authorizationStatus}');


    // الحصول على توكن الجهاز
    String? token = await messaging.getToken();
    print("FCM Token: $token");

    // استلام الرسائل
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        _message = message.notification?.body ?? 'No message body';
      });
      _getLocation();
    });
  }

  // تحميل الموقع المخزن من SharedPreferences
  Future<void> _loadSavedLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _latitude = prefs.getString('latitude') ?? 'Not available';
      _longitude = prefs.getString('longitude') ?? 'Not available';
      _address = prefs.getString('address') ?? 'Not available';
    });
  }

  // الحصول على الموقع الحالي
  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // اذا لم تكن خدمة الموقع مفعلّة
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      // اذا تم رفض الإذن بشكل دائم
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // الحصول على العنوان
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude); // تأكد من استخدام هذا الشكل

    // حفظ البيانات في SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('latitude', position.latitude.toString());
    prefs.setString('longitude', position.longitude.toString());
    prefs.setString('address', placemarks.first.name ?? 'No address');

    setState(() {
      _latitude = position.latitude.toString();
      _longitude = position.longitude.toString();
      _address = placemarks.first.name ?? 'No address';
    });
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
            Text('Message: $_message', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Latitude: $_latitude', style: TextStyle(fontSize: 16)),
            Text('Longitude: $_longitude', style: TextStyle(fontSize: 16)),
            Text('Address: $_address', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}







// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'api/api_service.dart';
// import 'bloc/login_bloc.dart';
// import 'firebase_options.dart';
// import 'screens/login_screen.dart';
// import 'services/notification_service.dart';
// import 'services/location_service.dart';
//
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
//
//
//   final locationService = LocationService();
//   final notificationService = NotificationService(locationService);
//   await notificationService.initialize();
//
//   runApp(MyApp(notificationService));
// }
//
// class MyApp extends StatelessWidget {
//   final NotificationService notificationService;
//
//   MyApp(this.notificationService);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Notifications with Location',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: BlocProvider(
//         create: (context) => LoginBloc(
//           ApiService(),
//           notificationService,
//           LocationService(),
//         ),
//         child: LoginScreen(),
//       ),
//     );
//   }
// }
