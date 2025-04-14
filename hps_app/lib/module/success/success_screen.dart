import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../booking/booking_screen.dart';
import '../home/home_screen.dart';

class SuccessScreen extends StatelessWidget {
  const                     SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17362B),
      body: SafeArea(
        child: Column(
          children: [
            // Phần giữa màn hình: Hộp thông báo
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 163,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF345147),
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
                          "Thanh toán thành công!",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            color: Color(0xFFF3AC40),
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
                            color: Colors.white,
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
                        backgroundColor: const Color(0xFFF3AC40),
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
                      child: const Text(
                        "Đến mục Lịch đặt của tôi",
                        style: TextStyle(
                          color: Color(0xFF1A3C30),
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
                        color: Color(0xFFF3AC40),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,

                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 34),
          ],
        ),
      ),
    );
  }
}
