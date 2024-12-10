// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:bunkit/bloc/login_bloc.dart';
import 'package:bunkit/firebase_options.dart';
import 'package:bunkit/pages/add_collection.dart';
import 'package:bunkit/pages/attendance_till_now.dart';
import 'package:bunkit/pages/marks_store.dart';
import 'package:bunkit/pages/splash_screen.dart';
import 'package:bunkit/pages/under_development.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await FirebaseFirestore.instance.collection("Users").doc("demo").set(
      {
        "name" : "demo",
      }
    );

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (!kIsWeb) {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true, // Set to false in production
    );

    // Register the periodic task
    Workmanager().registerPeriodicTask(
      "dailyTask",
      "dailyFunction",
      frequency: const Duration(hours: 24),
      initialDelay: calculateInitialDelay(),
    );
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AttendanceTillNow(reg_no: "23pa1a0577",),
      // home: BlocProvider(
      //   create: (context) => LoginBloc(),
      //   child: SplashScreen(),
      // ),
    );
  }
}

Duration calculateInitialDelay() {
  // Calculate the delay until 9 PM
  DateTime now = DateTime.now();
  DateTime ninePM = DateTime(now.year, now.month, now.day, 19, 02, 00);
  if (now.isAfter(ninePM)) {
    ninePM = ninePM.add(Duration(days: 1));
  }
  return ninePM.difference(now);
}
