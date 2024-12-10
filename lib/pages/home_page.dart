import 'package:bunkit/components/homepage_container.dart';
import 'package:bunkit/pages/attendance_this_month.dart';
import 'package:bunkit/pages/attendance_till_now.dart';
import 'package:bunkit/pages/under_development.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<String> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("name").toString();
  }

  Future<String> getRegNo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("reg_no").toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 220,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        const Color(0xFF141414),
                        const Color(0xFF141414),
                        const Color(0xFF282828),
                        const Color(0xFF4d4d4d),
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            bottom: 0,
                            right: -20,
                            child: Image.asset("lib/assets/main-heading.png",
                                height: 200)),
                        Positioned(
                          top: 50,
                          left: 20,
                          child: Text(
                            "Welcome back,",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFb7b7b7),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 80,
                            left: 20,
                            child: FutureBuilder(
                              future: getName(), 
                              builder: (context, snapshot) {
                                return Text(snapshot.hasData ? snapshot.data.toString() : "Friend",
                                style: GoogleFonts.poppins(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ));
                              },
                            ) 
                        ),
                        Positioned(
                          top: 135,
                          left: 20,
                          child: Text(
                            "Let’s keep those grades\nand attendance on track!",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFb7b7b7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 26),
              Text(
                "Attendance",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF232323),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      String reg_no = await getRegNo();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceTillNow(reg_no: reg_no,)));
                    },
                    child: HomepageContainer(
                        heading: "Till Now",
                        subHeading: "(Dec - Now)",
                        image: "tillnow"),
                  ),
                  GestureDetector(
                    onTap: () async {
                      String reg_no = await getRegNo();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceThisMonth(reg_no: reg_no,)));
                    },
                    child: HomepageContainer(
                        heading: "This month",
                        subHeading: "(November)",
                        image: "thismonth"),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UnderDevelopment()));
                    },
                    child: HomepageContainer(
                        heading: "Marks Store",
                        subHeading: "Sem & Mid",
                        image: "marksStore"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UnderDevelopment()));
                    },
                    child: HomepageContainer(
                        heading: "Bunk-Meter",
                        subHeading: "(November)",
                        image: "bunkmeter"),
                  )
                ],
              ),
              SizedBox(height: 26),
              Text(
                "Marks Calculator",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF232323),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.only(left: 38),
                        width: MediaQuery.of(context).size.width / 1.3,
                        height: 150,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF141414),
                                const Color(0xFF141414),
                                const Color(0xFF282828),
                                const Color(0xFF4d4d4d),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Score Planner",
                                style: GoogleFonts.poppins(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),
                            SizedBox(height: 4),
                            Text(
                              "Plan your way to success! Calculate\nthe scores needed to hit your targets.",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFb7b7b7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        left: -20,
                        top: -28,
                        child: Image.asset("lib/assets/marks-calculator.png",
                            height: 250)),
                  ],
                ),
              ),
              SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UnderDevelopment()));
                    },
                    child: HomepageContainer(
                        heading: "Mid Marks", subHeading: "", image: "thismonth"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UnderDevelopment()));
                    },
                    child: HomepageContainer(
                        heading: "Sem Marks", subHeading: "", image: "marksstore"),
                  )
                ],
              ),
              SizedBox(height: 40),
              Center(
                child: Text(
                  "Many more to go. Stay Tuned!",
                  style: GoogleFonts.poppins(
                    fontSize: 8,
                  ),
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

//Plan your way to success! Calculate the scores needed to hit your targets.