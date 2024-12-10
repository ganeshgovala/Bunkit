import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnderDevelopment extends StatelessWidget {
  const UnderDevelopment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("lib/assets/development.png", height: 250,),
          ),
          SizedBox(height: 20,),
          Center(
            child : Text("Under Development", style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),)
          )
        ],
      )
    );
  }
}