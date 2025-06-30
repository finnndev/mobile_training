import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hps_app/module/booking/constants/booking_constants.dart';
import 'package:hps_app/module/booking/presentation/providers/booking_state.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:hps_app/shared/utils/format.dart';
import 'package:provider/provider.dart';




class PaymentScreen extends StatelessWidget {
  final String selectedCreator;
  final DateTime? selectedDate;
  final String selectedTime;
  final List<String> selectedServices;

  const PaymentScreen({
    super.key,
    required this.selectedCreator,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedServices,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingState>(
      builder: (context, state, child) {
        return Scaffold(
          backgroundColor: ColorsConstants.secondsBackground,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: ColorsConstants.secondsBackground,
            elevation: 0,
            title: const Text(
              'Thông tin đặt lịch',
              style: TextStyle(
                color: ColorsConstants.text,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildBookingInfoCard(state),
                          const SizedBox(height: 24),
                          const Text(
                            "Chọn phương thức thanh toán",
                            style: TextStyle(
                              fontSize: 20,
                              color: ColorsConstants.text,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildPaymentMethodSelector(state),
                          const SizedBox(height: 6),
                          if (state.selectedPaymentIndex == 1) ...[
                            const Text(
                              "Chọn loại ví điện tử",
                              style: TextStyle(
                                color: ColorsConstants.text,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            _buildEWalletSelector(state),
                            const SizedBox(height: 24),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBookingInfoCard(BookingState state) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorsConstants.gray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Nhà tạo mẫu:',
                  style: const TextStyle(
                    color: ColorsConstants.text,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  state.selectedCreator,
                  style: const TextStyle(
                    color: ColorsConstants.yellowPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const Divider(color: ColorsConstants.mistGreen),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Thời gian:',
                  style: const TextStyle(
                    color: ColorsConstants.text,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${state.selectedTime}, ${formatFullDate(state.selectedDate!)}',
                  style: const TextStyle(
                    color: ColorsConstants.yellowPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const Divider(color: ColorsConstants.mistGreen),
          // Dịch vụ
          ...state.selectedServices.map((service) {
            final price = getServicePrice(service.label);
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    service.label,
                    style: const TextStyle(
                      color: ColorsConstants.text,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  formatCurrency(price) + ' VND',
                  style: const TextStyle(
                    color: ColorsConstants.yellowPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            );
          }).toList(),
          const Divider(color: ColorsConstants.mistGreen),
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Dùng mã giảm giá',
                    style: const TextStyle(
                      color: ColorsConstants.text,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '0',
                  style: const TextStyle(
                    color: ColorsConstants.yellowPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          const Divider(color: ColorsConstants.mistGreen),
         
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Tổng thanh toán',
                    style: const TextStyle(
                      color: ColorsConstants.text,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  formatCurrency(state.totalPrice) + ' VND',
                  style: const TextStyle(
                    color: ColorsConstants.yellowPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSelector(BookingState state) {
    return Column(
      children: List.generate(kPaymentMethods.length, (index) {
        final method = kPaymentMethods[index];
        final isSelected = state.selectedPaymentIndex == index;
        return GestureDetector(
          onTap: () => state.selectPaymentMethod(index),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? ColorsConstants.darkLeafGreen : ColorsConstants.gray,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? ColorsConstants.yellowPrimary : ColorsConstants.mistGreen,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (method.image.isNotEmpty)
                  Image.asset(
                    method.image,
                    height: 24,
                    width: 24,
                    color: isSelected ? ColorsConstants.yellowPrimary : null,
                  ),
                const SizedBox(width: 8),
                Text(
                  method.label,
                  style: TextStyle(
                    color: isSelected ? ColorsConstants.yellowPrimary : ColorsConstants.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildEWalletSelector(BookingState state) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorsConstants.darkLeafGreen,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorsConstants.customBackground, width: 1.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(kEWallets.length, (index) {
          final wallet = kEWallets[index];
          final isSelected = state.selectedEWalletIndex == index;
          return GestureDetector(
            onTap: () => state.selectEWallet(index),
            child: Container(
              width: 80,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: ColorsConstants.gray,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected ? ColorsConstants.yellowPrimary : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    wallet.image,
                    width: 32,
                    height: 32,
                    placeholderBuilder: (context) => const Icon(Icons.image, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    wallet.label,
                    style: const TextStyle(
                      color: ColorsConstants.text,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}