import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hps_app/shared/constants/colors.dart';
import '../../data/services/stylist_service.dart'; 
import '../../data/services/date_time_service.dart';
import '../../data/services/hairdressing_service.dart';
import 'package:hps_app/module/home/screens/home_screen.dart'; 
import '../../constants/asset_path.dart';

class BookingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final VoidCallback? onNext;
  final bool isItemSelected;
  final bool showCancelDialog;

  const BookingAppBar({
    super.key,
    this.onBack,
    this.onNext,
    this.isItemSelected = false,
    this.showCancelDialog = false,
  });

  Future<void> _clearAllBookingData() async {
    await StylistService.clearSelectedStylist();
    await DateTimeService.clearSelectedDateTime();
    await HairdressingService.clearSelectedServices();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsConstants.secondsBackground,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        "Đặt lịch làm tóc",
        style: TextStyle(
          color: ColorsConstants.text,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: "Roboto",
        ),
      ),
      leading: IconButton(
        icon: SvgPicture.asset(AssetPath.left, width: 24, height: 24),
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
            AssetPath.right,
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
        backgroundColor: ColorsConstants.secondsBackground,
        title: const Text(
          "Xác nhận hủy",
          style: TextStyle(color: ColorsConstants.yellowPrimary),
        ),
        content: const Text(
          "Bạn có muốn hủy các lựa chọn hiện tại không?",
          style: TextStyle(color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Không",
              style: TextStyle(color: ColorsConstants.yellowPrimary),
            ),
          ),
          TextButton(
            onPressed: () async {
              await _clearAllBookingData();
              Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (route) => false,
              );
            },
            child: const Text(
              "Có",
              style: TextStyle(color: ColorsConstants.yellowPrimary),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}