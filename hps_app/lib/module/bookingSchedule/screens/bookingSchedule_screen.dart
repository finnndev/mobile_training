import 'package:flutter/material.dart';
import 'package:hps_app/shared/constants/colors.dart'; 

class BookingScheduleScreen extends StatelessWidget {
  const BookingScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorsConstants.secondsBackground,
        appBar: AppBar(
          backgroundColor: ColorsConstants.secondsBackground,
          elevation: 0,
          leading: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          title: const Text(
            'Lịch đặt của tôi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: ColorsConstants.yellowPrimary,
            unselectedLabelColor: ColorsConstants.gray,
            indicatorColor: ColorsConstants.yellowPrimary,
            indicatorWeight: 3.0,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            tabs: [Tab(text: 'Sắp tới'), Tab(text: 'Lịch sử')],
          ),
        ),
        body: TabBarView(
          children: [
            _buildBookingList(
              items: const [
                BookingItem(
                  time: '08:03 SA',
                  date: 'Thứ Bảy, 17 Tháng 12, 2022',
                  stylist: 'Tran Manh',
                  service: 'Cắt tóc, gội đầu',
                  price: '250,000 VND',
                  status: 'Hủy',
                ),
              ],
            ),
            _buildBookingList(
              items: const [
                BookingItem(
                  time: '17:00 CH',
                  date: 'Thứ Bảy, 08 Tháng 10, 2022',
                  stylist: 'Tran Manh',
                  service: 'Cắt tóc, nhuộm tóc',
                  price: '500,000 VND',
                  status: 'Đánh giá',
                ),
                BookingItem(
                  time: '14:30 CH',
                  date: 'Thứ Bảy, 08 Tháng 10, 2022',
                  stylist: 'Jun Won',
                  service: 'Cắt tóc, tạo mẫu',
                  price: '300,000 VND',
                  status: 'Đánh giá',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingList({required List<BookingItem> items}) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: items.length,
      itemBuilder: (context, index) => items[index],
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
  }
}

class BookingItem extends StatelessWidget {
  final String time;
  final String date;
  final String stylist;
  final String service;
  final String price;
  final String status;

  const BookingItem({
    required this.time,
    required this.date,
    required this.stylist,
    required this.service,
    required this.price,
    required this.status,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: ColorsConstants.gray,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildInfoAndActions()),
            const Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoAndActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoSection(),
        const SizedBox(height: 12),
        const Divider(color: Colors.grey, height: 1),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildActionButton(
              text: status,
              textColor: ColorsConstants.secondsBackground,
              backgroundColor: ColorsConstants.yellowPrimary,
            ),
            const SizedBox(width: 12), 
            _buildActionButton(
              text: 'Đổi lịch',
              textColor: ColorsConstants.secondsBackground,
              backgroundColor: ColorsConstants.yellowPrimary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          time,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          date,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Nhà tạo mẫu: $stylist',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dịch vụ: $service',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              price,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color textColor,
    required Color backgroundColor,
  }) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), 
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ), 
        minimumSize: const Size(140, 40), 
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 14, 
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
