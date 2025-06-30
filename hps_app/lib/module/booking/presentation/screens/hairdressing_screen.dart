import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hps_app/module/booking/presentation/providers/booking_state.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:hps_app/shared/utils/format.dart';
import 'package:provider/provider.dart';
import '../../constants/booking_constants.dart';
import '../../models/service_model.dart';

class HaidressingScreen extends StatelessWidget {
  final DateTime? selectedDate;
  final String selectedTime;
  final String selectedStylist;

  const HaidressingScreen({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedStylist,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingState>(
      builder: (context, state, child) {
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: kServices.map((service) {
                  final isSelected = state.selectedServices.contains(service);
                  return GestureDetector(
                    onTap: () => state.toggleService(service),
                    child: _buildServiceCard(service, isSelected),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
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