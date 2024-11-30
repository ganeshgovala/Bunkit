// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously, non_constant_identifier_names

import 'dart:ui';
import 'package:bunkit/bloc/attendance_bloc.dart';
import 'package:bunkit/bloc/login_bloc.dart';
import 'package:bunkit/bloc/register_bloc.dart';
import 'package:bunkit/components/dialog_box.dart';
import 'package:bunkit/components/input_field.dart';
import 'package:bunkit/pages/bottom_navigation.dart';
import 'package:bunkit/pages/home_page.dart';
import 'package:bunkit/pages/register_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Future<void> addDataToLS(String reg_no, String password) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance
                                                                    .collection("Users")
                                                                    .doc(reg_no)
                                                                    .collection("Details")
                                                                    .doc("UserInfo")
                                                                    .get();
    final data = documentSnapshot.data();
    final String name = data!['name'].toString();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("reg_no", reg_no);
    await prefs.setString("password", password);
    await prefs.setString("name", name);
    await prefs.setBool("isLoggedIn", true);
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
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
                          child: Image.asset("lib/assets/devil-emoji.png",
                              height: MediaQuery.of(context).size.width *
                                  (66 / MediaQuery.of(context).size.width)))),
                  Positioned(
                      top: MediaQuery.of(context).size.width *
                          (50 / MediaQuery.of(context).size.width),
                      left: MediaQuery.of(context).size.width *
                          (20 / MediaQuery.of(context).size.width),
                      child: Transform.rotate(
                          angle: -0.733,
                          child: Image.asset("lib/assets/shocking-emoji.png",
                              height: MediaQuery.of(context).size.width *
                                  (50 / MediaQuery.of(context).size.width)))),
                  Positioned(
                      top: MediaQuery.of(context).size.width *
                          (30 / MediaQuery.of(context).size.width),
                      right: MediaQuery.of(context).size.width *
                          (100 / MediaQuery.of(context).size.width),
                      child: Transform.rotate(
                          angle: -0.533,
                          child: Image.asset("lib/assets/sparkle-emoji.png",
                              height: MediaQuery.of(context).size.width *
                                  (62 / MediaQuery.of(context).size.width)))),
                  Positioned(
                      top: MediaQuery.of(context).size.width *
                          (180 / MediaQuery.of(context).size.width),
                      left: MediaQuery.of(context).size.width *
                          (-50 / MediaQuery.of(context).size.width),
                      child: Transform.rotate(
                          angle: 0.1,
                          child: Image.asset("lib/assets/tongue-out-emoji.png",
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
                            child: Image.asset("lib/assets/jealous-emoji.png",
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
                          child: Image.asset("lib/assets/heart-eyed-emoji.png",
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
                  child: Text("Signin",
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * 0.077,
                        color: const Color.fromARGB(255, 19, 19, 19),
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.0283),
                InputField(
                  hintText: "Email",
                  obsecureText: false,
                  controller: _emailController,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.0283),
                InputField(
                    hintText: "Password",
                    obsecureText: true,
                    controller: _passwordController),
                SizedBox(height: MediaQuery.of(context).size.width * 0.0283),
                Container(
                    height: MediaQuery.of(context).size.width * 0.135,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 30, 30, 30),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) async {
                        if (state is LoadedLoginState) {
                          print("Loaded State");
                          if (state.result == "valid") {
                            await addDataToLS(_emailController.text.substring(0,10), _passwordController.text);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavigation()));
                          } else {
                            print(state.result);
                            CustomDialog().showCustomDialog(
                                context, "Error", "Invalid Credentials");
                          }
                        }
                      }, builder: (context, state) {
                        if (state is LoadingLoginState) {
                          print("Loading State");
                          return SizedBox(
                            height: MediaQuery.of(context).size.width * 0.065,
                            width: MediaQuery.of(context).size.width * 0.065,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 3),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            if (_emailController.text != "" &&
                                _passwordController.text != "") {
                              loginBloc.add(CheckLoginEvent(
                                  email: _emailController.text,
                                  password: _passwordController.text));
                            } else {
                              CustomDialog().showCustomDialog(context, "Error",
                                  "Please enter Email and Password");
                            }
                          },
                          child: Text("Signin",
                              style: GoogleFonts.poppins(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.047,
                                color: const Color.fromARGB(255, 240, 240, 240),
                                fontWeight: FontWeight.bold,
                              )),
                        );
                      }),
                    )),
                SizedBox(height: MediaQuery.of(context).size.width * 0.0257),
                Text("Don't have an account ?",
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.width * 0.0384,
                      color: const Color.fromARGB(255, 52, 52, 52),
                    )),
                SizedBox(height: MediaQuery.of(context).size.width * 0.0144),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) => RegisterBloc(),
                                ),
                                BlocProvider(
                                  create: (context) => AttendanceBloc(),
                                )
                              ],
                              child: RegisterPage(),
                            )));
                  },
                  child: Text("Create Account",
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
