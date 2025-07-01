import 'package:flutter/material.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:intl/intl.dart';
import 'widgets/qr_header.dart';
import 'widgets/payment_info.dart';
import 'widgets/qr_action_buttons.dart';
import 'package:hps_app/module/menu/widgets/model%20.dart';
import 'package:hps_app/module/menu/widgets/service.dart';
import 'package:hps_app/module/success/screens/success_screen.dart';

class QrScreen extends StatelessWidget {
  final double? totalPrice;
  final String? customerName;
  final DateTime? paymentTime;
  final String? stylist;
  final String? service;
  final String? price;
  const QrScreen({
    super.key,
    this.totalPrice,
    this.customerName,
    this.paymentTime,
    this.stylist,
    this.service,
    this.price,
  });

  String _formatPrice(double? price) {
    if (price == null) return '';
    return NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0).format(price) + ' VND';
  }

  String _paymentContent(String? name) => (name ?? '') + ' thanh toán';

  @override
  Widget build(BuildContext context) {
    final now = paymentTime ?? DateTime.now();
    final timeStr = DateFormat('HH:mm').format(now);
    final priceStr = price ?? _formatPrice(totalPrice);
    final contentStr = _paymentContent(customerName);

    const sizedBox16 = SizedBox(height: 16);
    const sizedBox20 = SizedBox(height: 20);

    return Scaffold(
      backgroundColor: ColorsConstants.secondsBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    sizedBox16,
                    QrHeader(timeStr: timeStr),
                    sizedBox16,
                    PaymentInfo(priceStr: priceStr, contentStr: contentStr),
                    sizedBox20,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsConstants.yellowPrimary,
                        foregroundColor: Colors.black,
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
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
                      },
                      child: const Text('Thanh toán', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    sizedBox16,
                    const QrActionButtons(),
                    sizedBox16,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
