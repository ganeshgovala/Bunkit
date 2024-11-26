import 'package:bunkit/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';

abstract class LoginEvent{}
class CheckLoginEvent extends LoginEvent{
  final String email;
  final String password;
  CheckLoginEvent({required this.email, required this.password});
}

abstract class LoginState{}
class InitialLoginState extends LoginState{}
class LoadingLoginState extends LoginState{}
class LoadedLoginState extends LoginState{
  String result;
  LoadedLoginState({required this.result});
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  AuthService authService = AuthService();

  LoginBloc() : super(InitialLoginState()) {
    on<CheckLoginEvent>((event, emit) async {
      emit(LoadingLoginState());
      try {
        await authService.login(email: event.email, password: event.password);
        emit(LoadedLoginState(result: "valid"));
      } on FirebaseAuthException catch(e) {
        emit(LoadedLoginState(result: e.message.toString()));
        print(e.message);
      }
    });
  }
}