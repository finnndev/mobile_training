import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hps_app/shared/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final VoidCallback? onNext;
  final bool isItemSelected;

  const CustomAppBar({
    Key? key,
    this.onBack,
    this.onNext,
    this.isItemSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsConstants.secondsBackground,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Đặt lịch cắt tóc",
        style: TextStyle(
          color: ColorsConstants.text,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: "Roboto",
        ),
      ),
      leading: IconButton(
        icon: SvgPicture.asset('assets/svgs/left.svg', width: 24, height: 24),
        onPressed: onBack,
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}