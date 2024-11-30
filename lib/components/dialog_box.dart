// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialog {
  dynamic showCustomDialog(BuildContext context, String title, String desc) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: EdgeInsets.all(0),
              content: Container(
                height: 180,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 29, 29, 29),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28))
                            ),
                            child: Center(
                              child: Text(title,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 120,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(desc, style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
