import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String creatorName;
  final VoidCallback onPressed;
  final String text; // Thêm tham số `text` cho nút
  final String selectedDate;
  final String selectedTime;

  CustomButton({
    required this.creatorName,
    required this.onPressed,
    required this.text,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF012619),
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
                      color: Color(0xFFF3AC40),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Roboto",
                    ),
                  ),
                  Text(
                    "Cắt tóc",
                    style: TextStyle(
                      color: Color(0xFFF3AC40),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                    ),
                  ),
                ],
              )
              : SizedBox.shrink(),

          // Hiển thị thông tin ngày và giờ
          if (selectedDate.isNotEmpty && selectedTime.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_formatFullDate(selectedDate)}",
                  style: TextStyle(
                    color: Color(0xFFF3AC40),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "$selectedTime",
                  style: TextStyle(
                    color: Color(0xFFF3AC40),
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
              color: Color(0xFF012619),
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
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF3AC40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  text, // text đã được truyền vào
                  style: TextStyle(
                    color: Color(0xFF1A3C30),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // Hàm định dạng: Thứ, dd/MM/yyyy
  String _formatFullDate(String day) {
    try {
      final intDay = int.parse(day);
      final now = DateTime.now();
      final date = DateTime(now.year, now.month, intDay);

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
    } catch (_) {
      return day; // fallback nếu có lỗi
    }
  }
}
