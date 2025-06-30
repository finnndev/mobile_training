import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hps_app/module/booking/presentation/providers/booking_state.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import '../../constants/booking_constants.dart'; 
import '../../constants/asset_path.dart';


class SelectDateScreen extends StatefulWidget {
  final String creatorName;

  const SelectDateScreen({
    super.key,
    required this.creatorName,
  });

  @override
  _SelectDateScreenState createState() => _SelectDateScreenState();
}

class _SelectDateScreenState extends State<SelectDateScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
  
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingState>(
      builder: (context, state, child) {
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
              _buildCalendar(state),
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
              _buildTimeSelector(state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCalendar(BookingState state) {
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
          return isSameDay(state.selectedDate, day);
        },
        enabledDayPredicate: (day) {
          return !day.isBefore(DateTime.now().subtract(const Duration(days: 1)));
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() => _focusedDay = focusedDay);
          state.updateDate(selectedDay);
        },
        onPageChanged: (focusedDay) {
          setState(() => _focusedDay = focusedDay);
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
            AssetPath.left,
            height: 24,
            width: 24,
          ),
          rightChevronIcon: SvgPicture.asset(
            AssetPath.rightWhile,
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
            color: ColorsConstants.yellowPrimary,
            fontWeight: FontWeight.bold,
          ),
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

  Widget _buildTimeSelector(BookingState state) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: kTimeSlots.length,
        itemBuilder: (context, index) {
          final slot = kTimeSlots[index];
          final isSelected = state.selectedTime == slot;
          return GestureDetector(
            onTap: () {
              state.updateTime(slot);
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
}