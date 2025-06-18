import 'package:flutter/material.dart';
import 'package:hps_app/module/home/screens/home_screen.dart';
import 'package:hps_app/module/register/screens/register.dart';
import 'package:hps_app/shared/constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.secondsBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/img_logo.png',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 5),
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
              SizedBox(height: 40),
              Text(
                "Đăng nhập",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 32),
              _buildTextField('Số điện thoại hoặc email'),
              SizedBox(height: 32),
              _buildTextField('Mật khẩu', isPassword: true),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Quên mật khẩu ?',
                  style: TextStyle(color: ColorsConstants.customBackground),
                ),
              ),
              SizedBox(height: 32),
              _buildButton(
                'Đăng nhập',
                ColorsConstants.yellowPrimary,
                Colors.black,
              ),
              SizedBox(height: 16),
              Text(
                'Hoặc',
                style: TextStyle(color: ColorsConstants.customBackground),
              ),
              SizedBox(height: 16),
              // _buildButton(
              //   'Đăng nhập với facebook',
              //   Colors.white,
              //   Colors.black,
              //   icon: Icons.facebook,
              // ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70),
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Đăng nhập bằng facebook',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bạn đã có tài khoản chưa?',
                    style: TextStyle(color: ColorsConstants.customBackground),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Đăng ký',
                      style: TextStyle(
                        color: ColorsConstants.yellowPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );
  }

  Widget _buildButton(
    String text,
    Color color,
    Color textColor, {
    IconData? icon,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, color: textColor),
            if (icon != null) SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
