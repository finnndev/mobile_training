import 'package:flutter/material.dart';
import 'package:hps_app/shared/constants/colors.dart';

class PaymentInfo extends StatelessWidget {
  final String priceStr;
  final String contentStr;
  const PaymentInfo({super.key, required this.priceStr, required this.contentStr});

  static const _divider = Divider(color: ColorsConstants.grayLight, height: 1);
  static const _spacer = SizedBox(height: 12);

  @override
  Widget build(BuildContext context) {
    final List<_PaymentRow> rows = [
      _PaymentRow('Tên tài khoản hưởng thụ:', 'TRAN LE MANH'),
      _PaymentRow('Số tài khoản thụ hưởng:', '0806 080 688'),
      _PaymentRow('Số tiền thanh toán:', priceStr),
      _PaymentRow('Nội dung thanh toán:', contentStr),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ColorsConstants.gray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'Thông tin thanh toán',
            style: TextStyle(
              color: ColorsConstants.text,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: "Roboto",
            ),
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < rows.length; i++) ...[
            _buildPayment(rows[i].label, rows[i].value),
            if (i < rows.length - 1) ...[_spacer, _divider, _spacer],
          ],
        ],
      ),
    );
  }

  Widget _buildPayment(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: ColorsConstants.text,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              color: ColorsConstants.text,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _PaymentRow {
  final String label;
  final String value;
  const _PaymentRow(this.label, this.value);
}
