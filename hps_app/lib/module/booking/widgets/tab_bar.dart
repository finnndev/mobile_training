import 'package:flutter/material.dart';
import 'package:hps_app/shared/constants/colors.dart';

class TabBarBooking extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const TabBarBooking({required this.currentIndex, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: ColorsConstants.secondsBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(5, (index) => _buildStep(index)),
      ),
    );
  }

  Widget _buildStep(int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Container(
          height: 3,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: index <= currentIndex ? ColorsConstants.yellowPrimary : ColorsConstants.text,
            borderRadius: BorderRadius.circular(2.5),
          ),
        ),
      ),
    );
  }
}