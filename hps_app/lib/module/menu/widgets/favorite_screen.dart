import 'package:flutter/material.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:hps_app/module/menu/widgets/model%20.dart';
import 'package:hps_app/module/menu/widgets/favorite_service.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<ScheduleModel> favoriteOrders = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favs = await FavoriteService.getFavorites();
    setState(() {
      favoriteOrders = favs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsConstants.backgroundColor,
        title: const Text('Đơn ưa thích', style: TextStyle(color: ColorsConstants.text)),
        iconTheme: const IconThemeData(color: ColorsConstants.text),
      ),
      backgroundColor: ColorsConstants.backgroundColor,
      body: favoriteOrders.isEmpty
          ? const Center(
              child: Text('Chưa có đơn ưa thích', style: TextStyle(color: ColorsConstants.text)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoriteOrders.length,
              itemBuilder: (context, index) {
                final order = favoriteOrders[index];
                return Card(
                  color: ColorsConstants.secondsBackground,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(order.service, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorsConstants.text)),
                        const SizedBox(height: 8),
                        Text('Ngày: ${order.date}', style: const TextStyle(color: ColorsConstants.text)),
                        Text('Stylist: ${order.stylist}', style: const TextStyle(color: ColorsConstants.text)),
                        Text('Giá: ${order.price}', style: const TextStyle(color: ColorsConstants.text)),
                        Text('Giờ: ${order.time}', style: const TextStyle(color: ColorsConstants.text)),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
