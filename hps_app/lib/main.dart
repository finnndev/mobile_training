import 'package:flutter/material.dart';
import 'package:hps_app/module/qr/qr_Screen.dart';
import 'package:hps_app/module/splash/screens/splash_screen.dart';

import 'module/bookingSchedule/screens/bookingSchedule_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
