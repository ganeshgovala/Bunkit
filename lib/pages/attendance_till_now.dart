import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data["till_now"]+"%",
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
                                              color: const Color.fromARGB(255, 255, 255, 255),
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
                    ...List.generate(7, (index) {
                      return TableRow(
                        children: [
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14.0),
                              child: Text(
                                'DMGT',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Center(
                                child: Text(
                              '24 / 32',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Center(
                                child: Text(
                              '96%',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
