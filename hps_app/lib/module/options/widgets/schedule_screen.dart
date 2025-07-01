import 'package:flutter/material.dart';
import 'package:hps_app/module/options/widgets/card.dart';
import 'package:hps_app/module/options/widgets/model%20.dart';
import 'package:hps_app/module/options/widgets/service.dart';
import 'package:hps_app/shared/constants/colors.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<ScheduleModel> upcoming = [];
  List<ScheduleModel> history = [];

  @override
  void initState() {
    super.initState();
    _loadSchedules();
  }

  Future<void> _loadSchedules() async {
    final all = await ScheduleService.getSchedules();
    setState(() {
      upcoming = all.where((e) => e.type == 'upcoming').toList();
      history = all.where((e) => e.type == 'history').toList();
    });
  }

  Future<void> _moveToHistory(int index) async {
    final item = upcoming.removeAt(index);
    final newItem = ScheduleModel(
      time: item.time,
      date: item.date,
      stylist: item.stylist,
      service: item.service,
      price: item.price,
      type: 'history',
    );
    history.add(newItem);
    await ScheduleService.updateAll([...upcoming, ...history]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorsConstants.darkLeafGreen,
        appBar: AppBar(
          backgroundColor: ColorsConstants.darkLeafGreen,
          elevation: 0,
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          title: const Center(
            child: Text(
              'Lịch đặt của tôi',
              style: TextStyle(color: Colors.white),
            ),
          ),
          bottom: const TabBar(
            labelColor: ColorsConstants.yellowPrimary,
            unselectedLabelColor: Colors.white70,
            indicatorColor: ColorsConstants.yellowPrimary,
            tabs: [Tab(text: 'Sắp tới'), Tab(text: 'Lịch sử')],
          ),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  _buildTab(upcoming, isUpcoming: true),
                  _buildTab(history, isUpcoming: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(ScheduleModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ngày: ${model.date}', style: TextStyle(color: ColorsConstants.text)),
        Text('Giờ: ${model.time}', style: TextStyle(color: ColorsConstants.text)),
        Text('Stylist: ${model.stylist}', style: TextStyle(color: ColorsConstants.text)),
        Text('Dịch vụ: ${model.service}', style: TextStyle(color: ColorsConstants.text)),
        Text('Giá: ${model.price}', style: TextStyle(color: ColorsConstants.text)),
      ],
    );
  }

  Widget _buildTab(List<ScheduleModel> data, {required bool isUpcoming}) {
    if (data.isEmpty) {
      return const Center(
        child: Text('Không có dữ liệu', style: TextStyle(color: ColorsConstants.text)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final model = data[index];
        return Column(
          children: [
            ScheduleCard(
              model: model,
              actions: isUpcoming
                  ? [
                      _button('Hủy', () => _moveToHistory(index)),
                      _button('Đổi lịch', () {}),
                    ]
                  : [
                      _button('Đánh giá', () {}),
                      _button('Đặt lại', () {}),
                    ],
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _button(String label, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsConstants.yellowPrimary,
            foregroundColor: ColorsConstants.backgroundColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(label, style: const TextStyle(color: ColorsConstants.backgroundColor)),
        ),
      ),
    );
  }
}
