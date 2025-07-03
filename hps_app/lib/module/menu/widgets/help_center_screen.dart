import 'package:flutter/material.dart';
import 'package:hps_app/shared/constants/colors.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final helpItems = [
      {
        'title': 'Cách đặt lịch',
        'content': 'Chọn dịch vụ, stylist, ngày giờ và xác nhận đặt lịch. Sau khi đặt thành công, bạn có thể xem lại lịch trong mục "Lịch đặt của tôi".'
      },
      {
        'title': 'Cách huỷ lịch',
        'content': 'Vào "Lịch đặt của tôi", chọn lịch muốn huỷ và nhấn nút "Huỷ".'
      },
      {
        'title': 'Làm sao để đánh giá dịch vụ?',
        'content': 'Sau khi hoàn thành dịch vụ, vào mục lịch sử và nhấn "Đánh giá" để gửi nhận xét.'
      },
      {
        'title': 'Liên hệ hỗ trợ',
        'content': 'Nếu gặp vấn đề, vui lòng liên hệ hotline: 0123 456 789 hoặc email: support@hairpassion.vn.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsConstants.backgroundColor,
        title: const Text('Trung tâm trợ giúp', style: TextStyle(color: ColorsConstants.text)),
        iconTheme: const IconThemeData(color: ColorsConstants.text),
      ),
      backgroundColor: ColorsConstants.backgroundColor,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: helpItems.length,
        separatorBuilder: (context, i) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = helpItems[index];
          return Card(
            color: ColorsConstants.secondsBackground,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['title']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorsConstants.text)),
                  const SizedBox(height: 8),
                  Text(item['content']!, style: const TextStyle(color: ColorsConstants.text)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
