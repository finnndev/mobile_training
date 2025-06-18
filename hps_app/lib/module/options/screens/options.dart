import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hps_app/module/login/screens/login_screen.dart';
import 'package:hps_app/shared/constants/colors.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.secondsBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorsConstants.secondsBackground,
        elevation: 0,
        title: Text(
          'Tùy chọn',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); 
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: const AssetImage(
                    'assets/images/NghiaLe.png',
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nghĩa Lê',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
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
              child: ListView(
                children: [
                  OptionItem(
                    icon: 'assets/svgs/settings.svg',
                    title: 'Cài đặt',
                  ),
                  const Divider(color: Color(0xff677D75)),
                  OptionItem(
                    icon: 'assets/svgs/calendar.svg',
                    title: 'Lịch đặt của tôi',
                  ),
                  const Divider(color: Color(0xff677D75)),
                  OptionItem(
                    icon: 'assets/svgs/favorite.svg',
                    title: 'Ưa thích',
                  ),
                  const Divider(color: Color(0xff677D75)),
                  OptionItem(
                    icon: 'assets/svgs/help.svg',
                    title: 'Trung tâm trợ giúp',
                  ),
                  const Divider(color: Color(0xff677D75)),
                  OptionItem(
                    icon: 'assets/svgs/policy.svg',
                    title: 'Chính sách và điều khoản',
                  ),
                  const Divider(color: Color(0xff677D75)),
                  OptionItem(
                    icon: 'assets/svgs/info.svg',
                    title: 'Về Tran Manh Hair Passion Studio',
                  ),
                  const Divider(color: Color(0xff677D75)),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: InkWell(
                onTap: () async {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đã đăng xuất!')),
                  );
                },
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
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                      ), 
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
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class OptionItem extends StatelessWidget {
  final String icon;
  final String title;

  const OptionItem({super.key, required this.icon, required this.title});

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
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Đã nhấn vào: $title')));
      },
    );
  }
}
