import 'package:flutter/material.dart';
import 'widgets/app_bar.dart';
import 'widgets/item_bar.dart';
import 'widgets/custom_button.dart';
import 'widgets/tab_bar.dart';
import 'widgets/select_date_screen.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String selectedCreator = "";
  int _selectedIndex = 0;
  bool isSelectingDate = false;
  String selectedDate = "";
  String selectedTime = "";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onCreatorSelected(String name) {
    setState(() {
      selectedCreator = name;
    });
  }

  void _onContinuePressed() {
    setState(() {
      if (_selectedIndex < 4)
        _selectedIndex++; // Khi nhấn "Tiếp tục", tô vàng thêm 1 tab
      if (!isSelectingDate) {
        isSelectingDate = true;
      } else {
        print("Chuyển tiếp đến bước tiếp theo...");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A3C30),
      appBar: buildAppBar(context),
      body: Column(
        children: [
          TabBarr(currentIndex: _selectedIndex, onTap: _onItemTapped),
          Expanded(
            child:
                isSelectingDate
                    ? SelectDateScreen(
                      creatorName: selectedCreator,
                      onDateSelected: (date) {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                      onTimeSelected: (time) {
                        setState(() {
                          selectedTime = time;
                        });
                      },
                    )
                    : ItemBar(onCreatorSelected: _onCreatorSelected),
          ),
          CustomButton(
            creatorName: selectedCreator,
            onPressed: _onContinuePressed,
            text: "Tiếp tục",
            selectedDate: selectedDate,
            selectedTime: selectedTime,
          ),
        ],
      ),
    );
  }
}
