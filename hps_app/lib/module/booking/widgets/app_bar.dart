import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hps_app/shared/constants/colors.dart';
import '../services/stylist_service.dart'; 
import '../services/date_time_service.dart';
import '../services/hairdressing_service.dart';
import 'package:hps_app/module/home/screens/home_screen.dart'; // Import HomeScreen

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final VoidCallback? onNext;
  final bool isItemSelected;
  final bool showCancelDialog;

  const CustomAppBar({
    super.key,
    this.onBack,
    this.onNext,
    this.isItemSelected = false,
    this.showCancelDialog = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsConstants.secondsBackground,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Đặt lịch làm tóc",
        style: TextStyle(
          color: ColorsConstants.text,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: "Roboto",
        ),
      ),
      leading: IconButton(
        icon: SvgPicture.asset('assets/svgs/left.svg', width: 24, height: 24),
        onPressed: () async {
          if (onBack != null) {
            if (showCancelDialog) {
              _showCancelConfirmation(context);
            } else {
              onBack!();
            }
          }
        },
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            'assets/svgs/right.svg',
            width: 24,
            height: 24,
            color: isItemSelected ? Colors.white : ColorsConstants.text,
          ),
          onPressed: onNext,
        ),
      ],
    );
  }

  void _showCancelConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Xác nhận hủy"),
        content: const Text("Bạn có muốn hủy các lựa chọn hiện tại không?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Không"),
          ),
          TextButton(
            onPressed: () async {
              await StylistService.clearSelectedStylist();
              await DateTimeService.clearSelectedDateTime();
              await HairdressingService.clearSelectedServices();
              Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => HomeScreen()),
                (route) => false,
              );
            },
            child: const Text("Có"),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}