import 'package:flutter/material.dart';
import 'package:hps_app/shared/constants/colors.dart';


class TabBarr extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  TabBarr({required this.currentIndex, required this.onTap});

  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: ColorsConstants.secondsBackground, 
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
        
            color: index <= currentIndex ? ColorsConstants.yellowPrimary : ColorsConstants.text,
            borderRadius: BorderRadius.circular(2.5),
          ),
        ),
      ),
    );
  }
}