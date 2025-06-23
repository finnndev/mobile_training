import 'package:flutter/material.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:intl/intl.dart';
import 'widgets/qr_header.dart';
import 'widgets/payment_info.dart';
import 'widgets/qr_action_buttons.dart';

class QrScreen extends StatelessWidget {
  final double? totalPrice;
  final String? customerName;
  final DateTime? paymentTime;
  const QrScreen({super.key, this.totalPrice, this.customerName, this.paymentTime});

  String _formatPrice(double? price) {
    if (price == null) return '';
    return NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0).format(price) + ' VND';
  }

  String _paymentContent(String? name) => (name ?? '') + ' thanh toán';

  @override
  Widget build(BuildContext context) {
    final now = paymentTime ?? DateTime.now();
    final timeStr = DateFormat('HH:mm').format(now);
    final priceStr = _formatPrice(totalPrice);
    final contentStr = _paymentContent(customerName);

    const sizedBox16 = SizedBox(height: 16);
    const sizedBox20 = SizedBox(height: 20);

    return Scaffold(
      backgroundColor: ColorsConstants.secondsBackground,
      body: Column(
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
                  const QrActionButtons(),
                  sizedBox16,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
