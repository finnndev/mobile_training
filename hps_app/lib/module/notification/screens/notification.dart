import 'package:flutter/material.dart';
import 'package:hps_app/shared/constants/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 0,
        right: 0,
        top: 0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.87,
        child: Container(
          decoration: const BoxDecoration(
            color: ColorsConstants.darkLeafGreen,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 8),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Center(
                      child: Text(
                        'Thông báo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
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
              const SizedBox(height: 16),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final items = [
                      NotificationItem(
                        images: 'assets/images/Frame.png',
                        title: 'Thanh toán thành công',
                        content:
                            'Chúc mừng bạn đã đặt lịch sử dụng dịch vụ tại Tran Manh HPS thành công. Rất vui lòng được phục vụ bạn.',
                      ),
                      NotificationItem(
                        title: 'Nhắc nhở',
                        content: 'Bạn có hẹn với Tran Manh HPS vào ngày hôm nay.',
                        images: 'assets/images/Frame.png',
                      ),
                      NotificationItem(
                        title:
                            'Chào mừng tới Trung tâm thông báo của Tran Manh HPS!',
                        content: 'Nhấn vào đây để tìm hiểu thêm.',
                        images: 'assets/images/Frame.png',
                      ),
                    ];
                    return items[index];
                  },
                  separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(color: Color(0xff677D75), height: 1),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String content;
  final String images;
  const NotificationItem({
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
