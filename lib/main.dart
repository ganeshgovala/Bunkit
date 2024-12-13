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
    Future<String> getRegNo() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString("reg_no").toString();
    }

    Future<String> getPassword() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString("password").toString();
    }

    String reg_no = await getRegNo();
    String password = await getPassword();

    await AttendanceMethods().fetchThisMonthSubWiseData(reg_no, password);
    await AttendanceMethods().fetchTillNowSubWiseData(reg_no, password);

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (!kIsWeb) {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );

    Workmanager().registerPeriodicTask(
      "Bunkit : ",
      "Attendance Refreshed",
      frequency: const Duration(hours: 1),
      initialDelay: calculateInitialDelay(),
      constraints: Constraints(networkType: NetworkType.connected),
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
      // home: AttendanceTillNow(reg_no: "23pa1a0577",),
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: SplashScreen(),
      ),
    );
  }
}

Duration calculateInitialDelay() {
  DateTime now = DateTime.now();
  DateTime ninePM = DateTime(now.year, now.month, now.day, 9, 00, 00);
  if (now.isAfter(ninePM)) {
    ninePM = ninePM.add(Duration(hours: 1));
  }
  return ninePM.difference(now);
}
