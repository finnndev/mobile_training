import 'package:flutter/material.dart';
import 'package:hps_app/module/qr/qr_screen.dart';
import 'package:hps_app/shared/constants/colors.dart';

class BookingpaymentScreen extends StatelessWidget {
  const BookingpaymentScreen({super.key});

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
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // _buildProgressBar(),
                // const SizedBox(height: 16),
                _buildBookingInfoCard(),
                const SizedBox(height: 24),
                const Text(
                  "Chọn phương thức thanh toán",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                _buildPaymentMethodSelector(),
                SizedBox(height: 6),
                Text(
                  "Chọn loại ví điện tử",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                _buildEWalletSelector(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }
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
      children: const [
        _InfoRow(label: 'Nhà tạo mẫu:', value: 'Tran Manh'),
        Divider(color: ColorsConstants.mistGreen),
        _InfoRow(label: 'Thời gian:', value: '08:30,Thứ Bảy,17 Tháng 12, 2022'),
        Divider(color: ColorsConstants.mistGreen),

        SizedBox(height: 8),
        Text(
          'Dịch vụ:',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12, top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('- Cắt tóc', style: TextStyle(color: Colors.white70)),
                  Text('150.000 VND', style: TextStyle(color: Colors.white70)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('- Gội đầu', style: TextStyle(color: Colors.white70)),
                  Text('100.000 VND', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Divider(color: ColorsConstants.mistGreen),

        _InfoRow(label: 'Dùng mã giảm giá', value: '0'),
        Divider(color: ColorsConstants.mistGreen),
        _InfoRow(value: '250.000 VND', label: 'Tổng thanh toán'),
      ],
    ),
  );
}

Widget _buildPaymentMethodSelector() {
  return Row(
    children: [
      _PaymentOption(
        label: 'Ví điện tử',
        selected: true,
        imageUrl: 'assets/icons/ic_wallet_cards.png',
      ),
      _PaymentOption(
        label: 'Thẻ tín dụng',
        selected: false,
        imageUrl: 'assets/icons/ic_credit_card.png',
      ),
      _PaymentOption(
        imageUrl: 'assets/images/ic_wallet.png',
        label: 'Thẻ ghi nợ',
        selected: false,
      ),
    ],
  );
}

Widget _buildEWalletSelector() {
  return Container(
    margin: const EdgeInsets.only(top: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: ColorsConstants.darkLeafGreen, //
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: ColorsConstants.honeyGold, width: 1.2),
    ),
    child: Row(
      children: [
        Image.asset('assets/icons/ic_logo_momo.png', width: 24, height: 24),
        const SizedBox(width: 10),

        const Text(
          'Ví Momo',
          style: TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const Spacer(),

        // Radio selected
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.orange, width: 2),
          ),
          child: Center(
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange,
              ),
            ),
          ),
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => QrScreen()),
                // );
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

class _PaymentOption extends StatelessWidget {
  final IconData? icon;
  final String label;
  final bool selected;
  final String? imageUrl;

  const _PaymentOption({
    this.icon,
    required this.label,
    required this.selected,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 130,
        width: 110,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color:
              selected ? ColorsConstants.darkLeafGreen : ColorsConstants.gray,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? ColorsConstants.honeyGold : Color(0xFF677D75),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageUrl?.isNotEmpty ?? false)
              Image.asset(
                imageUrl ?? '',
                fit: BoxFit.cover,
                height: 24,
                width: 24,
                color: selected ? ColorsConstants.honeyGold : null,
              ),

            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: selected ? ColorsConstants.honeyGold : Colors.white,
              ),
            ),
          ],
        ),
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
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
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
      ),
    );
  }
}
