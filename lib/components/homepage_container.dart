import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomepageContainer extends StatelessWidget {
  final String image;
  final String heading;
  final String subHeading;
  const HomepageContainer({
    required this.heading,
    required this.subHeading,
    required this.image, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.width / 2.3,
        width: MediaQuery.of(context).size.width / 2.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(colors: [
            const Color(0xFFe0e0e0),
            Colors.white,
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 10),
            Column(
              children: [
                Text(
                  heading,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                 subHeading,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width / 2.5,
              child: Image.asset("lib/assets/${image}", height: 90),
            )
          ],
        ));
  }
}
