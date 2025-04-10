import 'package:flutter/material.dart';

PreferredSizeWidget buildAppBar(
  BuildContext context, {
  Function()? onPre,
  Function()? onNext,
}) {
  return AppBar(
    backgroundColor: Color(0xFF1A3C30),
    elevation: 0,
    centerTitle: true,
    title: Text(
      "Đặt lịch cắt tóc",
      style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: "Roboto"),
    ),

    leading: IconButton(
      icon: Icon(
        Icons.chevron_left,
        color: Colors.white,
      ), // **Nút trái (back)**
      onPressed: onPre,
    ),

    actions: [
      IconButton(
        icon: Icon(
          Icons.chevron_right,
          color: Colors.white,
        ), // **Nút phải (next)**
        onPressed: onNext,
      ),
    ],
  );
}
