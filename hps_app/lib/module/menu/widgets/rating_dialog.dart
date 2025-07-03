import 'package:flutter/material.dart';
import 'package:hps_app/shared/constants/colors.dart';

class RatingDialog extends StatefulWidget {
  final void Function(int rating) onSubmit;
  const RatingDialog({super.key, required this.onSubmit});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 5;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsConstants.backgroundColor,
      title: const Text('Đánh giá dịch vụ', style: TextStyle(color: ColorsConstants.text)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final star = index + 1;
              return IconButton(
                icon: Icon(
                  Icons.star,
                  color: _rating >= star ? ColorsConstants.yellowPrimary : ColorsConstants.grayLight,
                  size: 32,
                ),
                onPressed: () => setState(() => _rating = star),
              );
            }),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Hủy', style: TextStyle(color: ColorsConstants.text)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: ColorsConstants.yellowPrimary),
          onPressed: () {
            widget.onSubmit(_rating);
            Navigator.of(context).pop();
          },
          child: const Text('Gửi', style: TextStyle(color: ColorsConstants.backgroundColor)),
        ),
      ],
    );
  }
}
