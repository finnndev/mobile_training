import 'package:flutter/material.dart';
import 'package:hps_app/module/menu/widgets/card.dart';
import 'package:hps_app/module/menu/widgets/model%20.dart';
import 'package:hps_app/module/menu/widgets/favorite_service.dart';
import 'package:hps_app/module/menu/widgets/edit_schedule_dialog.dart';
import 'package:hps_app/module/menu/widgets/service.dart';
import 'package:hps_app/module/menu/widgets/rating_dialog.dart';
import 'package:hps_app/module/menu/widgets/rebook_dialog.dart';
import 'package:hps_app/shared/constants/colors.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  // Dummy data for stylist and service, replace with your real data source
  final List<String> stylists = ['Nghĩa Lê', 'Trần Mạnh', 'Stylist 3'];
  final List<String> services = ['Cắt tóc nam', 'Nhuộm tóc', 'Uốn tóc'];
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
  upcoming.removeAt(index); 
  await ScheduleService.updateAll([...upcoming]); 
  setState(() {}); 
}
Future<void> _confirmCancel(int index) async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: ColorsConstants.backgroundColor,
      title: const Text('Xác nhận huỷ lịch', style: TextStyle(color: ColorsConstants.yellowPrimary)),
      content: const Text('Bạn có chắc muốn huỷ lịch này không?', style: TextStyle(color: ColorsConstants.text)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Không', style: TextStyle(color: ColorsConstants.yellowPrimary)),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Hủy', style: TextStyle(color: ColorsConstants.yellowPrimary)),
        ),
      ],
    ),
  );

  if (confirm == true) {
    await _moveToHistory(index);
  }
}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorsConstants.backgroundColor,
        appBar: AppBar(
          backgroundColor: ColorsConstants.backgroundColor,
          elevation: 0,
          leading: BackButton(
            color: ColorsConstants.text,
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          centerTitle: true,
          title: const Text(
            'Lịch đặt của tôi',
            style: TextStyle(color: ColorsConstants.text),
          ),
          bottom: const TabBar(
            labelColor: ColorsConstants.yellowPrimary,
            unselectedLabelColor: ColorsConstants.text,
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
            Stack(
              children: [
                FutureBuilder<bool>(
                  future: FavoriteService.isFavorite(model),
                  builder: (context, snapshot) {
                    final isFav = snapshot.data ?? false;
                    return Stack(
                      children: [
                        ScheduleCard(
                          model: model,
                          actions: isUpcoming
                              ? [
                                  _button('Hủy', () => _confirmCancel(index)),
                                  _button('Đổi lịch', () async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) => EditScheduleDialog(
  model: model,
  onSave: (edited) async {
    setState(() {
      data[index] = edited;
    });
    await ScheduleService.updateAll([...upcoming, ...history]);
  },
)

                                    );
                                  }),
                                ]
                              : [
                                  _button('Đánh giá', () async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) => RatingDialog(
                                        onSubmit: (rating) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Bạn đã đánh giá $rating sao!'),
                                              backgroundColor: ColorsConstants.yellowPrimary,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }),
                                  _button('Đặt lại', () async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) => RebookDialog(
                                        model: model,
                                        onRebook: (date, time) async {
                                          // Tạo lịch mới dựa trên lịch cũ nhưng cập nhật ngày và giờ
                                          final newSchedule = ScheduleModel(
                                            time: time,
                                            date: date.toIso8601String().substring(0, 10),
                                            stylist: model.stylist,
                                            service: model.service,
                                            price: model.price,
                                            type: 'upcoming',
                                          );
                                          setState(() {
                                            upcoming.add(newSchedule);
                                          });
                                          await ScheduleService.updateAll([...upcoming, ...history]);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Đặt lại thành công cho ngày ${date.toIso8601String().substring(0, 10)} lúc $time'),
                                              backgroundColor: ColorsConstants.yellowPrimary,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }),
                                ],
                        ),
                        Positioned(
                          top: 8,
                          right: isUpcoming ? 8 : 48,
                          child: IconButton(
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? ColorsConstants.yellowPrimary : ColorsConstants.grayLight,
                            ),
                            tooltip: isFav ? 'Bỏ ưu thích' : 'Thêm vào ưu thích',
                            onPressed: () async {
                              if (isFav) {
                                await FavoriteService.removeFavorite(model);
                              } else {
                                await FavoriteService.addFavorite(model);
                              }
                              setState(() {});
                            },
                          ),
                        ),
                        if (!isUpcoming)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: Icon(Icons.close, color: ColorsConstants.yellowPrimary),
                              tooltip: 'Ẩn lịch sử này',
                              onPressed: () async {
                                setState(() {
                                  history.removeAt(index);
                                });
                                await ScheduleService.updateAll([...upcoming, ...history]);
                              },
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

 Widget _button(String label, VoidCallback onPressed) {
  return Padding(
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
  );
}

}
