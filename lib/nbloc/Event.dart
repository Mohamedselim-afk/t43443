//  Events
abstract class LocationEvent {}
class LoadLocation extends LocationEvent {}

abstract class MessageEvent {}
class NewMessageReceived extends MessageEvent {
  final String message;
  NewMessageReceived(this.message);
}