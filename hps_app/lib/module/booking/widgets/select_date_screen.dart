import 'package:flutter/material.dart';

class SelectDateScreen extends StatefulWidget {
  final String creatorName;
  final Function(String) onDateSelected; // Callback để truyền ngày
  final Function(String) onTimeSelected; // Callback để truyền giờ

  SelectDateScreen({
    required this.creatorName,
    required this.onDateSelected,
    required this.onTimeSelected,
  });

  @override
  _SelectDateScreenState createState() => _SelectDateScreenState();
}

class _SelectDateScreenState extends State<SelectDateScreen> {
  int? selectedDate;
  String? selectedTime;
  int currentMonth = 4;
  int currentYear = 2025;

  final List<int> dates = [15, 16, 17, 18, 19, 20, 21]; // Dữ liệu ngày
  final List<String> timeSlots = ["08:00", "08:30", "09:00"]; // Dữ liệu giờ

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),

          // **Mục chọn ngày**
          Text(
            "Chọn ngày", // Tiêu đề phần chọn ngày
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          // _buildMonthSelector(), // Có thể bổ sung để chọn tháng (đang bị ẩn)
          SizedBox(height: 15),
          _buildDateSelector(), // Chức năng chọn ngày (dựng giao diện cho việc chọn ngày)

          SizedBox(height: 20),

          // **Mục chọn giờ**
          Text(
            "Chọn khung giờ", // Tiêu đề phần chọn giờ
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          _buildTimeSelector(), // Chức năng chọn giờ (dựng giao diện cho việc chọn giờ)
        ],
      ),
    );
  }

  // **Phần chọn ngày**
  Widget _buildDateSelector() {
    return SizedBox(
      height: 95,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length, // Số lượng ngày cần hiển thị
        itemBuilder: (context, index) {
          bool isSelected =
              selectedDate == dates[index]; // Kiểm tra ngày được chọn
          String weekDay = _getWeekDay(dates[index]); // Lấy thứ của ngày

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = dates[index]; // Lưu ngày đã chọn
                widget.onDateSelected(
                  dates[index].toString(),
                ); // Gọi callback khi chọn ngày
              });
            },
            child: Container(
              width: 56,
              margin: EdgeInsets.symmetric(horizontal: 6),
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF1A3C30) : Color(0xFF345147),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? Color(0xFFF3AC40) : Colors.white,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${dates[index]}", // Hiển thị ngày
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 6),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    child: Text(
                      weekDay, // Hiển thị thứ của ngày
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // **Phần chọn giờ**
  Widget _buildTimeSelector() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: timeSlots.length, // Số lượng khung giờ cần hiển thị
        itemBuilder: (context, index) {
          bool isSelected =
              selectedTime == timeSlots[index]; // Kiểm tra giờ đã chọn

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTime = timeSlots[index]; // Lưu giờ đã chọn
                widget.onTimeSelected(
                  timeSlots[index],
                ); // Gọi callback khi chọn giờ
              });
            },
            child: Container(
              width: 80,
              margin: EdgeInsets.symmetric(horizontal: 6),
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF1A3C30) : Color(0xFF345147),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? Color(0xFFF3AC40) : Colors.white,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Center(
                child: Text(
                  timeSlots[index], // Hiển thị giờ
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Hàm lấy thứ của ngày (hiện tại trả về "Thứ 2", có thể mở rộng thêm)
  String _getWeekDay(int day) {
    return "Thứ 2";
  }
}
