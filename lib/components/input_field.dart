// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final bool obsecureText;
  final TextEditingController controller;
  const InputField({
    required this.hintText,
    required this.obsecureText,
    required this.controller,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obsecureText,
      controller: controller,
      style: GoogleFonts.poppins(
        fontSize: MediaQuery.of(context).size.width * 0.0394,
        color: Colors.black,
      ),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.width * 0.0394,
            color: const Color.fromARGB(255, 71, 71, 71),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.0394, vertical: MediaQuery.of(context).size.width * 0.0283),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 2,
                color: Colors.black,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: 2,
                color: Colors.black,
              ))),
    );
  }
}
