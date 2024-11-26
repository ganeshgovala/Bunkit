import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bunkit/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

abstract class RegisterEvent {}
class CheckRegisterEvent extends RegisterEvent {
  String email;
  String password;
  CheckRegisterEvent({required this.email, required this.password});
}

abstract class RegisterState {}
class InitialRegisterState extends RegisterState {}
class EcapValidationLoadingRegisterState extends RegisterState {}
class RegisterValidationLoadingState extends RegisterState{}
class LoadedRegisterState extends RegisterState {
  Map<String,dynamic> result;
  LoadedRegisterState({required this.result});
}

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(InitialRegisterState()) {
    on<CheckRegisterEvent>((event, emit) async {
      emit(EcapValidationLoadingRegisterState());
      try {
        print("Calling validation checker");
        Map<String,dynamic> result = await validationChecker(event.email.substring(0,10), event.password);
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

  Future<Map<String, dynamic>> validationChecker(String reg_no, String password) async {
    print("Validation function called");
    final url = Uri.parse('https://pythonapi-dtrp.onrender.com/getAttendance');
    final Map<String, String> data = {
      'username': reg_no,
      'password': password,
    };
    print("posting data to url");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    print("data posted to url");
    print("loading....");
    if (response.statusCode == 200) {
      print("webscrapping completed");
      final Map<String, dynamic> result = jsonDecode(response.body);
      if(result['message'] != "Invalid") {
        return {
          "till_now": result['message']['till_now'].toString(),
          "till_now_attended": result['message']['till_now_attended'].toString(),
          "this_month": result['message']['this_month'].toString(),
          "this_month_attended": result['message']['this_month_attended'].toString(),
          "name": result['message']['name'].toString(),
        };
      }
      else {
        return {"till_now" : "Invalid"};
      }
    }

    return {"till_now" : "Error"};  
  }
}
