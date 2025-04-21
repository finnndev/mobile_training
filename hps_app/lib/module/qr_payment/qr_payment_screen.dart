import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hps_app/module/bookingSchedule/bookingSchedule_screen.dart';
import 'package:hps_app/module/home/home_screen.dart';
import 'package:hps_app/shared/constants/colors.dart';

class Qr_Payment_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.secondsBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 292,),

            _successful_payment(context),

            SizedBox(height: 176,),

            _scheduling_item(context),
            SizedBox(height: 8,),

            _backtohome(context),
          ],
        ),
      ),
    );
  }

  Widget _backtohome(BuildContext context){
    return TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: const Text(
                'Về trang chủ',
                style: TextStyle(
                  color: Color(0xffF3AC40),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
  }
  Widget _scheduling_item(BuildContext context){
    return Container(
              width: 362,
              height: 56,
              child: ElevatedButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingScheduleScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffF3AC40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Đến mục lịch đặt của tôi',
                style: TextStyle(
                  color: Color(0xff1A3C30),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )),
            );
  }

  Widget _successful_payment(BuildContext context) {
    return Container(
              width: 364,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: ColorsConstants.gray,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/svgs/aaccumulator.svg', 
                      width: 56, 
                      height: 56,
                    ),
                  ),
                  SizedBox(height: 16,),
                  Text(
                    'Thanh toán thành công!',
                    style: TextStyle(
                        color: Color(0xffF3AC40),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8,),
                  Text(
                    'Chúc mừng bạn đã đặt lịch sử dụng dịch vụ tại Tran Manh HPS thành công. Rất vui lòng được phục vụ bạn.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
  }
}