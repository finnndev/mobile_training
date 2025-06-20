import 'package:flutter/material.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:hps_app/shared/utils/format.dart';


class CustomButton extends StatefulWidget {
  final String creatorName;
  final VoidCallback onPressed;
  final String text;
  final DateTime? selectedDate;
  final String selectedTime;
  final List<String> selectedServices;
  final int currentStep;
  final double? totalPrice;

  const CustomButton({
    super.key,
    required this.creatorName,
    required this.onPressed,
    required this.text,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedServices,
    required this.currentStep,
    this.totalPrice,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool get _isEnabled {
    switch (widget.currentStep) {
      case 0:
        return widget.creatorName.isNotEmpty;
      case 1:
        return widget.selectedDate != null && widget.selectedTime.isNotEmpty;
      case 2:
        return widget.selectedServices.isNotEmpty;
      case 3:
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
          
          if (widget.currentStep == 3 && widget.totalPrice != null) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 2,top : 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng thanh toán:',
                    style: TextStyle(
                      color: ColorsConstants.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    formatCurrency(widget.totalPrice!) + ' VND',
                    style: TextStyle(
                      color: ColorsConstants.yellowPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ]
          else ...[
            widget.creatorName.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.creatorName,
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

            if (widget.selectedDate != null && widget.selectedTime.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatFullDate(widget.selectedDate!),
                    style: TextStyle(
                      color: ColorsConstants.yellowPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    widget.selectedTime,
                    style: TextStyle(
                      color: ColorsConstants.yellowPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
            if (widget.totalPrice != null)
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng thanh toán:',
                      style: TextStyle(
                        color: ColorsConstants.text,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      formatCurrency(widget.totalPrice!) + ' VND',
                      style: TextStyle(
                        color: ColorsConstants.yellowPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
                onPressed: _isEnabled ? widget.onPressed : null,
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
                  widget.text,
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
    return widget.selectedServices.join(', ');
  }
}