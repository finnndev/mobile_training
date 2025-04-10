import 'package:flutter/material.dart';
import 'package:hps_app/module/login/login_screen.dart';
import 'package:hps_app/module/qr/qr_screen.dart';
import '../payment/bookingpayment_screen.dart';
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

  void _onContinuePressed() {
    setState(() {
      if (_selectedIndex < 4) {
        _selectedIndex++; // Khi nhấn "Tiếp tục", tăng chỉ số tab
      }

      // Nếu chưa chọn ngày, chuyển sang chế độ chọn ngày
      if (!isSelectingDate) {
        isSelectingDate = true;
      } else if (_selectedIndex == 3) {
        isPayment = true; // Nếu đang ở bước 3, chuyển đến bước thanh toán
      } else {
        print("Chuyển tiếp đến bước tiếp theo...");
      }
    });
  }

  void _onBackPressed() {
    setState(() {
      if (_selectedIndex > 0) {
        _selectedIndex--; // Giảm chỉ số tab khi nhấn "Quay lại"
      }

      // Quay lại trạng thái trước
      if (isPayment) {
        isPayment =
            false; // Nếu đang ở bước thanh toán, quay lại thì tắt trạng thái thanh toán
      } else if (isSelectingDate) {
        isSelectingDate =
            false; // Nếu đang chọn ngày, quay lại thì tắt trạng thái chọn ngày
      } else {
        print("Quay lại bước trước...");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A3C30),
      appBar: buildAppBar(
        context,
        onPre: () {
          Navigator.pop(
            context,
            MaterialPageRoute(builder: (context) => BookingScreen()),
          );
        },
        onNext: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QrScreen()),
          );
        },
      ),
      body: Column(
        children: [
          TabBarr(currentIndex: _selectedIndex, onTap: _onItemTapped),
          Expanded(
            child:
                isPayment
                    ? BookingpaymentScreen()
                    : isSelectingDate
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
