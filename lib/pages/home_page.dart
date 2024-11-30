import 'package:bunkit/components/homepage_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF141414),
                          const Color(0xFF141414),
                          const Color(0xFF282828),
                          const Color(0xFF4d4d4d),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          right: -10,
                          child: Image.asset("lib/assets/main-heading.png", height: 200)),
                        Positioned(
                          top: 50,
                          left: 30,
                          child: Text("Welcome back,", style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFb7b7b7),
                          ),),
                        ),
                        Positioned(
                          top: 75,
                          left: 30,
                          child: Text("Jhon", style: GoogleFonts.poppins(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ))),
                        Positioned(
                          top: 135,
                          left: 30,
                          child: Text("Let’s keep those grades\nand attendance on track!", style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFb7b7b7),
                          ),),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 26),
              Text("Attendance", style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF232323),
              ),),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  HomepageContainer(heading: "Till Now", subHeading: "(Apr - Now)",image: "tillnow"),
                  HomepageContainer(heading: "This month",subHeading: "(November)" ,image: "thismonth")
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  HomepageContainer(heading: "Marks Store", subHeading: "Sem & Mid",image: "marksStore"),
                  HomepageContainer(heading: "Bunk-Meter",subHeading: "(November)" ,image: "bunkmeter")
                ],
              ),
              SizedBox(height: 26),
              Text("Marks Calculator", style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF232323),
              ),),
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
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Score Planner", style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                            SizedBox(height: 4),
                            Text("Plan your way to success! Calculate\nthe scores needed to hit your targets.", style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFb7b7b7),
                            ),),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left:-20,
                      top: -28,
                      child: Image.asset("lib/assets/marks-calculator.png", height: 250)
                    ),
                  ],
                ),
              ),
              SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  HomepageContainer(heading: "Mid Marks", subHeading: "",image: "thismonth"),
                  HomepageContainer(heading: "Sem Marks",subHeading: "" ,image: "marksstore")
                ],
              ),
              SizedBox(height: 40),
              Center(
                child: Text("Many more to go. Stay Tuned!", style: GoogleFonts.poppins(
                  fontSize: 8,
                ),),
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