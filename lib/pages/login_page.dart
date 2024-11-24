// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:bunkit/components/input_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    top: 100,
                    right: 20,
                    child: Transform.rotate(
                      angle: -0.333,
                      child: Image.asset("lib/assets/devil-emoji.png", height:66)
                    ) 
                  ),
                  Positioned(
                    top: 60,
                    left: 40,
                    child: Transform.rotate(
                      angle: 0.733,
                      child: Image.asset("lib/assets/shocking-emoji.png", height: 50)
                    ) 
                  ),
                  Positioned(
                    top: 40,
                    right: 140,
                    child: Transform.rotate(
                      angle: 0.533,
                      child: Image.asset("lib/assets/sparkle-emoji.png", height: 62)
                    ) 
                  ),
                  Positioned(
                    top: 220,
                    left: -50,
                    child: Transform.rotate(
                      angle: -0.1,
                      child: Image.asset("lib/assets/tongue-out-emoji.png", height: 100)
                    ) 
                  ),
                  Positioned(
                    top: 130,
                    left: 80,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 5),
                      child: Transform.rotate(
                        angle: -0.633,
                        child: Image.asset("lib/assets/jealous-emoji.png", height: 105)
                      ),
                    ) 
                  ),
                  Positioned(
                    top: 180,
                    right: 40,
                    child: Transform.rotate(
                      angle: 0.733,
                      child: Image.asset("lib/assets/heart-eyed-emoji.png", height: 170)
                    ) 
                  ),
                ],
              )
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(26),
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Center(
                    child: Text("Signin", style : GoogleFonts.poppins(
                      fontSize: 32,
                      color: const Color.fromARGB(255, 27, 27, 27),
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                  SizedBox(height: 20),
                  InputField(hintText: "Email"),
                  SizedBox(height: 20),
                  InputField(hintText: "Password"),
                  SizedBox(height: 20),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 30, 30, 30),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Center(
                      child: Text("Sign in", style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                    )
                  ),
                  SizedBox(height: 24),
                  Text("Dont have an account ?", style : GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 52, 52, 52),
                  )),
                  SizedBox(height: 6),
                  GestureDetector(
                    child: Text("Create Account", style : GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 21, 21, 21),
                    )),
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}