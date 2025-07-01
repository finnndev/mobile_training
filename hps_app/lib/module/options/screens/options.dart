import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hps_app/module/login/screens/login_screen.dart';
import 'package:hps_app/module/options/widgets/schedule_screen.dart';
import 'package:hps_app/module/options/screens/settings_screen.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OptionsScreen extends StatefulWidget {
  const OptionsScreen({super.key});

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
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
                    final items = const [
                      OptionItem(
                        icon: 'assets/svgs/settings.svg',
                        title: 'Cài đặt',
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

class OptionItem extends StatefulWidget {
  final String icon;
  final String title;

  const OptionItem({super.key, required this.icon, required this.title});

  @override
  State<OptionItem> createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
  void handleOptionTap(BuildContext context) {
    if (widget.title == 'Lịch đặt của tôi') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ScheduleScreen()),
      );
    } else if (widget.title == 'Cài đặt') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()),
      ).then((_) async {
        // Reload username in parent OptionsScreen after returning from Settings
        if (context.findAncestorStateOfType<_OptionsScreenState>() != null) {
          await context.findAncestorStateOfType<_OptionsScreenState>()!._loadUsername();
        }
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Đã nhấn vào: ${widget.title}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(widget.icon),
      title: Text(
        widget.title,
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
