import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

PreferredSizeWidget buildAppBar(
  BuildContext context, {
  VoidCallback? onBack,
  VoidCallback? onNext,
}) {
  return AppBar(
    backgroundColor: Color(0xFF1A3C30),
    elevation: 0,
    centerTitle: true,
    title: Text(
      "Đặt lịch cắt tóc",
      style: TextStyle(
        color: Colors.white,
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
        icon: SvgPicture.asset('assets/svgs/right.svg', width: 24, height: 24),
        onPressed: onNext,
      ),
    ],
  );
}
