import 'package:flutter/material.dart';
import 'package:hps_app/shared/constants/colors.dart';

class QrHeader extends StatelessWidget {
  final String timeStr;
  const QrHeader({super.key, required this.timeStr});

  @override
  Widget build(BuildContext context) {
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
            'Quét mã để thanh toán',
            style: TextStyle(
              color: ColorsConstants.text,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: "Roboto",
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 208,
            height: 208,
            child: Image.asset('assets/images/qr.png'),
          ),
          const SizedBox(height: 16),
          Text(
            timeStr,
            style: const TextStyle(
              color: ColorsConstants.text,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const _QrInstructions(),
        ],
      ),
    );
  }
}

class _QrInstructions extends StatelessWidget {
  const _QrInstructions();
  static const List<String> _instructions = [
    '1. Một mã QR chỉ được sử dụng cho một giao dịch duy nhất.',
    '2. Không được sửa đổi số tiền và nội dung chuyển khoản.',
    '3. Lưu lại biên lai giao dịch để đối chiếu khi cần thiết.',
  ];
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _instructions
            .map((text) => Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: ColorsConstants.text,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
