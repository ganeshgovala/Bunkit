import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BunkMeterComponent extends StatelessWidget {
  final AsyncSnapshot<int> snapshot;
  final String name;
  const BunkMeterComponent({
    required this.name,
    required this.snapshot,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF232323),
                ),
              ),
              Text(
                snapshot.data == null ? "..." : snapshot.data.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF232323),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
