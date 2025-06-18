import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            "Chọn ngày",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Bên trái: Tháng/Năm
              Text(
                "Tháng $currentMonth, $currentYear",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              // Bên phải: Hai nút SVG điều hướng
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (currentMonth == 1) {
                          currentMonth = 12;
                          currentYear -= 1;
                        } else {
                          currentMonth -= 1;
                        }
                      });
                    },
                    child: SvgPicture.asset(
                      'assets/svgs/left.svg',
                      height: 24,
                      width: 24,
                    ),
                  ),
                  SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (currentMonth == 12) {
                          currentMonth = 1;
                          currentYear += 1;
                        } else {
                          currentMonth += 1;
                        }
                      });
                    },
                    child: SvgPicture.asset(
                      'assets/svgs/right_while.svg',
                      height: 24,
                      width: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 15),
          _buildDateSelector(),

          SizedBox(height: 20),

          // **Mục chọn giờ**
          Text(
            "Chọn khung giờ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          _buildTimeSelector(),
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
        itemCount: dates.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedDate == dates[index];
          String weekDay = _getWeekDay(dates[index]);

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = dates[index];
                widget.onDateSelected(dates[index].toString());
              });
            },

            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 6),
              color: isSelected ? Color(0xFF1A3C30) : Color(0xFF345147),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isSelected ? Color(0xFFF3AC40) : Color(0xFF677D75),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: SizedBox(
                  width: 56,
                  height: 95,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${dates[index]}",
                        style: TextStyle(
                          color: isSelected ? Color(0xFFF3AC40) : Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 6,
                        ),
                        child: Text(
                          weekDay,
                          style: TextStyle(
                            color:
                                isSelected ? Color(0xFFF3AC40) : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedTime == timeSlots[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTime = timeSlots[index];
                widget.onTimeSelected(timeSlots[index]);
              });
            },
            child: Card(
              color: isSelected ? Color(0xFF1A3C30) : Color(0xFF345147),
              margin: EdgeInsets.symmetric(horizontal: 6),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isSelected ? Color(0xFFF3AC40) : Color(0xFF677D75),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: SizedBox(
                  height: 48,
                  width: 104,
                  child: Center(
                    child: Text(
                      timeSlots[index],
                      style: TextStyle(
                        color: isSelected ? Color(0xFFF3AC40) : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Hàm trả về thứ tiếng Việt từ ngày
  String _getWeekDay(int day) {
    DateTime date = DateTime(currentYear, currentMonth, day);
    int weekday = date.weekday;

    const weekdays = {
      1: 'Hai',
      2: 'Ba',
      3: 'Tư',
      4: 'Năm',
      5: 'Sáu',
      6: 'Bảy',
      7: 'CN',
    };

    return weekdays[weekday] ?? '';
  }
}
