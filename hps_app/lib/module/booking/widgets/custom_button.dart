import 'package:flutter/material.dart';
import 'package:hps_app/shared/constants/colors.dart';


class CustomButton extends StatelessWidget {
  final String creatorName;
  final VoidCallback onPressed;
  final String text; 
  final DateTime? selectedDate;
  final String selectedTime;
  final List<String> selectedServices;
  final int currentStep;

  const CustomButton({
    super.key,
    required this.creatorName,
    required this.onPressed,
    required this.text,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedServices,
    required this.currentStep,
  });

  bool get _isEnabled {
    switch (currentStep) {
      case 0:
        return creatorName.isNotEmpty;
      case 1:
        return selectedDate != null && selectedTime.isNotEmpty;
      case 2:
        return true;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsConstants.backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          creatorName.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      creatorName,
                      style: TextStyle(
                        color: ColorsConstants.yellowPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto",
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _buildServiceLabel(),
                        style: TextStyle(
                          color: ColorsConstants.yellowPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                )
              : SizedBox.shrink(),

       
          if (selectedDate != null && selectedTime.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatFullDate(selectedDate!),
                  style: TextStyle(
                    color: ColorsConstants.yellowPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  selectedTime,
                  style: TextStyle(
                    color: ColorsConstants.yellowPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: ColorsConstants.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            padding: EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isEnabled ? onPressed : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isEnabled
                      ? ColorsConstants.yellowPrimary
                      : ColorsConstants.yellowPrimary.withOpacity(0.5),
                  disabledBackgroundColor:
                      ColorsConstants.yellowPrimary.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  text, 
                  style: TextStyle(
                    color: ColorsConstants.backgroundColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Roboto",
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  String _formatFullDate(DateTime date) {
    const weekdays = {
      1: 'Thứ Hai',
      2: 'Thứ Ba',
      3: 'Thứ Tư',
      4: 'Thứ Năm',
      5: 'Thứ Sáu',
      6: 'Thứ Bảy',
      7: 'Chủ Nhật',
    };
    final weekday = weekdays[date.weekday] ?? '';
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    return "$weekday, ${date.day} tháng $month năm $year";
  }

  String _buildServiceLabel() {
    if (selectedServices.isEmpty) return "Cắt tóc";
    return "Cắt tóc, ${selectedServices.join(', ')}";
  }
}