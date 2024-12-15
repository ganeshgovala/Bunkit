// ignore_for_file: prefer_const_constructors, prefer_final_fields, must_be_immutable, avoid_print

import 'dart:ui';

import 'package:bunkit/bloc/attendance_bloc.dart';
import 'package:bunkit/bloc/register_bloc.dart';
import 'package:bunkit/components/attendance.dart';
import 'package:bunkit/components/dialog_box.dart';
import 'package:bunkit/components/input_field.dart';
import 'package:bunkit/pages/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isChecked = false;
  Future<void> addDataToLS(String reg_no, String password, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("reg_no", reg_no);
    await prefs.setString("password", password);
    await prefs.setString("name", name);
    await prefs.setBool("isLoggedIn", true);
  }

  @override
  Widget build(BuildContext context) {
    final registerBloc = BlocProvider.of<RegisterBloc>(context);
    final attendanceBloc = BlocProvider.of<AttendanceBloc>(context);
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
                      top: MediaQuery.of(context).size.width *
                          (80 / MediaQuery.of(context).size.width),
                      right: MediaQuery.of(context).size.width *
                          (10 / MediaQuery.of(context).size.width),
                      child: Transform.rotate(
                          angle: 0.333,
                          child: Image.asset("lib/assets/heart-eyed-emoji.png",
                              height: MediaQuery.of(context).size.width *
                                  (66 / MediaQuery.of(context).size.width)))),
                  Positioned(
                      top: MediaQuery.of(context).size.width *
                          (50 / MediaQuery.of(context).size.width),
                      left: MediaQuery.of(context).size.width *
                          (20 / MediaQuery.of(context).size.width),
                      child: Transform.rotate(
                          angle: -0.733,
                          child: Image.asset("lib/assets/jealous-emoji.png",
                              height: MediaQuery.of(context).size.width *
                                  (50 / MediaQuery.of(context).size.width)))),
                  Positioned(
                      top: MediaQuery.of(context).size.width *
                          (30 / MediaQuery.of(context).size.width),
                      right: MediaQuery.of(context).size.width *
                          (100 / MediaQuery.of(context).size.width),
                      child: Transform.rotate(
                          angle: -0.533,
                          child: Image.asset("lib/assets/tongue-out-emoji.png",
                              height: MediaQuery.of(context).size.width *
                                  (62 / MediaQuery.of(context).size.width)))),
                  Positioned(
                      top: MediaQuery.of(context).size.width *
                          (180 / MediaQuery.of(context).size.width),
                      left: MediaQuery.of(context).size.width *
                          (-50 / MediaQuery.of(context).size.width),
                      child: Transform.rotate(
                          angle: 0.1,
                          child: Image.asset("lib/assets/sparkle-emoji.png",
                              height: MediaQuery.of(context).size.width *
                                  (100 / MediaQuery.of(context).size.width)))),
                  Positioned(
                      top: MediaQuery.of(context).size.width *
                          (130 / MediaQuery.of(context).size.width),
                      left: MediaQuery.of(context).size.width *
                          (60 / MediaQuery.of(context).size.width),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 5),
                        child: Transform.rotate(
                            angle: 0.633,
                            child: Image.asset("lib/assets/shocking-emoji.png",
                                height: MediaQuery.of(context).size.width *
                                    (105 / MediaQuery.of(context).size.width))),
                      )),
                  Positioned(
                      top: MediaQuery.of(context).size.width *
                          (180 / MediaQuery.of(context).size.width),
                      right: MediaQuery.of(context).size.width *
                          (60 / MediaQuery.of(context).size.width),
                      child: Transform.rotate(
                          angle: -0.733,
                          child: Image.asset("lib/assets/devil-emoji.png",
                              height:
                                  MediaQuery.of(context).size.width * 0.35))),
                ],
              )),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.0634),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
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
                    controller: widget._nameController),
                SizedBox(height: MediaQuery.of(context).size.width * 0.0283),
                InputField(
                    hintText: "Email",
                    obsecureText: false,
                    controller: widget._emailController),
                SizedBox(height: MediaQuery.of(context).size.width * 0.0283),
                InputField(
                    hintText: "Password",
                    obsecureText: true,
                    controller: widget._passwordController),
                SizedBox(height: MediaQuery.of(context).size.width * 0.0283),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CheckboxListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Row(
                      children: [
                        Text('I Agree to ',
                            style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.width * 0.0384,
                              color: const Color.fromARGB(255, 52, 52, 52),
                            )),
                        Text('Terms and Conditions',
                            style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.width * 0.0384,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 22, 22, 22),
                            )),
                      ],
                    ),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                    activeColor: Colors.black,
                    checkColor: Colors.white,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (widget._emailController.text == "" &&
                        widget._passwordController.text == "") {
                      CustomDialog().showCustomDialog(
                          context, "Error", "Enter Email and Password");
                    } else if (isChecked == false) {
                      CustomDialog().showCustomDialog(
                          context, "Error", "Accept Terms & Conditions");
                    } else if (widget._emailController.text.length < 10) {
                      CustomDialog().showCustomDialog(
                          context, "Email Error", "Enter valid Email address");
                    } else if (widget._emailController.text != "" &&
                        widget._passwordController.text != "") {
                      registerBloc.add(CheckRegisterEvent(
                          email: widget._emailController.text,
                          password: widget._passwordController.text));
                    }
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.width * 0.135,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 30, 30, 30),
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: BlocListener<RegisterBloc, RegisterState>(
                            listener: (context, state) async {
                          if (state is LoadedRegisterState) {
                            if (state.result.containsKey("result")) {
                              CustomDialog().showCustomDialog(
                                  context, "Invalid", state.result["result"]);
                            } else {
                              attendanceBloc.add(AddAttendanceEvent(
                                  data: state.result,
                                  reg_no: widget._emailController.text
                                      .substring(0, 10)));
                            }
                          }
                        }, child: BlocBuilder<RegisterBloc, RegisterState>(
                                builder: (context, state) {
                          if (state is LoadingRegisterState) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.width * 0.065,
                              width: MediaQuery.of(context).size.width * 0.065,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 3),
                            );
                          }
                          return BlocListener<AttendanceBloc, AttendanceState>(
                            listener: (context, state) async {
                              if (state is LoadedAttendanceState &&
                                  state.result == "done") {
                                print("calling updateUserDetailsEvent");
                                attendanceBloc.add(UpdateUserDetailsEvent(
                                    reg_no: widget._emailController.text
                                        .substring(0, 10),
                                    password: widget._passwordController.text,
                                    name: widget._nameController.text));
                              } else if (state is LoadedAttendanceState &&
                                  state.result == "both operations done") {
                                print("Navigating");
                                await addDataToLS(
                                    widget._emailController.text
                                        .substring(0, 10),
                                    widget._passwordController.text,
                                    widget._nameController.text);
                                await AttendanceMethods()
                                    .fetchThisMonthSubWiseData(
                                        widget._emailController.text
                                            .substring(0, 10),
                                        widget._passwordController.text);
                                await AttendanceMethods()
                                    .fetchTillNowSubWiseData(
                                        widget._emailController.text
                                            .substring(0, 10),
                                        widget._passwordController.text);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavigation()));
                              } else if (state is LoadedAttendanceState) {
                                CustomDialog().showCustomDialog(
                                    context,
                                    "Oops..",
                                    "Unable to add the data. Try again");
                              }
                            },
                            child: BlocBuilder<AttendanceBloc, AttendanceState>(
                              builder: (context, state) {
                                if (state is LoadingAttendanceState) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.065,
                                    width: MediaQuery.of(context).size.width *
                                        0.065,
                                    child: CircularProgressIndicator(
                                        color: Colors.white, strokeWidth: 3),
                                  );
                                }
                                return Text("Sign up",
                                    style: GoogleFonts.poppins(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.0434,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ));
                              },
                            ),
                          );
                        })),
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.0257),
                Text("Already have an account ?",
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.width * 0.0384,
                      color: const Color.fromARGB(255, 52, 52, 52),
                    )),
                SizedBox(height: MediaQuery.of(context).size.width * 0.0144),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("Signin",
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * 0.0434,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 21, 21, 21),
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
