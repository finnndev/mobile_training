import 'package:flutter/material.dart';
import 'package:hps_app/module/booking/models/home_service.dart';
import 'package:hps_app/module/booking/screens/booking_screen.dart';
import 'package:hps_app/shared/constants/colors.dart';

class ServiceGrid extends StatelessWidget {
  const ServiceGrid({super.key});

  static final List<HomeService> services = [
    HomeService(icon: Icons.cut, label: 'Cắt tóc'),
    HomeService(icon: Icons.all_inclusive, label: 'Uốn tóc'),
    HomeService(icon: Icons.water_drop, label: 'Nhuộm tóc'),
    HomeService(icon: Icons.brush, label: 'Ép tóc'),
    HomeService(icon: Icons.auto_fix_high, label: 'Gội đầu'),
    HomeService(icon: Icons.star, label: 'Tạo mẫu'),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 16,
      crossAxisSpacing: 14,
      physics: const NeverScrollableScrollPhysics(),
      children:
          services.map((service) {
            return ServiceCard(
              service: service,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BookingScreen()),
                );
              },
            );
          }).toList(),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final HomeService service;
  final VoidCallback? onTap;

  const ServiceCard({super.key, required this.service, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: ColorsConstants.secondsBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: ColorsConstants.yellowPrimary),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                service.icon,
                color: ColorsConstants.yellowPrimary,
                size: 24,
              ),
              const SizedBox(height: 10),
              Text(
                service.label,
                style: const TextStyle(
                  color: ColorsConstants.yellowPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
