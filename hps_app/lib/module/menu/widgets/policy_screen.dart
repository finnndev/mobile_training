import 'package:flutter/material.dart';
import 'package:hps_app/shared/constants/colors.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final policies = [
      {
        'title': 'Chính sách giá cả',
        'content': 'Giá dịch vụ được niêm yết công khai trên ứng dụng và tại salon. Mọi thay đổi về giá sẽ được thông báo trước.'
      },
      {
        'title': 'Chính sách bảo hành',
        'content': 'Khách hàng được bảo hành miễn phí trong 7 ngày đối với các dịch vụ cắt, uốn, nhuộm nếu có lỗi kỹ thuật từ salon.'
      },
      {
        'title': 'Chính sách thanh toán',
        'content': 'Chấp nhận thanh toán tiền mặt, chuyển khoản và các ví điện tử phổ biến. Vui lòng thanh toán đầy đủ sau khi sử dụng dịch vụ.'
      },
      {
        'title': 'Quy tắc ứng xử trong salon',
        'content': 'Vui lòng giữ gìn vệ sinh chung, không hút thuốc, không gây ồn ào, tôn trọng nhân viên và khách hàng khác.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsConstants.backgroundColor,
        title: const Text('Chính sách & Điều khoản', style: TextStyle(color: ColorsConstants.text)),
        iconTheme: const IconThemeData(color: ColorsConstants.text),
      ),
      backgroundColor: ColorsConstants.backgroundColor,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: policies.length,
        separatorBuilder: (context, i) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = policies[index];
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
