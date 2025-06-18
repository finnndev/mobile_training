import 'package:flutter/material.dart';
import 'package:hps_app/module/login/screens/login_screen.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:hps_app/shared/constants/mock_data.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _fullNameController;
  late TextEditingController _phoneOrEmailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _phoneOrEmailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneOrEmailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _buildSpacer(double height) {
    return SizedBox(height: height);
  }

  TextEditingController _getController(String hintText) {
    switch (hintText) {
      case 'Họ và tên':
        return _fullNameController;
      case 'Số điện thoại hoặc email':
        return _phoneOrEmailController;
      case 'Mật khẩu':
        return _passwordController;
      case 'Nhập lại mật khẩu':
      default:
        return _confirmPasswordController;
    }
  }

  bool _isObscure(String hintText) {
    if (hintText == 'Mật khẩu') return !_isPasswordVisible;
    if (hintText == 'Nhập lại mật khẩu') return !_isConfirmPasswordVisible;
    return false;
  }

  IconButton? _getSuffixIcon(String hintText) {
    if (hintText != 'Mật khẩu' && hintText != 'Nhập lại mật khẩu') return null;

    bool isVisible =
        hintText == 'Mật khẩu' ? _isPasswordVisible : _isConfirmPasswordVisible;

    return IconButton(
      icon: Icon(
        isVisible ? Icons.visibility : Icons.visibility_off,
        color: Colors.white70,
      ),
      onPressed: () {
        setState(() {
          if (hintText == 'Mật khẩu') {
            _isPasswordVisible = !_isPasswordVisible;
          } else {
            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
          }
        });
      },
    );
  }

  Widget _buildTextField(String hintText, {bool isPassword = false}) {
    return TextField(
      controller: _getController(hintText),
      obscureText: isPassword ? _isObscure(hintText) : false,
      autofocus: true,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        suffixIcon: isPassword ? _getSuffixIcon(hintText) : null,
      ),
    );
  }

  Future<void> _handleRegister(BuildContext context) async {
    String fullName = _fullNameController.text.trim();
    String phoneOrEmail = _phoneOrEmailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      _showSnackBar(
        context,
        'Mật khẩu không khớp! Vui lòng thử lại.',
        Colors.red,
      );
      return;
    }

    if (password.isEmpty) {
      _showSnackBar(context, 'Mật khẩu không được để trống!', Colors.red);
      return;
    }

    await MockData.saveUser(fullName, phoneOrEmail, password);

    _showSnackBar(context, 'Đăng ký thành công!', Colors.green);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _showSnackBar(
    BuildContext context,
    String message,
    Color backgroundColor,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1A3C30),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 69,
          left: 16,
          right: 16,
          bottom: 18,
        ),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/img_logo.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              _buildSpacer(2),
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
              _buildSpacer(35),
              const Text(
                'Đăng Ký',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
              _buildSpacer(20),
              _buildTextField('Họ và tên'),
              _buildSpacer(20),
              _buildTextField('Số điện thoại hoặc email'),
              _buildSpacer(20),
              _buildTextField('Mật khẩu', isPassword: true),
              _buildSpacer(20),
              _buildTextField('Nhập lại mật khẩu', isPassword: true),
              _buildSpacer(25),
              const Text(
                'Bằng cách Đăng ký, bạn đồng ý với các điều khoản và điều kiện của TranManhHPS.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
              _buildSpacer(25),
              ElevatedButton(
                onPressed: () => _handleRegister(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF3AC40),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 155,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
                child: const Text(
                  'Đăng ký',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1A3C30),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _buildSpacer(10),
              const Text(
                'Hoặc',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xff99A8A3)),
              ),
              _buildSpacer(10),
              OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đăng ký với Facebook')),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.facebook, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'Đăng ký với Facebook',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              _buildSpacer(20),
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
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
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
