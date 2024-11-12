// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../api/api_service.dart';
// import '../services/notification_service.dart';
// import '../services/location_service.dart';
// import 'login_event.dart';
// import 'login_state.dart';
//
// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final ApiService apiService;
//   final NotificationService notificationService;
//   final LocationService locationService;
//
//   LoginBloc(this.apiService, this.notificationService, this.locationService) : super(LoginInitial());
//
//   @override
//   Stream<LoginState> mapEventToState(LoginEvent event) async* {
//     if (event is LoginButtonPressed) {
//       emit(LoginLoading()) ;
//       try {
//         bool isSuccess = await apiService.login(event.username, event.password);
//         if (isSuccess) {
//           await notificationService.initialize();
//
//           // Retrieve and store the location after successful login
//           await locationService.getLocation();
//
//           emit(LoginSuccess()) ;
//         }
//       } catch (error) {
//         emit(LoginFailure(error.toString())) ;
//       }
//     }
//   }
// }
