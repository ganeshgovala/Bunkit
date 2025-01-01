// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:bunkit/bloc/login_bloc.dart';
import 'package:bunkit/components/attendance.dart';
import 'package:bunkit/firebase_options.dart';
import 'package:bunkit/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String reg_no = prefs.getString("reg_no") ?? "";
      String password = prefs.getString("password") ?? "";

      if (reg_no.isNotEmpty && password.isNotEmpty) {
        debugPrint("Fetching attendance data for user: $reg_no");
        await AttendanceMethods().fetchThisMonthSubWiseData(reg_no, password);
        await AttendanceMethods().fetchTillNowSubWiseData(reg_no, password);
        debugPrint("Attendance data successfully updated.");
      } else {
        debugPrint("Missing credentials. reg_no: ${reg_no.isEmpty ? 'MISSING' : 'PRESENT'}, password: ${password.isEmpty ? 'MISSING' : 'PRESENT'}");
      }
    } catch (e, stackTrace) {
      debugPrint("Error in background task: $e");
      debugPrint("Stack trace: $stackTrace");
    }
    return Future.value(true);
  });
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (!kIsWeb) {
    Workmanager().initialize(
      callbackDispatcher, // Reference to the task handler
      isInDebugMode: true, // Set to false for production
    );

    Workmanager().registerPeriodicTask(
      "attendance_refresh_task", // Unique task name
      "AttendanceRefresh", // Task identifier
      frequency: const Duration(hours: 1), // Task runs every 1 hour
      initialDelay: const Duration(minutes: 5), // Optional: delay after app start
      constraints: Constraints(
        networkType: NetworkType.connected, // Requires internet connection
      ),
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
      // home: BunkMeter(),
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: SplashScreen(),
      ),
    );
  }
}

Duration calculateInitialDelay() {
  DateTime now = DateTime.now();
  DateTime ninePM = DateTime(now.year, now.month, now.day, 12, 00, 00);
  if (now.isAfter(ninePM)) {
    ninePM = ninePM.add(Duration(hours: 1));
  }
  return ninePM.difference(now);
}
