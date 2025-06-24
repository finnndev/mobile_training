import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:hps_app/shared/utils/format.dart';
import '../services/hairdressing_service.dart';
import '../models/service_model.dart';

final List<ServiceItem> kServices = [
  ServiceItem(iconPath: 'assets/svgs/cut.svg', label: "Cắt tóc", price: 150000),
  ServiceItem(iconPath: 'assets/svgs/curling.svg', label: "Uốn tóc", price: 300000),
  ServiceItem(iconPath: 'assets/svgs/dying.svg', label: "Nhuộm tóc", price: 400000),
  ServiceItem(iconPath: 'assets/svgs/paintbrush.svg', label: "Ép tóc", price: 250000),
  ServiceItem(iconPath: 'assets/svgs/washing.svg', label: "Gội đầu", price: 100000),
  ServiceItem(iconPath: 'assets/svgs/color.svg', label: "Tạo màu", price: 200000),
];

class HaidressingScreen extends StatefulWidget {
  final DateTime? selectedDate;
  final String selectedTime;
  final String selectedStylist;
  final Function(List<ServiceItem>) onServicesChanged;

  const HaidressingScreen({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedStylist,
    required this.onServicesChanged,
  });

  @override
  _HaidressingScreenState createState() => _HaidressingScreenState();
}

class _HaidressingScreenState extends State<HaidressingScreen> {
  List<ServiceItem> selectedServices = [];

  @override
  void initState() {
    super.initState();
    _loadSelectedServices();
  }

  Future<void> _saveSelectedServices() async {
    await HairdressingService.saveSelectedServices(selectedServices);
  }

  Future<void> _loadSelectedServices() async {
    final services = await HairdressingService.getSelectedServices();
    setState(() {
      selectedServices = services ?? [];
    });
    widget.onServicesChanged(selectedServices);
  }

  void _toggleService(ServiceItem service) {
    setState(() {
      selectedServices.contains(service)
          ? selectedServices.remove(service)
          : selectedServices.add(service);
    });
    widget.onServicesChanged(selectedServices);
    _saveSelectedServices();
  }

  @override
  Widget build(BuildContext context) {
    const padding16 = EdgeInsets.symmetric(horizontal: 16);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            "Thêm dịch vụ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: ColorsConstants.text,
              fontFamily: "Roboto",
            ),
          ),
        ),
        Padding(
          padding: padding16,
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: kServices.map((service) {
              final isSelected = selectedServices.contains(service);
              return GestureDetector(
                onTap: () => _toggleService(service),
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
        width: 110,
        height: 100,
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
                Column(
                  children: [
                    Text(
                      service.label,
                      style: const TextStyle(
                        color: ColorsConstants.text, 
                        fontSize: 14,
                        fontFamily: "Roboto",
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      formatCurrency(service.price) + ' VND',
                      style: const TextStyle(
                        color: ColorsConstants.yellowPrimary,
                        fontSize: 12,
                        fontFamily: "Roboto",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}