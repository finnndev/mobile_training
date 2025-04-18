import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hps_app/module/qr_payment/qr_payment_screen.dart';
import 'package:hps_app/shared/constants/colors.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  ColorsConstants.secondsBackground,
      appBar: AppBar(
        backgroundColor: ColorsConstants.secondsBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Đặt lịch cắt tóc',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                final isCurrentStep = index == 4;
                return Expanded(
                  child: Container(
                    height: 2,
                    width: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color:
                          isCurrentStep
                              ? ColorsConstants.yellowPrimary
                              : ColorsConstants.yellowPrimary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 32),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: ColorsConstants.gray,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Quét mã để thanh toán',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Roboto",
                          ),
                        ),

                        const SizedBox(height: 16),

                        Container(
                          width: 208,
                          height: 208,
                          color: Colors.white,
                          child: Image.asset('assets/images/qr.png'),
                        ),

                        const SizedBox(height: 16),

                        const Text(
                          '04:59',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '1. Một mã QR chỉ được sử dụng cho một giao dịch duy nhất.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '2. Không được sửa đổi số tiền và nội dung chuyển khoản.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '3. Lưu lại biên lai giao dịch để đối chiếu khi cần thiết.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  _paymentInfo(),
                  const SizedBox(height: 20),

                  _solvePaymentButton(context),
                  
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ColorsConstants.gray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'Thông tin thanh toán',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: "Roboto",
            ),
          ),

          const SizedBox(height: 16),

          _buildPayment('Tên tài khoản hưởng thụ:', 'TRAN LE MANH'),
          const SizedBox(height: 12),
          const Divider(color: Color(0xff677D75), height: 1 ),
          const SizedBox(height: 12),

          _buildPayment('Số tài khoản thụ hưởng:', '0806 080 688'),
          const SizedBox(height: 12),
          const Divider(color: Color(0xff677D75), height: 1),
          const SizedBox(height: 12),

          _buildPayment('Số tiền thanh toán:', '250.000 VND'),
          const SizedBox(height: 12),
          const Divider(color: Color(0xff677D75), height: 1),
          const SizedBox(height: 12),

          _buildPayment('Nội dung thanh toán:', 'Nghĩa Lê thanh toán'),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _solvePaymentButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsConstants.yellowPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Qr_Payment_Screen()),
                );
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Thanh toán thành công')));
              },
              icon: Icon(Icons.payment),
              label: const Text(
                'Thanh toán',
                style: TextStyle(color: Colors.black),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.black),
            height: 40,
            width: 1,
          ),
          Expanded(
            child: TextButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Đã tải mã QR')));
              },
              icon: Icon(Icons.file_download_outlined,size: 25,),
              label: const Text(
                'Tải mã QR',
                style: TextStyle(color: Colors.black),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildPayment(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}
