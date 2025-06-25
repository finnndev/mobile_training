import 'package:flutter/material.dart';
import 'package:hps_app/module/home/widgets/banner_slide.dart';
import 'package:hps_app/module/home/widgets/service_grid.dart';
import 'package:hps_app/module/home/widgets/trending_styles.dart';
import 'package:hps_app/module/notification/screens/notification.dart';
import 'package:hps_app/module/options/screens/options.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:hps_app/shared/utils/asset_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  String username = '...';

  final List<String> bannerImages = [
    AssetPath.urlImage.banner1,
    AssetPath.urlImage.banner1,
    AssetPath.urlImage.banner1,
  ];

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Khách';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.secondsBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Image.asset(AssetPath.urlImage.logo, height: 32),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NotificationScreen()),
                ),
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => OptionsScreen()),
                ),
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
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: username,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Đã đến lúc sửa lại mái tóc rối của bạn rồi!",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 16),
            BannerSlider(
              bannerImages: bannerImages,
              onChanged: (index) => setState(() => activeIndex = index),
              activeIndex: activeIndex,
            ),
            const SizedBox(height: 24),
            const Text(
              "Dịch vụ",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const ServiceGrid(),
            const SizedBox(height: 24),
            const Text(
              "Mẫu xu hướng",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const TrendingStyles(),
          ],
        ),
      ),
    );
  }
}
