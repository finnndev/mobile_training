import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hps_app/module/login/login_screen.dart';
import 'package:hps_app/module/register/register.dart';
import 'package:hps_app/shared/constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showButton = false; // ban dau an nut

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      setState(() {
        _showButton = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/img_logo.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
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
          Spacer(),

          AnimatedOpacity(
            opacity: _showButton ? 1.0 : 0.0,
            duration: Duration(seconds: 1),
            child:
                _showButton
                    ? Container(
                      width: 361,
                      height: 56,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFB347),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
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
                    : SizedBox(),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
