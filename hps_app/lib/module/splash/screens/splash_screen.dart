import 'package:flutter/material.dart';
import 'package:hps_app/module/register/screens/register.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      setState(() {
        _showButton = true;
      });
    });
  }

  Future<void> _handleGetStarted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false); 

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/img_logo.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                Text(
                  "Tran Manh",
                  style: TextStyle(
                    color: ColorsConstants.yellowPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 46,
                    fontFamily: 'EB Garamond',
                  ),
                ),
                Text(
                  "HAIR PASSION STUDIO",
                  style: TextStyle(
                    fontFamily: 'EB Garamond',
                    fontSize: 14,
                    color: ColorsConstants.yellowPrimary,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          AnimatedOpacity(
            opacity: _showButton ? 1.0 : 0.0,
            duration: const Duration(seconds: 1),
            child:
                _showButton
                    ? SizedBox(
                      width: 361,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFB347),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: _handleGetStarted,
                        child: const Text(
                          " Bắt đầu ",
                          style: TextStyle(
                            color: Color(0xFF1A3C30),
                            fontSize: 16,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                    : const SizedBox(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
