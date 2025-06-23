import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../booking/screens/booking_screen.dart';
import '../../home/screens/home_screen.dart';
import 'package:hps_app/shared/constants/colors.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.darkLeafGreen, 
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 163,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ColorsConstants.gray, 
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svgs/tick.svg",
                          width: 56,
                          height: 56,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Đặt lịch thành công!",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            color: ColorsConstants.yellowPrimary, 
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Chúc mừng bạn đã đặt lịch sử dụng dịch vụ với Tran Manh HPS thành công. Rất vui lòng được phục vụ bạn.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 1.33,
                            fontFamily: "Roboto",
                            color: ColorsConstants.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Phần dưới cùng: 2 nút điều hướng
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsConstants.yellowPrimary, // Thay #F3AC40 bằng ColorsConstants.yellowPrimary
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Đến mục Lịch đặt của tôi",
                        style: TextStyle(
                          color: ColorsConstants.backgroundColor, 
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: const Text(
                      "Về trang chủ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorsConstants.yellowPrimary, 
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}