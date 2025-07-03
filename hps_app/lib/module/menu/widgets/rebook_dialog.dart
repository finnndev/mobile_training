import 'package:flutter/material.dart';
import 'package:hps_app/module/menu/widgets/model%20.dart';
import 'package:hps_app/shared/constants/colors.dart';

class RebookDialog extends StatefulWidget {
  final ScheduleModel model;
  final void Function(DateTime date, String time) onRebook;
  const RebookDialog({super.key, required this.model, required this.onRebook});

  @override
  State<RebookDialog> createState() => _RebookDialogState();
}

class _RebookDialogState extends State<RebookDialog> {
  DateTime? _date;
  String _time = '';

  @override
  void initState() {
    super.initState();
    _date = DateTime.tryParse(widget.model.date) ?? DateTime.now();
    _time = widget.model.time;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsConstants.backgroundColor,
      title: const Text('Đặt lại lịch', style: TextStyle(color: ColorsConstants.text)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: TextEditingController(text: _date != null ? _date!.toIso8601String().substring(0, 10) : ''),
            style: const TextStyle(color: ColorsConstants.text),
            decoration: const InputDecoration(labelText: 'Ngày', labelStyle: TextStyle(color: ColorsConstants.text)),
            readOnly: true,
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _date ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) {
                setState(() {
                  _date = picked;
                });
              }
            },
          ),
          const SizedBox(height: 8),
          TextField(
            controller: TextEditingController(text: _time),
            style: const TextStyle(color: ColorsConstants.text),
            decoration: const InputDecoration(labelText: 'Giờ', labelStyle: TextStyle(color: ColorsConstants.text)),
            onChanged: (v) => _time = v,
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
            if (_date != null && _time.isNotEmpty) {
              widget.onRebook(_date!, _time);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Đặt lại', style: TextStyle(color: ColorsConstants.backgroundColor)),
        ),
      ],
    );
  }
}
