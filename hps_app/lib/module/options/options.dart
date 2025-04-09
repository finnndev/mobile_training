import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hps_app/module/login/login_screen.dart';
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
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); //Đóng màn hình tùy chọn
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            //Thông tin người dùng
            Row(
              children: [
                //Ảnh đại diện
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/NghiaLe.png'),
                ),
                SizedBox(width: 16),
                //Tên và trạng thái
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
            SizedBox(height: 24),
            Divider(color: Color(0xff677D75)),
            //Danh sách tùy chọn
            Expanded(
              child: ListView(
                children: [
                  OptionItem(
                    icon: 'assets/svgs/settings.svg',
                    title: 'Cài đặt',
                  ),
                  Divider(color: Color(0xff677D75)),
                  OptionItem(
                    icon: 'assets/svgs/calendar.svg',
                    title: 'Lịch đặt của tôi',
                  ),
                  Divider(color: Color(0xff677D75)),
                  OptionItem(
                    icon: 'assets/svgs/favorite.svg',
                    title: 'Ưa thích',
                  ),
                  Divider(color: Color(0xff677D75)),
                  OptionItem(
                    icon: 'assets/svgs/help.svg',
                    title: 'Trung tâm trợ giúp',
                  ),
                  Divider(color: Color(0xff677D75)),
                  OptionItem(
                    icon: 'assets/svgs/policy.svg',
                    title: 'Chính sách và điều khoản',
                  ),
                  Divider(color: Color(0xff677D75)),
                  OptionItem(
                    icon: 'assets/svgs/info.svg',
                    title: 'Về Tran Manh Hair Passion Studio',
                  ),
                  Divider(color: Color(0xff677D75)),
                ],
              ),
            ),
            //Nút đăng xuất
            SizedBox(
              width: double.infinity,
              height: 56,
              child: InkWell(
                onTap: () {
                  // Điều hướng về màn hình đăng nhập và xóa tất cả màn hình trước đó
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ), // Thay bằng màn hình đăng nhập của bạn
                    (Route<dynamic> route) => false,
                  );

                  // Hiển thị thông báo đăng xuất thành công
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đã đăng xuất!')),
                  );
                },
                borderRadius: BorderRadius.circular(16), // Bo góc hiệu ứng chạm
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorsConstants.yellowPrimary, // Màu nền nút
                    borderRadius: BorderRadius.circular(16), // Bo góc nút
                  ),
                  child: Text(
                    'Đăng xuất',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

//Widget cho mỗi mục tùy chọn
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
        // Xử lý khi nhấn vào từng mục (có thể chuyển sang màn hình tương ứng)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Đã nhấn vào: $title')));
      },
    );
  }
}
