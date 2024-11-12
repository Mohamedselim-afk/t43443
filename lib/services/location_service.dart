// import 'package:geolocator/geolocator.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class LocationService {
//   final Dio _dio = Dio();
//
//   Future<void> sendLocationToServer({required double latitude, required double longitude}) async {
//     try {
//       await _dio.post(
//         'https://your-api-url.com/location',
//         data: {
//           'latitude': latitude,
//           'longitude': longitude,
//         },
//       );
//     } catch (e) {
//       throw Exception('Error sending location: ${e.toString()}');
//     }
//   }
//
//   Future<void> saveLocationToPreferences(Position position) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setDouble('latitude', position.latitude);
//     await prefs.setDouble('longitude', position.longitude);
//   }
//
//   Future<Position> getLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       throw Exception('Location services are disabled.');
//     }
//
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         throw Exception('Location permissions are denied.');
//       }
//     }
//
//     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//
//
//     // Store location in SharedPreferences
//     await saveLocationToPreferences(position);
//
//     return position;
//   }
//
//   Future<Position?> getLocationFromPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     final latitude = prefs.getDouble('latitude');
//     final longitude = prefs.getDouble('longitude');
//
//     if (latitude != null && longitude != null) {
//       return Position(
//         latitude: latitude,
//         longitude: longitude,
//         timestamp: DateTime.now(),
//         accuracy: 0.0,
//         altitude: 0.0,
//         heading: 0.0,
//         speed: 0.0,
//         speedAccuracy: 0.0,
//         altitudeAccuracy: 0.0,
//         headingAccuracy: 0.0,
//       );
//     }
//     return null;
//   }
// }
