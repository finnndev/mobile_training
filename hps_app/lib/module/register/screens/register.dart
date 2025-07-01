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

    // Kiểm tra định dạng số điện thoại hoặc email
    bool isPhone = RegExp(r'^(0[0-9]{9,10})$').hasMatch(phoneOrEmail);
    bool isEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(phoneOrEmail);
    if (!isPhone && !isEmail) {
      _showSnackBar(context, 'Vui lòng nhập đúng số điện thoại hoặc email!', Colors.red);
      return;
    }

    // Lưu user với đúng trường phone/email
    await MockData.saveUser(
      fullName,
      isPhone ? phoneOrEmail : '',
      password,
      email: isEmail ? phoneOrEmail : '',
    );

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

  Widget _buildActionButton({
    required String label,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
    bool isOutlined = false,
    IconData? icon,
  }) {
    final child = icon == null
        ? Text(label, style: TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.w600))
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor),
              const SizedBox(width: 4),
              Text(label, style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          );
    return SizedBox(
      width: double.infinity,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: textColor),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
              ),
              child: child,
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
              ),
              child: child,
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
              Text(
                'Đăng ký',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
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
              _buildActionButton(
                label: 'Đăng ký',
                onPressed: () => _handleRegister(context),
                backgroundColor: ColorsConstants.yellowPrimary,
                textColor: ColorsConstants.secondsBackground,
                isOutlined: false,
              ),
              _buildSpacer(10),
              const Text(
                'Hoặc',
                textAlign: TextAlign.center,
                style: TextStyle(color: ColorsConstants.customBackground),
              ),
              _buildSpacer(10),
              _buildActionButton(
                label: 'Đăng ký với Facebook',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đăng ký với Facebook')),
                  );
                },
                backgroundColor: Colors.transparent,
                textColor: ColorsConstants.text,
                isOutlined: true,
                icon: Icons.facebook,
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
