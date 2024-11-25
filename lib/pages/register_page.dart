// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:bunkit/components/input_field.dart';
import 'package:bunkit/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Positioned(
                      top: MediaQuery.of(context).size.width * (80/MediaQuery.of(context).size.width),
                      right: MediaQuery.of(context).size.width * (10/MediaQuery.of(context).size.width),
                      child: Transform.rotate(
                          angle: 0.333,
                          child: Image.asset("lib/assets/heart-eyed-emoji.png",
                              height: MediaQuery.of(context).size.width * (66/MediaQuery.of(context).size.width)))),
                  Positioned(
                      top: MediaQuery.of(context).size.width * (50/MediaQuery.of(context).size.width),
                      left: MediaQuery.of(context).size.width * (20/MediaQuery.of(context).size.width),     
                      child: Transform.rotate(
                          angle: -0.733,
                          child: Image.asset("lib/assets/jealous-emoji.png",
                              height: MediaQuery.of(context).size.width * (50/MediaQuery.of(context).size.width)))),
                  Positioned(
                      top: MediaQuery.of(context).size.width * (30/MediaQuery.of(context).size.width),
                      right: MediaQuery.of(context).size.width * (100/MediaQuery.of(context).size.width),
                      child: Transform.rotate(
                          angle: -0.533,
                          child: Image.asset("lib/assets/tongue-out-emoji.png",
                              height: MediaQuery.of(context).size.width * (62/MediaQuery.of(context).size.width)))),
                  Positioned(
                      top: MediaQuery.of(context).size.width * (180/MediaQuery.of(context).size.width),
                      left: MediaQuery.of(context).size.width * (-50/MediaQuery.of(context).size.width),
                      child: Transform.rotate(
                          angle: 0.1,
                          child: Image.asset("lib/assets/sparkle-emoji.png",
                              height: MediaQuery.of(context).size.width * (100/MediaQuery.of(context).size.width)))),
                  Positioned(
                      top: MediaQuery.of(context).size.width * (130/MediaQuery.of(context).size.width),
                      left: MediaQuery.of(context).size.width * (60/MediaQuery.of(context).size.width),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 5),
                        child: Transform.rotate(
                            angle: 0.633,
                            child: Image.asset("lib/assets/shocking-emoji.png",
                                height: MediaQuery.of(context).size.width * (105/MediaQuery.of(context).size.width))),
                      )),
                  Positioned(
                      top: MediaQuery.of(context).size.width * (180/MediaQuery.of(context).size.width),
                      right: MediaQuery.of(context).size.width * (60/MediaQuery.of(context).size.width),
                      child: Transform.rotate(
                          angle: -0.733,
                          child: Image.asset("lib/assets/devil-emoji.png",
                              height: MediaQuery.of(context).size.width * 0.35))),
                ],
              )),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.0634),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),
            child: Column(
              children: [
                Center(
                  child: Text("Signup",
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * 0.077,
                        color: const Color.fromARGB(255, 27, 27, 27),
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.0483),
                InputField(
                  hintText: "Name",
                  obsecureText: false,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.0283),
                InputField(
                  hintText: "Email",
                  obsecureText: false,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.0283),
                InputField(
                  hintText: "Password",
                  obsecureText: true,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.0283),
                Container(
                    height: MediaQuery.of(context).size.width * 0.135,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 30, 30, 30),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text("Sign up",
                          style: GoogleFonts.poppins(
                            fontSize: MediaQuery.of(context).size.width * 0.0434,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                    )),
                SizedBox(height: MediaQuery.of(context).size.width * 0.0257),
                Text("Already have an account ?",
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.width * 0.0384,
                      color: const Color.fromARGB(255, 52, 52, 52),
                    )),
                SizedBox(height: MediaQuery.of(context).size.width * 0.0144),
                GestureDetector(
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text("Signin",
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * 0.0434,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 21, 21, 21),
                      )),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
