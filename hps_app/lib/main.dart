import 'package:flutter/material.dart';
import 'package:hps_app/module/home/screens/home_screen.dart';
import 'package:hps_app/module/login/screens/login_screen.dart';
import 'package:hps_app/module/splash/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:hps_app/module/booking/presentation/providers/booking_state.dart';

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

  runApp(
    ChangeNotifierProvider(
      create: (_) => BookingState(),
      child: MainApp(initialScreen: initialScreen),
    ),
  );
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

