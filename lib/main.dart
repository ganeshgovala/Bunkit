// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:bunkit/bloc/attendance_bloc.dart';
import 'package:bunkit/bloc/login_bloc.dart';
import 'package:bunkit/firebase_options.dart';
import 'package:bunkit/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: SplashScreen(),
      ),
    );
  }
}