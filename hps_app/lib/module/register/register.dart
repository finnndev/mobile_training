import 'package:flutter/material.dart';
import 'package:hps_app/module/login/login_screen.dart';
import 'package:hps_app/shared/constants/colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  Widget _buildSpacer(double height) {
    return SizedBox(height: height);
  }

  Widget _buildTextField(String hinText) {
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        hintText: hinText,
        hintStyle: TextStyle(color: Colors.white70),
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1A3C30),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 69, left: 16, right: 16, bottom: 18),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/img_logo.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 2),
              Text(
                "Tran Manh",
                style: TextStyle(
                  color: ColorsConstants.yellowPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  fontFamily: 'EB Garamond',
                ),
              ),
              Text(
                "HAIR PASSION STUDIO",
                style: TextStyle(
                  fontFamily: 'EB Garamond',
                  fontSize: 9,
                  color: ColorsConstants.yellowPrimary,
                ),
              ),
              SizedBox(height: 35),
              Text(
                'Đăng Ký',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 20),
              //Form đăng ký
              _buildTextField('Họ và tên'),
              SizedBox(height: 20),
              _buildTextField('Số đện thoại hoặc email'),
              SizedBox(height: 20),
              _buildTextField('Mật khẩu'),
              SizedBox(height: 20),
              _buildTextField('Nhập lại mật khẩu'),
              SizedBox(height: 25),
              //Điều khoản
              Text(
                'Bằng cách Đăng ký, bạn đồng ý với các điều khoản và điều kiện của TranManhHPS.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
              SizedBox(height: 25),
              //Nút đăng ký
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Đăng ký thành công!')),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffF3AC40),
                  padding: EdgeInsets.symmetric(horizontal: 155, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
                child: Text(
                  'Đăng ký',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1A3C30),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 10),
              //"Hoặc"
              Text(
                'Hoặc',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xff99A8A3)),
              ),
              SizedBox(height: 10),
              //Nút đăng ký với Facebook
              OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Đăng ký với Facebook')),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.facebook, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'Đăng ký với Facebook',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              //Liên kết với Đăng nhập
              // RichText(
              //   text: TextSpan(
              //     text: 'Bạn đã có tài khoản?',
              //     style: TextStyle(color: Color(0xff99A8A3)),
              //     children: [
              //       TextSpan(
              //         text: 'Đăng nhập',
              //         style: TextStyle(
              //           color: Color(0xffF3AC40),
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bạn đã có tài khoản chưa? ',
                    style: TextStyle(color: ColorsConstants.customBackground),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'Đăng nhập',
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
}
