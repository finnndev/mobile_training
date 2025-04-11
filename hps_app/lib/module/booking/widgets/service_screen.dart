import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceScreen extends StatefulWidget {
  final String selectedDate;
  final String selectedTime;
  final String selectedStylist;

  ServiceScreen({
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedStylist,
  });

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final List<ServiceItem> services = [
    ServiceItem(iconPath: 'assets/svgs/curling.svg', label: "Uốn tóc"),
    ServiceItem(iconPath: 'assets/svgs/dying.svg', label: "Nhuộm tóc"),
    ServiceItem(iconPath: 'assets/svgs/paintbrush.svg', label: "Ép tóc"),
    ServiceItem(iconPath: 'assets/svgs/washing.svg', label: "Gội đầu"),
    ServiceItem(iconPath: 'assets/svgs/color.svg', label: "Tạo màu"),
  ];

  final List<ServiceItem> selectedServices = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            "Dịch vụ khác",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: "Roboto",
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children:
                services.map((service) {
                  final isSelected = selectedServices.contains(service);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedServices.remove(service);
                        } else {
                          selectedServices.add(service);
                        }
                      });
                    },
                    child: _buildServiceCard(service, isSelected),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard(ServiceItem service, bool isSelected) {
    return Container(
      width: 111,
      height: 80,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF1A3C30) : Color(0xFF345147),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? Color(0xFFF3AC40) : Color(0xFF677D75),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            service.iconPath,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              isSelected ? Color(0xFFF3AC40) : Colors.white,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 6),
          if (service.label.isNotEmpty)
            Text(
              service.label,
              style: TextStyle(
                color: isSelected ? Color(0xFFF3AC40) : Colors.white,
                fontSize: 14,
                fontFamily: "Roboto",
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}

class ServiceItem {
  final String iconPath;
  final String label;

  ServiceItem({required this.iconPath, required this.label});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceItem &&
          runtimeType == other.runtimeType &&
          iconPath == other.iconPath &&
          label == other.label;

  @override
  int get hashCode => iconPath.hashCode ^ label.hashCode;
}
