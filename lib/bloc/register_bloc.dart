// ignore_for_file: avoid_print
import 'package:bloc/bloc.dart';
import 'package:bunkit/auth/auth_service.dart';
import 'package:bunkit/components/attendance.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterEvent {}
class CheckRegisterEvent extends RegisterEvent {
  String email;
  String password;
  CheckRegisterEvent({required this.email, required this.password});
}

abstract class RegisterState {}
class InitialRegisterState extends RegisterState {}
class LoadingRegisterState extends RegisterState {}
class LoadedRegisterState extends RegisterState {
  Map<String,dynamic> result;
  LoadedRegisterState({required this.result});
}

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(InitialRegisterState()) {
    on<CheckRegisterEvent>((event, emit) async {
      emit(LoadingRegisterState());
      try {
        print("Calling validation checker");
        Map<String,dynamic> result = await AttendanceMethods().validationChecker(event.email.substring(0,10), event.password);
        print("Ecap Validation completed");
        print(result);
        if(result["till_now"] != "Invalid") {
          try {
            print("Creating user");
            await AuthService().register(event.email, event.password);
            print("user Created");
            emit(LoadedRegisterState(result: result));
          } on FirebaseAuthException catch(e) {
            print("User creation failed");
            emit(LoadedRegisterState(result: {"result" : e.message}));
          }
        } else {
          emit(LoadedRegisterState(result: {"result" : "Invalid Ecap Credentials"}));
        }
      } catch(e) {
        print("Ecap Validation failed");
        emit(LoadedRegisterState(result: {"result": e.toString()}));
      }
    });
  }
}
