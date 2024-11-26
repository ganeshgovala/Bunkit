import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AttendanceEvent{}
class UpdateUserDetailsEvent extends AttendanceEvent{
  String reg_no;
  String password;
  String name;
  UpdateUserDetailsEvent({required this.reg_no, required this.password, required this.name});
}
class UpdateAttendanceEvent extends AttendanceEvent{
  Map<String, dynamic> data;
  String reg_no;
  UpdateAttendanceEvent({required this.data, required this.reg_no});
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
    on<UpdateAttendanceEvent>((event, emit) async {
      emit(LoadingAttendanceState());
      await addData(event.data, event.reg_no);
    });

    on<UpdateUserDetailsEvent>((event, emit) async {
      emit(LoadingAttendanceState());
      String response = await addUserDetails(event.reg_no, event.name, event.password);
      emit(LoadedAttendanceState(result: response));
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
      return 'done';
    } on FirebaseException catch(e) {
      print(e.message);
      return e.message.toString();
    }
  }

  Future<void> addData(data, reg_no) async {
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
    } on FirebaseException catch(e) {
      print(e.message);
    }
  }
}