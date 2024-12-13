import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class AttendanceMethods {
  Future<void> fetchTillNowSubWiseData(reg_no, password) async {
    print("Fetching data...");
    final url = Uri.parse('https://pythonapi-dtrp.onrender.com/tillNowSubWise');
    final Map<String, String> data = {
      'username': reg_no,
      'password': password
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Map<String,dynamic> attendance = {};
      for(int i = 0; i < data.length; i++) {
        if(data[i][0] == "FSD") {
          attendance[data[i][0]] = data[i][3] +"/"+data[i][4]+","+data[i][5];
        }
        else {
          attendance[data[i][0]] = data[i][1] +"/"+data[i][2]+","+data[i][3];
        }
      }
      print(attendance);
      FirebaseFirestore.instance.collection("Users").doc(reg_no).collection("Attendance").doc("till_now_sub_wise").set(attendance);
      await FirebaseFirestore.instance.collection("Users").doc(reg_no).collection("Attendance").doc("lastUpdated").set(
        {
          "LastUpdated" : DateTime.now().day.toString()+"/"+DateTime.now().month.toString()+" "+DateTime.now().hour.toString()+":"+DateTime.now().minute.toString(),
        }
      );
    } else {
      print('Failed to load data');
    }
  }

  Future<void> fetchThisMonthSubWiseData(reg_no, password) async {
    print("Fetching data...");
    final url = Uri.parse('https://pythonapi-dtrp.onrender.com/thisMonthSubWise');
    final Map<String, String> data = {
      'username': reg_no,
      'password': password
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Map<String,dynamic> attendance = {};
      for(int i = 0; i < data.length; i++) {
        if(data[i][0] == "FSD") {
          attendance[data[i][0]] = data[i][3] +"/"+data[i][4]+","+data[i][5];
        }
        else {
          attendance[data[i][0]] = data[i][1] +"/"+data[i][2]+","+data[i][3];
        }
      }
      print(attendance);
      await FirebaseFirestore.instance.collection("Users").doc(reg_no).collection("Attendance").doc("this_month_sub_wise").set(attendance);
      await FirebaseFirestore.instance.collection("Users").doc(reg_no).collection("Attendance").doc("lastUpdated").set(
        {
          "LastUpdated" : DateTime.now().day.toString()+"/"+DateTime.now().month.toString()+" "+DateTime.now().hour.toString()+":"+DateTime.now().minute.toString(),
        }
      );
    } else {
      print('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> validationChecker(String reg_no, String password) async {
    final url = Uri.parse('https://pythonapi-dtrp.onrender.com/getAttendance');
    final Map<String, String> data = {
      'username': reg_no,
      'password': password,
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      await fetchThisMonthSubWiseData(reg_no, password);
      await fetchTillNowSubWiseData(reg_no, password);
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

  Future<void> updateData(reg_no, password) async {
    final url = Uri.parse('https://pythonapi-dtrp.onrender.com/updateData');
    final Map<String, String> data = {
      'username': reg_no,
      'password': password,
    };
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      print(response.body);
      final Map<String, dynamic> result = jsonDecode(response.body);
      print(result);
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(reg_no)
          .collection("Attendance")
          .doc("AttendanceInfo")
          .set({
        "till_now": result['message']['till_now'],
        "till_now_attended": result['message']['till_now_attended'],
        "this_month": result['message']['this_month'],
        "this_month_attended": result['message']['this_month_attended'],
      });
    }
    print("COMPLETED");
  }
}