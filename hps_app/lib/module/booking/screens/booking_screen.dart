import 'package:flutter/material.dart';
import 'package:hps_app/module/qr/screens/qr_screen.dart';
import 'package:hps_app/module/success/screens/success_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/constants/colors.dart';
import 'payment_screen.dart';
import '../widgets/app_bar.dart';
import 'stylist_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/tab_bar.dart';
import 'select_date_screen.dart';
import 'hairdressing_screen.dart';
import '../services/stylist_service.dart';
import '../models/stylist_model.dart';
import '../services/date_time_service.dart';
import '../models/date_time_model.dart';
import '../services/hairdressing_service.dart';
import '../models/service_model.dart';

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
  String? username ;

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

  void _onContinuePressed() async {
    if (_selectedIndex == 0 && selectedCreator.isNotEmpty) {
    
      final stylist = Stylist(name: selectedCreator, image: '');
      await StylistService.saveSelectedStylist(stylist);
    }

    if (_selectedIndex == 1 && selectedDate != null && selectedTime.isNotEmpty) {
     
      final dateTime = DateTimeSelection(selectedDate: selectedDate, selectedTime: selectedTime);
      await DateTimeService.saveSelectedDateTime(dateTime);
    }

    if (_selectedIndex == 2 && _selectedServices.isNotEmpty) {
      
      await HairdressingService.saveSelectedServices(_selectedServices);
    }

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
        if (_selectedServices.isEmpty) {
          return;
        }
        setState(() => _selectedIndex = 3);
        break;

      case 3:
        setState(() => _selectedIndex = 4); 
        break;

      case 4:
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

  double get _totalPrice => _selectedServices.fold(0.0, (sum, item) => sum + item.price);

  Future<void> _loadAllData() async {
    final stylist = await StylistService.getSelectedStylist();
    final dateTime = await DateTimeService.getSelectedDateTime();
    final services = await HairdressingService.getSelectedServices();
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedCreator = stylist?.name ?? "";
      selectedDate = dateTime?.selectedDate;
      selectedTime = dateTime?.selectedTime ?? "";
      _selectedServices = services ?? [];
      username = prefs.getString('username') ?? 'Khách';
    });
  }

  @override
  void initState() {
    super.initState();
    _clearBookingData();
    _loadAllData();
  }

  Future<void> _clearBookingData() async {
    await StylistService.clearSelectedStylist();
    await DateTimeService.clearSelectedDateTime();
    await HairdressingService.clearSelectedServices();
    setState(() {
      selectedCreator = "";
      selectedDate = null;
      selectedTime = "";
      _selectedServices = [];
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: ColorsConstants.secondsBackground,
      appBar: CustomAppBar(
        onBack: _onBackPressed,
        onNext: _onNextPressed,
        showCancelDialog: _selectedIndex == 0, 
      ),
      body: Column(
        children: [
          TabBarBooking(currentIndex: _selectedIndex, onTap: _onItemTapped),
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
                    return HaidressingScreen(
                      selectedDate: selectedDate,
                      selectedTime: selectedTime,
                      selectedStylist: selectedCreator,
                      onServicesChanged: (selected) => setState(() => _selectedServices = selected),
                    );
                  case 3:
                    return PaymentScreen(
                      totalPrice: _totalPrice,
                      selectedCreator: selectedCreator,
                      selectedDate: selectedDate,
                      selectedTime: selectedTime,
                      selectedServices: _selectedServices.map((e) => e.label).toList(),
                    );
                  case 4:
                    return QrScreen(
                      totalPrice: _totalPrice,
                      customerName: username ?? 'Khách',
                      paymentTime: DateTime.now(),
                    );
                  case 5:
                    return const SuccessScreen();
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
          if (_selectedIndex != 3 && _selectedIndex != 4)
            CustomButton(
              creatorName: selectedCreator,
              onPressed: _onContinuePressed,
              text: "Tiếp tục",
              selectedDate: selectedDate,
              selectedTime: selectedTime,
              selectedServices: _selectedServices.map((e) => e.label).toList(),
              currentStep: _selectedIndex,
            )
          else if (_selectedIndex == 3)
            CustomButton(
              creatorName: selectedCreator,
              onPressed: _onContinuePressed,
              text: "Hoàn tất",
              selectedDate: selectedDate,
              selectedTime: selectedTime,
              selectedServices: _selectedServices.map((e) => e.label).toList(),
              currentStep: _selectedIndex,
              totalPrice: _totalPrice,
            ),
        ],
      ),
    );
  }
}


