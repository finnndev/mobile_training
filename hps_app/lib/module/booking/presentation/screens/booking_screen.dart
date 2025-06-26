import 'package:flutter/material.dart';
import 'package:hps_app/module/booking/presentation/providers/booking_state.dart';
import 'package:provider/provider.dart';
import 'package:hps_app/module/qr/screens/qr_screen.dart';
import 'package:hps_app/module/success/screens/success_screen.dart';

import 'package:hps_app/shared/constants/colors.dart';
import 'payment_screen.dart';
import 'stylist_screen.dart';
import 'select_date_screen.dart';
import 'hairdressing_screen.dart';

import '../widgets/app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/tab_bar.dart';


class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingState>(context, listen: false).loadInitialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<BookingState>(context);

    return Scaffold(
      backgroundColor: ColorsConstants.secondsBackground,
      appBar: AppBarWidget(
        onBack: () => state.goBack(context),
        onNext: state.continueBooking,
        showCancelDialog: state.selectedIndex == 0,
      ),
      body: Column(
        children: [
          TabBarBooking(currentIndex: state.selectedIndex, onTap: state.onTabTapped),
          Expanded(
            child: Builder(
              builder: (_) {
                switch (state.selectedIndex) {
                  case 0:
  return StylistSelector();
                 case 1:
  return SelectDateScreen(
    creatorName: state.selectedCreator,
  );
                  case 2:
  return HaidressingScreen(
    selectedDate: state.selectedDate,
    selectedTime: state.selectedTime,
    selectedStylist: state.selectedCreator,
  );
                  case 3:
  return PaymentScreen(
    selectedCreator: state.selectedCreator,
    selectedDate: state.selectedDate,
    selectedTime: state.selectedTime,
    selectedServices: state.selectedServices.map((e) => e.label).toList(),
  );
                  case 4:
                    return QrScreen(
                      totalPrice: state.totalPrice,
                      customerName: state.username ?? 'Khách',
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
          if (state.selectedIndex == 3)
            CustomButton(
              creatorName: state.selectedCreator,
              onPressed: state.continueBooking,
              text: "Hoàn tất",
              selectedDate: state.selectedDate,
              selectedTime: state.selectedTime,
              selectedServices: state.selectedServices.map((e) => e.label).toList(),
              currentStep: state.selectedIndex,
              totalPrice: state.totalPrice,
            )
          else if (state.selectedIndex != 4 && state.selectedIndex != 5)
            CustomButton(
              creatorName: state.selectedCreator,
              onPressed: state.continueBooking,
              text: "Tiếp tục",
              selectedDate: state.selectedDate,
              selectedTime: state.selectedTime,
              selectedServices: state.selectedServices.map((e) => e.label).toList(),
              currentStep: state.selectedIndex,
            ),
        ],
      ),
    );
  }
}

