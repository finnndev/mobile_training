import 'package:flutter/material.dart';
import 'package:hps_app/module/menu/widgets/model%20.dart';
import 'package:hps_app/shared/constants/colors.dart';

class EditScheduleDialog extends StatefulWidget {
  final ScheduleModel model;
  final List<String> stylists;
  final List<String> services;
  final void Function(ScheduleModel) onSave;
  const EditScheduleDialog({super.key, required this.model, required this.stylists, required this.services, required this.onSave});

  @override
  State<EditScheduleDialog> createState() => _EditScheduleDialogState();
}

class _EditScheduleDialogState extends State<EditScheduleDialog> {
  late String date;
  late String time;
  late String stylist;
  late String service;
  late String price;

  static const List<String> defaultStylists = [
    'Tran Manh',
    'Jun Won',
    'Woo Your',
  ];
  static const List<String> defaultServices = [
    'Cắt tóc',
    'Nhuộm tóc',
    'Uốn tóc',
    'Ép tóc',
    'Gội đầu',
    'Tạo mẫu',
  ];

  @override
  void initState() {
    super.initState();
    date = widget.model.date;
    time = widget.model.time;
    stylist = defaultStylists.contains(widget.model.stylist) ? widget.model.stylist : defaultStylists.first;
    service = defaultServices.contains(widget.model.service) ? widget.model.service : defaultServices.first;
    price = widget.model.price;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsConstants.backgroundColor,
      title: const Text('Đổi lịch', style: TextStyle(color: ColorsConstants.text)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: TextEditingController(text: date),
              style: const TextStyle(color: ColorsConstants.text),
              decoration: const InputDecoration(labelText: 'Ngày', labelStyle: TextStyle(color: ColorsConstants.text)),
              readOnly: true,
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.tryParse(date) ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  setState(() {
                    date = picked.toIso8601String().substring(0, 10);
                  });
                }
              },
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: time),
              style: const TextStyle(color: ColorsConstants.text),
              decoration: const InputDecoration(labelText: 'Giờ', labelStyle: TextStyle(color: ColorsConstants.text)),
              onChanged: (v) => time = v,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: stylist,
              dropdownColor: ColorsConstants.backgroundColor,
              decoration: const InputDecoration(labelText: 'Stylist', labelStyle: TextStyle(color: ColorsConstants.text)),
              items: defaultStylists.map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(color: ColorsConstants.text)))).toList(),
              onChanged: (v) => setState(() => stylist = v ?? stylist),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: service,
              dropdownColor: ColorsConstants.backgroundColor,
              decoration: const InputDecoration(labelText: 'Dịch vụ', labelStyle: TextStyle(color: ColorsConstants.text)),
              items: defaultServices.map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(color: ColorsConstants.text)))).toList(),
              onChanged: (v) => setState(() => service = v ?? service),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: price),
              style: const TextStyle(color: ColorsConstants.text),
              decoration: const InputDecoration(labelText: 'Giá tiền', labelStyle: TextStyle(color: ColorsConstants.text)),
              onChanged: (v) => price = v,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Hủy', style: TextStyle(color: ColorsConstants.text)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: ColorsConstants.yellowPrimary),
          onPressed: () {
            widget.onSave(ScheduleModel(
              time: time,
              date: date,
              stylist: stylist,
              service: service,
              price: price,
              type: widget.model.type,
            ));
            Navigator.of(context).pop();
          },
          child: const Text('Lưu', style: TextStyle(color: ColorsConstants.backgroundColor)),
        ),
      ],
    );
  }
}
