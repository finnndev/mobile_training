import 'package:flutter/material.dart';
import 'package:hps_app/module/success/screens/success_screen.dart';
import '../../../shared/constants/colors.dart';
import 'payment_screen.dart';
import '../widgets/app_bar.dart';
import 'stylist_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/tab_bar.dart';
import 'select_date_screen.dart';
import 'service_screen.dart';


class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}


class _BookingScreenState extends State<BookingScreen> {
  String selectedCreator = "";
  int _selectedIndex = 0;
  bool isSelectingDate = false;
  bool isPayment = false;
  DateTime? selectedDate;
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

  
  void _onDateSelected(DateTime date) {
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
          
          return;
        }
        setState(() => _selectedIndex = 1);
        break;

      case 1:
        if (selectedDate == null || selectedTime.isEmpty) {
          
          return;
        }
        setState(() => _selectedIndex = 2);
        break;

      case 2:
       
        setState(() => _selectedIndex = 3);
        break;

      case 3:
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
      backgroundColor: ColorsConstants.secondsBackground,
      appBar: CustomAppBar(
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
                    return StylistSelector(onCreatorSelected: _onCreatorSelected);
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
                        style: TextStyle(color: ColorsConstants.grayLight),
                      ),
                    );
                }
              },
            ),
          ),
         
        if (_selectedIndex != 3 && _selectedIndex != 5)
          CustomButton(
            creatorName: selectedCreator,
            onPressed: _onContinuePressed,
            text: "Tiếp tục", 
            selectedDate: selectedDate,
            selectedTime: selectedTime,
            selectedServices: _selectedServices.map((e) => e.label).toList(),
            currentStep: _selectedIndex,
          ),
       
      ],
    ),
  );
}

 
  

}