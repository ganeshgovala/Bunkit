import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilepageComponent extends StatelessWidget {
  final String name;
  final String image;
  final bool toggle;
  final _controller = ValueNotifier<bool>(false);
  ProfilepageComponent({
    required this.name,
    required this.image,
    required this.toggle,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  SvgPicture.asset("lib/assets/${image}.svg", height: 22),
                  SizedBox(width: 20),
                  Text(name, style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color:const Color(0xFF232323),
                  ),)
                ],),
                toggle == true ? AdvancedSwitch(
                  controller: _controller,
                  activeColor: Colors.orange,
                  height: 22,
                  width: 36,
                ) : Container(),
              ],
            ),
            SizedBox(height: 22),
      ],
    );
  }
}