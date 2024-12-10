import 'dart:convert';

import 'package:bunkit/components/attendance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class AttendanceTillNow extends StatefulWidget {
  final String reg_no;
  const AttendanceTillNow({
    required this.reg_no,
    super.key,
  });
  @override
  State<AttendanceTillNow> createState() => _AttendanceTillNowState();
}

class _AttendanceTillNowState extends State<AttendanceTillNow> {
  void getThingsDone() {
    AttendanceMethods().fetchSubWiseData("23pa1a0577", "Ganesh@123");
  }

  @override
  void initState() {
    // TODO: implement initState
    getThingsDone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  SizedBox(width: 26),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_rounded, size: 24)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 18,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [Colors.black87, Colors.black54],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '  Till Now',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(widget.reg_no)
                                    .collection("Attendance")
                                    .doc("AttendanceInfo")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Loading...',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 60,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 12),
                                          decoration: BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            'Attended : ' + "Loading...",
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }

                                  if (snapshot.hasError) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.error.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 60,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 12),
                                          decoration: BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            'Attended : Error',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  final data = snapshot.data;
                                  if (data != null) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data["till_now"] + "%",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 60,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 12),
                                          decoration: BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            'Attended : ' +
                                                data["till_now_attended"],
                                            style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return Text("");
                                }),
                          ],
                        ),
                      ),
                      Positioned(
                        right: -10,
                        bottom: 0,
                        child: Image.asset(
                          'lib/assets/character.png',
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(2),
                  },
                  border: TableBorder(
                      horizontalInside: BorderSide(color: Colors.grey)),
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: Text(
                              'Subject',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(213, 0, 0, 0),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: Text(
                              'Attended',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(213, 0, 0, 0),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: Text(
                              'Percentage',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(213, 0, 0, 0),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc("23pa1a0577")
                    .collection("Attendance")
                    .doc("till_now_sub_wise")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 3,
                        ))
                    );
                  }
                  if (snapshot.hasError) {
                    return Text("Error");
                  }
                  final data = snapshot.requireData;
                  print(data);
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: ListView.builder(
                        itemCount: data.data()!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width:MediaQuery.of(context).size.width * 0.33,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14.0),
                                        child: Text(
                                          data.data()!.keys.elementAt(index),
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:MediaQuery.of(context).size.width * 0.3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Center(
                                          child: Text(
                                        data
                                            .data()!
                                            .values
                                            .elementAt(index)
                                            .toString()
                                            .substring(
                                                0,
                                                data
                                                    .data()!
                                                    .values
                                                    .elementAt(index)
                                                    .toString()
                                                    .indexOf(",")),
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                    ),
                                  ),
                                  Container(
                                    width:MediaQuery.of(context).size.width * 0.26,
                                    child: Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Center(
                                          child: Text(
                                        data
                                            .data()!
                                            .values
                                            .elementAt(index)
                                            .toString()
                                            .substring(
                                                data
                                                        .data()!
                                                        .values
                                                        .elementAt(index)
                                                        .toString()
                                                        .indexOf(",") +
                                                    1,
                                                data
                                                    .data()!
                                                    .values
                                                    .elementAt(index)
                                                    .toString()
                                                    .length),
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                            ],
                          );
                        }),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
