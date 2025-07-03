import 'package:flutter/material.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:hps_app/module/booking/constants/asset_path.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsConstants.backgroundColor,
        title: const Text('Về Tran Manh Hair Passion Studio', style: TextStyle(color: ColorsConstants.text)),
        iconTheme: const IconThemeData(color: ColorsConstants.text),
      ),
      backgroundColor: ColorsConstants.backgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    AssetPath.logo,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tran Manh Hair Passion Studio',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: ColorsConstants.text),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Địa chỉ: 123 Đường Salon, Quận 1, TP.HCM',
                  style: TextStyle(color: ColorsConstants.text),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Hotline: 0123 456 789',
                  style: TextStyle(color: ColorsConstants.text),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Email: contact@hairpassion.vn',
                  style: TextStyle(color: ColorsConstants.text),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tran Manh Hair Passion Studio là địa chỉ làm đẹp uy tín với đội ngũ stylist chuyên nghiệp, không gian hiện đại và dịch vụ tận tâm. Chúng tôi luôn nỗ lực mang đến trải nghiệm tốt nhất cho khách hàng.',
                  style: TextStyle(color: ColorsConstants.text),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
