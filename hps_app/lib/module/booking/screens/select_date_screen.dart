import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectDateScreen extends StatefulWidget {
  final String creatorName;
  final Function(DateTime) onDateSelected;
  final Function(String) onTimeSelected;

  const SelectDateScreen({
    super.key,
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
  int currentMonth = DateTime.now().month; 
  int currentYear = DateTime.now().year;  
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final List<String> timeSlots = ["08:00", "08:30", "09:00","09:30","10:00"]; 

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),

          
          Text(
            "Chọn ngày",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              color: ColorsConstants.text,
            ),
          ),
          SizedBox(height: 10),

        
          _buildCalendar(),

          SizedBox(height: 20),

         
          Text(
            "Chọn khung giờ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              color: ColorsConstants.text,
            ),
          ),
          SizedBox(height: 8),
          _buildTimeSelector(),
        ],
      ),
    );
  }

  
  Widget _buildCalendar() {
    return Container(
      decoration: BoxDecoration(
        color: ColorsConstants.gray,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorsConstants.grayLight, 
          width: 1.5,
        ),
      ),
      child: TableCalendar(
        firstDay: DateTime(currentYear - 1, currentMonth, 1),
        lastDay: DateTime(currentYear + 1, currentMonth, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        enabledDayPredicate: (day) {
          return !day.isBefore(DateTime.now().subtract(Duration(days: 1)));
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; 
            widget.onDateSelected(selectedDay); 
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            color: ColorsConstants.text,
            fontSize: 16,
            fontWeight: FontWeight.bold, 
          ),
          leftChevronIcon: SvgPicture.asset(
            'assets/svgs/left.svg',
            height: 24,
            width: 24,
          ),
          rightChevronIcon: SvgPicture.asset(
            'assets/svgs/right_while.svg',
            height: 24,
            width: 24,
          ),
        ),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            border: Border.all(color: ColorsConstants.yellowPrimary, width: 2),
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          defaultTextStyle: TextStyle(color: Colors.white),
          weekendTextStyle: TextStyle(color: Colors.white),
          holidayTextStyle: TextStyle(color: Colors.red),
          selectedTextStyle: TextStyle(color: ColorsConstants.yellowPrimary, fontWeight: FontWeight.bold),
          todayTextStyle: TextStyle(color: Colors.white, ),
          outsideTextStyle: TextStyle(color: ColorsConstants.grayLight),
          cellMargin: EdgeInsets.all(6), 
        
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          weekendStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }


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
              color: isSelected ? ColorsConstants.secondsBackground : ColorsConstants.gray,
              margin: EdgeInsets.symmetric(horizontal: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isSelected ? ColorsConstants.yellowPrimary : ColorsConstants.grayLight,
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
                        color: isSelected ? ColorsConstants.yellowPrimary : ColorsConstants.text,
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

  
}