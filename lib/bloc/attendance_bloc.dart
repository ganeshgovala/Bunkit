// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

abstract class AttendanceEvent{}
class UpdateUserDetailsEvent extends AttendanceEvent{
  String reg_no;
  String password;
  String name;
  UpdateUserDetailsEvent({required this.reg_no, required this.password, required this.name});
}
class AddAttendanceEvent extends AttendanceEvent{
  Map<String, dynamic> data;
  String reg_no;
  AddAttendanceEvent({required this.data, required this.reg_no});
}
class UpdateAttendanceEvent extends AttendanceEvent {
  String reg_no;
  String password;
  UpdateAttendanceEvent({required this.reg_no, required this.password});
}

abstract class AttendanceState{}
class InitialAttendanceState extends AttendanceState{}
class LoadingAttendanceState extends AttendanceState{}
class LoadedAttendanceState extends AttendanceState{
  String result;
  LoadedAttendanceState({required this.result});
}

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(InitialAttendanceState()) {
    on<AddAttendanceEvent>((event, emit) async {
      print("UpdateAttendanceEvent called");
      emit(LoadingAttendanceState());
      String result = await addData(event.data, event.reg_no);
      print("adding completed");
      emit(LoadedAttendanceState(result: result));
    });

    on<UpdateUserDetailsEvent>((event, emit) async {
      print("Update User Details Event called");
      emit(LoadingAttendanceState());
      String response = await addUserDetails(event.reg_no, event.name, event.password);
      emit(LoadedAttendanceState(result: response));
    });

    on<UpdateAttendanceEvent>((event, emit) async {
      await updateData(event.reg_no, event.password);
    });
  }

  Future<String> addUserDetails(reg_no, name, password) async {
    try {
      await FirebaseFirestore.instance
      .collection("Users")
      .doc(reg_no)
      .collection('Details')
      .doc('UserInfo')
      .set(
        {
          'reg_no': reg_no,
          'password': password,
          'name': name,
        }
      );
      return 'both operations done';
    } on FirebaseException catch(e) {
      print(e.message);
      return e.message.toString();
    }
  }

  Future<String> addData(data, reg_no) async {
    try {
      await FirebaseFirestore.instance
        .collection("Users")
        .doc(reg_no)
        .collection("Attendance")
        .doc("AttendanceInfo")
        .set(
          {
            'till_now': data["till_now"],
            'till_now_attended': data["till_now_attended"],
            'this_month': data["this_month"],
            'this_month_attended': data["this_month_attended"],
          }
        );
        return "done";
    } on FirebaseException catch(e) {
      print(e.message);
      return "done";
    }
  }

  Future<void> updateData(reg_no, password) async {
    final url = Uri.parse('https://pythonapi-dtrp.onrender.com/updateData');
    final Map<String, String> data = {
      'username' : reg_no,
      'password' : password,
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type' : 'application/json',
      },
      body: jsonEncode(data)
    );
    if(response.statusCode == 200) {
      final Map<String,dynamic> result = jsonDecode(response.body);
      await FirebaseFirestore.instance
        .collection("Users")
        .doc(reg_no)
        .collection("Attendance")
        .doc("AttendanceInfo")
        .set(
          {
            "till_now" : result['message']['till_now'],
            "till_now_attended" : result['message']['till_now_attended'],
            "this_month" : result['message']['this_month'],
            "this_month_attended" : result['message']['this_month_attended'],
          }
        );
    }
  }
}