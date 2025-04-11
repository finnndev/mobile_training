import 'package:flutter/material.dart';

class TabBarr extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  TabBarr({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFF1A3C30), // Màu nền
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(5, (index) => _buildStep(index)),
      ),
    );
  }

  Widget _buildStep(int index) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Container(
          height: 3,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            //  Tô vàng nếu index <= currentIndex
            color: index <= currentIndex ? Color(0xFFF3AC40) : Colors.white,
            borderRadius: BorderRadius.circular(2.5),
          ),
        ),
      ),
    );
  }
}
