import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hps_app/module/login/screens/login_screen.dart';
import 'package:hps_app/module/menu/widgets/schedule_screen.dart';
import 'package:hps_app/module/menu/widgets/settings_screen.dart';
import 'package:hps_app/module/menu/widgets/favorite_screen.dart';
import 'package:hps_app/module/menu/widgets/help_center_screen.dart';
import 'package:hps_app/module/menu/widgets/policy_screen.dart';
import 'package:hps_app/module/menu/widgets/about_screen.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenuScreen extends StatefulWidget {
  const SideMenuScreen({super.key});

  @override
  State<SideMenuScreen> createState() => _SideMenuScreenState();
}

class _SideMenuScreenState extends State<SideMenuScreen> {
  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
    });
  }

  Future<void> _handleLogout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã đăng xuất!')));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.87,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/NghiaLe.png'),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _username.isNotEmpty ? _username : '---',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        'Thành viên mới',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(color: Color(0xff677D75)),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final items = [
                      OptionItem(
                        icon: 'assets/svgs/settings.svg',
                        title: 'Cài đặt',
                        onChanged: _loadUsername,
                      ),
                      OptionItem(
                        icon: 'assets/svgs/calendar.svg',
                        title: 'Lịch đặt của tôi',
                      ),
                      OptionItem(
                        icon: 'assets/svgs/favorite.svg',
                        title: 'Ưa thích',
                      ),
                      OptionItem(
                        icon: 'assets/svgs/help.svg',
                        title: 'Trung tâm trợ giúp',
                      ),
                      OptionItem(
                        icon: 'assets/svgs/policy.svg',
                        title: 'Chính sách và điều khoản',
                      ),
                      OptionItem(
                        icon: 'assets/svgs/info.svg',
                        title: 'Về Tran Manh Hair Passion Studio',
                      ),
                    ];
                    return items[index];
                  },
                  separatorBuilder:
                      (context, index) =>
                          const Divider(color: Color(0xff677D75)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: InkWell(
                  onTap: () => _handleLogout(context),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorsConstants.yellowPrimary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.logout, color: Colors.black),
                        SizedBox(width: 8),
                        Text(
                          'Đăng xuất',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionItem extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback? onChanged;

  const OptionItem({super.key, required this.icon, required this.title, this.onChanged});

  void handleOptionTap(BuildContext context) async {
    switch (title) {
      case 'Cài đặt':
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        );
        if (onChanged != null) onChanged!();
        break;
      case 'Lịch đặt của tôi':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScheduleScreen()),
        );
        break;
      case 'Ưa thích':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FavoriteScreen()),
        );
        break;
      case 'Trung tâm trợ giúp':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HelpCenterScreen()),
        );
        break;
      case 'Chính sách và điều khoản':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PolicyScreen()),
        );
        break;
      case 'Về Tran Manh Hair Passion Studio':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AboutScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(icon),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white70,
        size: 16,
      ),
      onTap: () => handleOptionTap(context),
    );
  }
}
