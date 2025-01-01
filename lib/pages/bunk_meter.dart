import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BunkMeter extends StatefulWidget {
  const BunkMeter({super.key});

  @override
  State<BunkMeter> createState() => _BunkMeterState();
}

class _BunkMeterState extends State<BunkMeter> {

  Future<int> getBunkableClasses() async {
    String reg_no = await getRegNo();
    return calculate(reg_no);
  }

  Future<int> calculate(String reg_no) async {
    int target = await getTarget();
    int workingDays = await getWorkingDays();
    int missed = await attendedClasses(reg_no);
    int workingHours = workingDays * 8;
    int bunkablePeriods = (workingHours * (target / 100)).floor();
    // print("Target : $target" + " workingHours : $workingHours");
    // print("Total Period required to maintain 85% attendance: $bunkablePeriods");
    // print("bunkable ${workingHours - bunkablePeriods - missed}");
    //print("Calculate : ${workingHours - bunkablePeriods - missed}");
    return workingHours - bunkablePeriods - missed;
  }

  Future<int> attendedClasses(String reg_no) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(reg_no)
            .collection("Attendance")
            .doc("AttendanceInfo")
            .get();
    if (documentSnapshot.data() != null) {
      final attended = documentSnapshot.data()!['this_month_attended'];
      List<String> arr = attended.split("/");
      return int.parse(arr[0]) - int.parse(arr[1]);
    }
    return 0;
  }

  Future<int> getTarget() async {
    String reg_no = await getRegNo();
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(reg_no)
            .collection("Details")
            .doc("UserInfo")
            .get();
    if (documentSnapshot.data() != null) {
      //print("Target : ${documentSnapshot.data()!["target"]}");
      return documentSnapshot.data()!["target"];
    }
    return 0;
  }

  Future<int> getWorkingDays() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection("WorkingDays")
            .doc("workingDays")
            .get();
    if (documentSnapshot.data() != null) {
      //print("Working Days : ${documentSnapshot.data()!['December']}");
      return documentSnapshot.data()!['December'];
    }
    return 0;
  }

  Future<String> getRegNo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("reg_no").toString();
  }

  List<String> months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            child: Column(
              children: [
                Center(
                  child: Text(
                    months[DateTime.now().month - 1],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: const Color.fromARGB(255, 102, 102, 102),
                    ),
                  ),
                ),
                FutureBuilder(
                  future: getBunkableClasses(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        children: [
                          SizedBox(height: 45),
                          Center(
                            child: CircularProgressIndicator(
                              color: const Color.fromARGB(255, 36, 36, 36),
                            ),
                          ),
                        ],
                      );
                    }
                    final data = snapshot.requireData;
                    return Center(
                      child: Text(
                        data.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 102,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 22, 22, 22),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: getTarget(),
            builder: (context, snapshot) {
              return Row(children: [
                Text("Attendance Target : "+snapshot.data.toString())
              ],);
            },
          ),
        ],
      ),
    );
  }
}
