import 'package:flutter/material.dart';
import 'package:hps_app/module/booking/constants/asset_path.dart';
import 'package:hps_app/module/home/screens/home_screen.dart';
import 'package:hps_app/module/register/screens/register.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:hps_app/shared/constants/mock_data.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _phoneOrEmailController;
  late TextEditingController _passwordController;
  
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _phoneOrEmailController = TextEditingController();
    _passwordController = TextEditingController();
    _loadSavedData();
  }

  @override
  void dispose() {
    _phoneOrEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedData() async {
    List<Map<String, String>> users = await MockData.getUsers();
    if (users.isNotEmpty) {
      Map<String, String> lastUser = users.last;
      // Ưu tiên điền số điện thoại, nếu không có thì điền email
      _phoneOrEmailController.text = lastUser['phone']?.isNotEmpty == true
          ? lastUser['phone']!
          : (lastUser['email'] ?? '');
      _passwordController.text = lastUser['password'] ?? '';
    }
  }

  Widget _buildTextField(String hint, {bool isPassword = false}) {
    return TextField(
      controller: isPassword ? _passwordController : _phoneOrEmailController,
      obscureText: isPassword ? !_isPasswordVisible : false,
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
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
                : null,
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
        onPressed:
            _isLoading
                ? null
                : () async {
                  setState(() => _isLoading = true);
                  String input = _phoneOrEmailController.text.trim();
                  String password = _passwordController.text.trim();
                  List<Map<String, String>> users = await MockData.getUsers();

                  Map<String, String>? matchedUser = users.firstWhere(
                    (user) =>
                        (user['phone'] == input ||
                         user['email'] == input) &&
                        user['password'] == password,
                    orElse: () => {},
                  );

                  if (matchedUser.isNotEmpty) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('phone', matchedUser['phone'] ?? '');
                    await prefs.setString('email', matchedUser['email'] ?? '');

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Sai số điện thoại/email hoặc mật khẩu! Vui lòng thử lại.',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }

                  setState(() => _isLoading = false);
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
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 2,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.secondsBackground,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                  AssetPath.logo,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Tran Manh",
                    style: TextStyle(
                      color: ColorsConstants.yellowPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 46,
                      fontFamily: 'EB Garamond',
                    ),
                  ),
                  const Text(
                    "HAIR PASSION STUDIO",
                    style: TextStyle(
                      fontFamily: 'EB Garamond',
                      fontSize: 14,
                      color: ColorsConstants.yellowPrimary,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "Đăng nhập",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildTextField('Số điện thoại hoặc Gmail'),
                  const SizedBox(height: 32),
                  _buildTextField('Mật khẩu', isPassword: true),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'Quên mật khẩu ?',
                      style: TextStyle(color: ColorsConstants.customBackground),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildButton(
                    'Đăng nhập',
                    ColorsConstants.yellowPrimary,
                    Colors.black,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Hoặc',
                    style: TextStyle(color: ColorsConstants.customBackground),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white70),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Đăng nhập bằng facebook',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Bạn đã có tài khoản chưa?',
                        style: TextStyle(
                          color: ColorsConstants.customBackground,
                        ),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
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
                  const SizedBox(height: 20),
                ],
              ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: Container(
                  height: 24,
                  width: 200,
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
            ),
        ],
      
      ),
    );
  }
}
