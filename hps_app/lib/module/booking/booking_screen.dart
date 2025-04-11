import 'package:flutter/material.dart';
import 'package:hps_app/module/qr/qr_screen.dart';
import 'package:hps_app/module/success/success_screen.dart';
import '../payment/bookingpayment_screen.dart';
import 'widgets/app_bar.dart';
import 'widgets/item_bar.dart';
import 'widgets/custom_button.dart';
import 'widgets/tab_bar.dart';
import 'widgets/select_date_screen.dart';
import 'widgets/service_screen.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String selectedCreator = "";
  int _selectedIndex = 0;
  bool isSelectingDate = false;
  bool isPayment = false;
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

  void _onDateSelected(String date) {
    setState(() {
      selectedDate = date;
    });
  }

  void _onTimeSelected(String time) {
    setState(() {
      selectedTime = time;
    });
  }

  void _onContinuePressed() {
    if (_selectedIndex == 0) {
      if (selectedCreator.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Vui lòng chọn stylist")));
        return;
      }
      setState(() {
        _selectedIndex = 1;
      });
    } else if (_selectedIndex == 1) {
      if (selectedDate.isEmpty || selectedTime.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Vui lòng chọn ngày và giờ")));
        return;
      }
      setState(() {
        _selectedIndex = 2;
      });
    } else if (_selectedIndex == 2) {
      print("Hoàn tất đặt lịch:");
      print("Stylist: $selectedCreator");
      print("Date: $selectedDate");
      print("Time: $selectedTime");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SuccessScreen()),
      );
    }
  }

  void _onNextPressed() {
    _onContinuePressed();
  }

  void _onBackPressed() {
    setState(() {
      if (_selectedIndex > 0) {
        _selectedIndex--;
      } else {
        Navigator.pop(context);
      }

      if (isPayment) {
        isPayment = false;
      } else if (isSelectingDate) {
        isSelectingDate = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A3C30),
      appBar: buildAppBar(
        context,

        onBack: _onBackPressed,
        onNext: _onNextPressed,
      ),
      body: Column(
        children: [
          TabBarr(currentIndex: _selectedIndex, onTap: _onItemTapped),
          Expanded(
            child: Builder(
              builder: (_) {
                if (isPayment) {
                  return BookingpaymentScreen();
                } else if (_selectedIndex == 0) {
                  return ItemBar(onCreatorSelected: _onCreatorSelected);
                } else if (_selectedIndex == 1) {
                  return SelectDateScreen(
                    creatorName: selectedCreator,
                    onDateSelected: _onDateSelected,
                    onTimeSelected: _onTimeSelected,
                  );
                } else if (_selectedIndex == 2) {
                  return ServiceScreen(
                    selectedDate: selectedDate,
                    selectedTime: selectedTime,
                    selectedStylist: selectedCreator,
                  );
                } else if (_selectedIndex == 3) {
                  return SuccessScreen();
                } else {
                  return Center(
                    child: Text(
                      "Không có nội dung",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              },
            ),
          ),
          if (_selectedIndex != 3)
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
