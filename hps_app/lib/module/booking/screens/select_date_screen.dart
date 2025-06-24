import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:table_calendar/table_calendar.dart';
import '../services/date_time_service.dart';
import '../models/date_time_model.dart';

final List<String> kTimeSlots = ["08:00", "08:30", "09:00", "09:30", "10:00"];

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
  DateTime? _selectedDay;
  String? _selectedTime;
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadSelectedDateTime();
  }

  Future<void> _loadSelectedDateTime() async {
    final dateTime = await DateTimeService.getSelectedDateTime();
    setState(() {
      _selectedDay = dateTime?.selectedDate;
      _selectedTime = dateTime?.selectedTime;
      if (_selectedDay != null) widget.onDateSelected(_selectedDay!);
      if (_selectedTime != null) widget.onTimeSelected(_selectedTime!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Text(
            "Chọn ngày",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              color: ColorsConstants.text,
            ),
          ),
          const SizedBox(height: 10),
          _buildCalendar(),
          const SizedBox(height: 20),
          Text(
            "Chọn khung giờ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              color: ColorsConstants.text,
            ),
          ),
          const SizedBox(height: 8),
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
        firstDay: DateTime(DateTime.now().year - 1, DateTime.now().month, 1),
        lastDay: DateTime(DateTime.now().year + 1, DateTime.now().month, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        enabledDayPredicate: (day) {
          return !day.isBefore(DateTime.now().subtract(const Duration(days: 1)));
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          widget.onDateSelected(selectedDay);
          _saveSelectedDateTime();
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: const TextStyle(
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
          todayDecoration: const BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            border: Border.all(color: ColorsConstants.yellowPrimary, width: 2),
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          defaultTextStyle: const TextStyle(color: Colors.white),
          weekendTextStyle: const TextStyle(color: Colors.white),
          holidayTextStyle: const TextStyle(color: Colors.red),
          selectedTextStyle: const TextStyle(
              color: ColorsConstants.yellowPrimary, fontWeight: FontWeight.bold),
          todayTextStyle: const TextStyle(color: Colors.white),
          outsideTextStyle: const TextStyle(color: ColorsConstants.grayLight),
          cellMargin: const EdgeInsets.all(6),
        ),
        daysOfWeekStyle: const DaysOfWeekStyle(
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
        itemCount: kTimeSlots.length,
        itemBuilder: (context, index) {
          final slot = kTimeSlots[index];
          final isSelected = _selectedTime == slot;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTime = slot;
              });
              widget.onTimeSelected(slot); 
              _saveSelectedDateTime();
            },
            child: Card(
              color: isSelected ? ColorsConstants.secondsBackground : ColorsConstants.gray,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isSelected ? ColorsConstants.yellowPrimary : ColorsConstants.grayLight,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SizedBox(
                  height: 48,
                  width: 104,
                  child: Center(
                    child: Text(
                      slot,
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

  Future<void> _saveSelectedDateTime() async {
    final dateTime = DateTimeSelection(
      selectedDate: _selectedDay,
      selectedTime: _selectedTime,
    );
    await DateTimeService.saveSelectedDateTime(dateTime);
  }
}