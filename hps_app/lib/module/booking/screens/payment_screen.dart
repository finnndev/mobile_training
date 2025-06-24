import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:hps_app/shared/utils/format.dart';

const List<Map<String, String>> kPaymentMethods = [
  {'label': 'Thanh toán tại salon', 'image': 'assets/images/ic_wallet.png'},
  {'label': 'Ví điện tử', 'image': 'assets/icons/ic_wallet_cards.png'},
];
const List<Map<String, String>> kEWallets = [
  {'label': 'VNPAY', 'image': 'assets/icons/ic_vnpay.svg'},
  {'label': 'Momo', 'image': 'assets/icons/ic_logo_momo.svg'},
  {'label': 'ZaloPay', 'image': 'assets/icons/ic_zalopay.svg'},
];
const Map<String, double> kServicePrices = {
  'Cắt tóc': 150000,
  'Gội đầu': 100000,
  'Uốn tóc': 300000,
  'Nhuộm tóc': 400000,
  'Ép tóc': 250000,
  'Tạo màu': 200000,
};

double _getServicePrice(String serviceLabel) => kServicePrices[serviceLabel] ?? 0.0;

class PaymentScreen extends StatefulWidget {
  final double totalPrice;
  final String selectedCreator;
  final DateTime? selectedDate;
  final String selectedTime;
  final List<String> selectedServices;

  const PaymentScreen({
    super.key,
    required this.totalPrice,
    required this.selectedCreator,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedServices,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPaymentIndex = 0;
  int _selectedEWalletIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                      _buildBookingInfoCard(),
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
                      _buildPaymentMethodSelector(),
                      const SizedBox(height: 6),
                      if (_selectedPaymentIndex == 1) ...[
                        const Text(
                          "Chọn loại ví điện tử",
                          style: TextStyle(
                            color: ColorsConstants.text,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        _buildEWalletSelector(),
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
  }

  Widget _buildBookingInfoCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorsConstants.gray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(
            label: 'Nhà tạo mẫu:',
            value: widget.selectedCreator,
          ),
          const Divider(color: ColorsConstants.mistGreen),
          _InfoRow(
            label: 'Thời gian:',
            value: '${widget.selectedTime}, ${formatFullDate(widget.selectedDate!)}',
          ),
          const Divider(color: ColorsConstants.mistGreen),
       
          
          ...widget.selectedServices.map((service) {
            final price = _getServicePrice(service);
            return _InfoRow(
              label: service,
              value: formatCurrency(price) + ' VND',
            );
          }).toList(),
          const Divider(color: ColorsConstants.mistGreen),
          const _InfoRow(label: 'Dùng mã giảm giá', value: '0'), 
          const Divider(color: ColorsConstants.mistGreen),
          _InfoRow(
            label: 'Tổng thanh toán',
            value: formatCurrency(widget.totalPrice) + ' VND',
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Column(
      children: List.generate(kPaymentMethods.length, (index) {
        final method = kPaymentMethods[index];
        final isSelected = _selectedPaymentIndex == index;
        return GestureDetector(
          onTap: () => setState(() => _selectedPaymentIndex = index),
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
                if (method['image'] != null)
                  Image.asset(
                    method['image']!,
                    height: 24,
                    width: 24,
                    color: isSelected ? ColorsConstants.yellowPrimary : null,
                  ),
                const SizedBox(width: 8),
                Text(
                  method['label']!,
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

  Widget _buildEWalletSelector() {
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
          final isSelected = _selectedEWalletIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedEWalletIndex = index),
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
                    wallet['image']!,
                    width: 32,
                    height: 32,
                    placeholderBuilder: (context) => const Icon(Icons.image, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    wallet['label']!,
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

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: ColorsConstants.text,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: ColorsConstants.yellowPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}