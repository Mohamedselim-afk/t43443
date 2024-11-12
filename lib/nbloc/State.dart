// States
abstract class LocationState {}
class LocationInitial extends LocationState {}
class LocationLoaded extends LocationState {
  final String latitude;
  final String longitude;
  final String address;
  LocationLoaded(this.latitude, this.longitude, this.address);
}

abstract class MessageState {}
class MessageInitial extends MessageState {}
class MessageReceived extends MessageState {
  final String message;
  MessageReceived(this.message);
}