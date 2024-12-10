import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class AttendanceMethods {
  Future<void> fetchSubWiseData(reg_no, password) async {
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
      FirebaseFirestore.instance.collection("Users").doc("23pa1a0577").collection("Attendance").doc("till_now_sub_wise").set(attendance);
    } else {
      print('Failed to load data');
    }
  }
}