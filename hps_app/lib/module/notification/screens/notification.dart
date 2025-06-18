import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A3C34),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF1A3C34),
        elevation: 0,
        title: Text(
          'Thông báo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); //Đóng màn hình thông báo
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hôm nay',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Xem tất cả',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                NotificationItem(
                  images: 'assets/images/Frame.png',
                  title: 'Thanh toán thành công',
                  content:
                      'Chúc mừng bạn đã đặt lịch sử dụng dịch vụ tại Tran Manh HPS thành công. Rất vui lòng được phục vụ bạn.',
                ),
                SizedBox(height: 16),
                Divider(color: Color(0xff677D75), height: 1),
                SizedBox(height: 16),
                NotificationItem(
                  title: 'Nhắc nhở',
                  content: 'Bạn có hẹn với Tran Manh HPS vào ngày hôm nay.',
                  images: 'assets/images/Frame.png',
                ),
                SizedBox(height: 16),
                Divider(color: Color(0xff677D75), height: 1),
                SizedBox(height: 16),
                NotificationItem(
                  title: 'Chào mừng tới Trung tâm thông báo của Tran Manh HPS!',
                  content: 'Nhấn vào đây để tìm hiểu thêm.',
                  images: 'assets/images/Frame.png',
                ),
                SizedBox(height: 16),
                Divider(color: Color(0xff677D75), height: 1),
                SizedBox(height: 16),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String content;
  final String images;
  NotificationItem({
    super.key,
    required this.title,
    required this.content,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(images, width: 48, height: 48),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        content,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
