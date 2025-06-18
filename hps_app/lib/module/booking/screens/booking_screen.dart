import 'package:flutter/material.dart';
import 'package:hps_app/module/qr/screens/qr_screen.dart';
import 'package:hps_app/module/success/screens/success_screen.dart';
import '../../../shared/constants/colors.dart';
import '../../payment/screens/bookingpayment_screen.dart';
import '../widgets/app_bar.dart';
import '../widgets/item_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/tab_bar.dart';
import 'select_date_screen.dart';
import 'service_screen.dart';

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
  List<ServiceItem> _selectedServices = [];

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
    switch (_selectedIndex) {
      case 0:
        if (selectedCreator.isEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Vui lòng chọn stylist")));
          return;
        }
        setState(() => _selectedIndex = 1);
        break;

      case 1:
        if (selectedDate.isEmpty || selectedTime.isEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Vui lòng chọn ngày và giờ")));
          return;
        }
        setState(() => _selectedIndex = 2);
        break;

      case 2:
        // Xác nhận hoàn tất lựa chọn trước khi thanh toán
        // if (selectedCreator.isEmpty || selectedDate.isEmpty || selectedTime.isEmpty) {
        //   print("Thiếu thông tin để tiếp tục");
        //   return;
        // }
        setState(() => _selectedIndex = 3);
        break;

      case 3:
        // Thanh toán thành công, chuyển sang màn hình hoàn tất
        setState(() => _selectedIndex = 5);
        break;

      default:
        break;
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
                switch (_selectedIndex) {
                  case 0:
                    return ItemBar(onCreatorSelected: _onCreatorSelected);
                  case 1:
                    return SelectDateScreen(
                      creatorName: selectedCreator,
                      onDateSelected: _onDateSelected,
                      onTimeSelected: _onTimeSelected,
                    );
                  case 2:
                    return ServiceScreen(
                      selectedDate: selectedDate,
                      selectedTime: selectedTime,
                      selectedStylist: selectedCreator,
                      onServicesChanged: (List<ServiceItem> selected) {
                        setState(() {
                          _selectedServices = selected;
                        });
                      },
                    );
                  case 3:
                    return BookingpaymentScreen();
                  case 5:
                    return SuccessScreen();
                  default:
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
          (_selectedIndex == 3)
              ? _buildBottomBar(context)
              : CustomButton(
                creatorName: selectedCreator,
                onPressed: _onContinuePressed,
                text: "Tiếp tục",
                selectedDate: selectedDate,
                selectedTime: selectedTime,
                selectedServices:
                    _selectedServices.map((e) => e.label).toList(),
              ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFF0D2C24),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng thanh toán:',
                  style: TextStyle(
                    color: ColorsConstants.honeyGold,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '250.000 VND',
                  style: TextStyle(
                    color: ColorsConstants.honeyGold,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsConstants.honeyGold,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QrScreen()),
                  );
                },

                child: const Text(
                  'Tạo mã thanh toán',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
