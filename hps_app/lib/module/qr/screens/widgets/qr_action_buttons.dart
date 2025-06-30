import 'package:flutter/material.dart';
import 'package:hps_app/module/success/screens/success_screen.dart';
import 'package:hps_app/shared/constants/colors.dart';

class QrActionButtons extends StatelessWidget {
  const QrActionButtons({super.key});

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: ColorsConstants.gray),
      label: Text(
        label,
        style: const TextStyle(color: ColorsConstants.backgroundColor),
      ),
      style: TextButton.styleFrom(
        foregroundColor: ColorsConstants.gray,
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
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
            child: _buildButton(
              context: context,
              icon: Icons.payment,
              label: 'Thanh toán',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SuccessScreen()),
                );
               
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: ColorsConstants.gray),
            height: 40,
            width: 1,
          ),
          Expanded(
            child: _buildButton(
              context: context,
              icon: Icons.file_download_outlined,
              label: 'Tải mã QR',
              onPressed: () => _showSnackBar(context, 'Đã tải mã QR'),
            ),
          ),
        ],
      ),
    );
  }
}
