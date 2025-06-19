import 'package:flutter/material.dart';
import 'package:hps_app/module/home/screens/home_screen.dart';
import 'package:hps_app/module/login/screens/login_screen.dart';
import 'package:hps_app/module/splash/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool('firstLaunch') ?? true;
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  Widget initialScreen;

  if (isFirstLaunch) {
    await prefs.setBool('firstLaunch', false);
    initialScreen = SplashScreen();
  } else if (isLoggedIn) {
    initialScreen = HomeScreen();
  } else {
    initialScreen = LoginScreen();
  }

  runApp(MainApp(initialScreen: initialScreen));
}

class MainApp extends StatelessWidget {
  final Widget initialScreen;

  const MainApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: initialScreen,
      debugShowCheckedModeBanner: false,
    );
  }
}

