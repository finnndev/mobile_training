import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hps_app/shared/constants/colors.dart';


class ServiceScreen extends StatefulWidget {
  final DateTime? selectedDate;
  final String selectedTime;
  final String selectedStylist;
  final Function(List<ServiceItem>) onServicesChanged;

  const ServiceScreen({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedStylist,
    required this.onServicesChanged,
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
              color: ColorsConstants.text, 
              fontFamily: "Roboto",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: services.map((service) {
              final isSelected = selectedServices.contains(service);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedServices.remove(service);
                    } else {
                      selectedServices.add(service);
                    }
                    widget.onServicesChanged(selectedServices);
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
    return Card(
      color: isSelected ? ColorsConstants.secondsBackground : ColorsConstants.gray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? ColorsConstants.yellowPrimary : ColorsConstants.grayLight,
          width: isSelected ? 2 : 1,
        ),
      ),
      margin: EdgeInsets.zero,
      child: SizedBox(
        width: 111,
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                service.iconPath,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  isSelected ? ColorsConstants.yellowPrimary : ColorsConstants.text,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 6),
              if (service.label.isNotEmpty)
                Text(
                  service.label,
                  style: TextStyle(
                    color: isSelected ? ColorsConstants.yellowPrimary : ColorsConstants.text,
                    fontSize: 14,
                    fontFamily: "Roboto",
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
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