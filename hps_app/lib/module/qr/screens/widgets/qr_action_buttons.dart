import 'package:flutter/material.dart';
import 'package:hps_app/module/menu/widgets/model%20.dart';
import 'package:hps_app/module/menu/widgets/service.dart';
import 'package:hps_app/module/success/screens/success_screen.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:intl/intl.dart';

class QrActionButtons extends StatelessWidget {
  final String? stylist;
  final String? customerName;
  final DateTime? paymentTime;
  final String? service;
  final String priceStr;
  const QrActionButtons({
    super.key,
    this.stylist,
    this.customerName,
    this.paymentTime,
    this.service,
    required this.priceStr,
  });

  Future<void> _handlePayment(BuildContext context) async {
    final model = ScheduleModel(
      time: stylist != null && paymentTime != null
          ? DateFormat('HH:mm').format(paymentTime!)
          : DateFormat('HH:mm').format(DateTime.now()),
      date: stylist != null && paymentTime != null
          ? DateFormat('dd/MM/yyyy').format(paymentTime!)
          : DateFormat('dd/MM/yyyy').format(DateTime.now()),
      stylist: stylist ?? customerName ?? 'Khách',
      service: service ?? 'Thanh toán QR',
      price: priceStr,
      type: 'history',
    );
    await ScheduleService.addSchedule(model);
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SuccessScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsConstants.yellowPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: TextButton.icon(
              onPressed: () => _handlePayment(context),
              icon: const Icon(Icons.payment, color: ColorsConstants.gray),
              label: const Text(
                'Thanh toán',
                style: TextStyle(color: ColorsConstants.backgroundColor),
              ),
              style: TextButton.styleFrom(
                foregroundColor: ColorsConstants.gray,
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
