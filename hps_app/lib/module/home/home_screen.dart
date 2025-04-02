import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hps_app/shared/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.secondsBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Image.asset('assets/images/logo_register.png', height: 32),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "Xin chào, ",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: "Nghĩa Lê",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Đã đến lúc sửa lại mái tóc rối của bạn rồi!",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),

            /////
            CarouselSlider(
              options: CarouselOptions(
                height: 150,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items:
                  [
                    'assets/images/img_banner.png',
                    'assets/images/img_banner.png',
                    'assets/images/img_banner.png',
                  ].map((item) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(item, fit: BoxFit.cover, width: 1000),
                    );
                  }).toList(),
            ),

            const SizedBox(height: 16),

            const Text(
              "Dịch vụ",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 14,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ServiceCard(icon: Icons.cut, title: "Cắt tóc", isActive: true),
                ServiceCard(
                  icon: Icons.all_inclusive,
                  title: "Uốn tóc",
                  isActive: false,
                ),
                ServiceCard(icon: Icons.water_drop, title: "Nhuộm tóc"),
                ServiceCard(icon: Icons.brush, title: "Ép tóc"),
                ServiceCard(icon: Icons.auto_fix_high, title: "Gội đầu"),
                ServiceCard(icon: Icons.star, title: "Tạo mẫu"),
              ],
            ),
            const SizedBox(height: 20),

            //
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Bạn đã chọn: $title"))),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isActive
                  ? ColorsConstants.secondsBackground
                  : ColorsConstants.grayLight,
          borderRadius: BorderRadius.circular(10),

          border: Border.all(
            color:
                isActive
                    ? ColorsConstants.yellowPrimary
                    : ColorsConstants.customBackground,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? ColorsConstants.yellowPrimary : Colors.white,
              size: 24,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: isActive ? ColorsConstants.yellowPrimary : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
