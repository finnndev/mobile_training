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
      // height: 180,
      decoration: BoxDecoration(
        color: Color(0xFF012619),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                creatorName.isNotEmpty ? creatorName : "",
                style: TextStyle(
                  color: Color(0xFFF3AC40),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto",
                ),
              ),
              Text(
                "Cắt tóc",
                style: TextStyle(
                  color: Color(0xFFF3AC40),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto",
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          // Hiển thị thông tin ngày và giờ
          if (selectedDate.isNotEmpty && selectedTime.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ngày: $selectedDate",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "Giờ: $selectedTime",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
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
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
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
                  text, //  text đã được truyền vào
                  style: TextStyle(
                    color: Color(0xFF1A3C30),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
}
