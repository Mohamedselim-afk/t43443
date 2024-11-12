// Bloc 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Event.dart';
import 'State.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<LoadLocation>((event, emit) async {
      Position position = await getMockLocation();
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);

      //  SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('latitude', position.latitude.toString());
      prefs.setString('longitude', position.longitude.toString());
      prefs.setString('address', placemarks.first.name ?? 'No address');


      emit(LocationLoaded(
        position.latitude.toString(),
        position.longitude.toString(),
        placemarks.first.name ?? 'No address',
      ));
    });
  }

  // Mock Location
  Future<Position> getMockLocation() async {
    // احداثيات وهم
    return Position(
        latitude: 40.7128,
        longitude: -74.0060,
        timestamp: DateTime.now(),
        accuracy: 100.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        altitudeAccuracy: 0.0,
        headingAccuracy: 0.0,
        speedAccuracy: 0.0);
  }
}

// bloc message
class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageInitial());

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    if (event is NewMessageReceived) {
      yield MessageReceived(event.message);
    }
  }
}