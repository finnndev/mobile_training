import 'package:flutter/material.dart';
import 'package:hps_app/module/menu/widgets/model%20.dart';
import 'package:intl/intl.dart';
import 'package:hps_app/module/booking/constants/booking_constants.dart';
import 'package:hps_app/shared/constants/colors.dart';

class EditScheduleDialog extends StatefulWidget {
  final ScheduleModel model;
  final void Function(ScheduleModel) onSave;

  const EditScheduleDialog({
    super.key,
    required this.model,
    required this.onSave,
  });

  @override
  State<EditScheduleDialog> createState() => _EditScheduleDialogState();
}

class _EditScheduleDialogState extends State<EditScheduleDialog> {
  late String date;
  late String time;
  late String stylist;
  late List<String> selectedServices;
  late double price;

  @override
  void initState() {
    super.initState();
    date = widget.model.date;
    time = kTimeSlots.contains(widget.model.time)
        ? widget.model.time
        : kTimeSlots.first;
    stylist = kCreators.any((s) => s.name == widget.model.stylist)
        ? widget.model.stylist
        : kCreators.first.name;
    selectedServices = widget.model.service.split(', ').where((s) => s.isNotEmpty).toList();
    price = selectedServices.fold(0.0, (sum, s) => sum + getServicePrice(s));
  }

  void _updateTotalPrice() {
    price = selectedServices.fold(0.0, (sum, s) => sum + getServicePrice(s));
  }

  String _formatPrice(double value) =>
      '${NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0).format(value)}VND';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsConstants.backgroundColor,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: ColorsConstants.yellowPrimary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text('Đổi lịch', style: TextStyle(color: ColorsConstants.text)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: TextEditingController(text: date),
              style: const TextStyle(color: ColorsConstants.text),
              decoration: const InputDecoration(
                labelText: 'Ngày',
                labelStyle: TextStyle(color: ColorsConstants.text),
              ),
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
            DropdownButtonFormField<String>(
              value: time,
              dropdownColor: ColorsConstants.backgroundColor,
              decoration: const InputDecoration(
                labelText: 'Giờ',
                labelStyle: TextStyle(color: ColorsConstants.text),
              ),
              items: kTimeSlots
                  .map((t) => DropdownMenuItem(
                        value: t,
                        child: Text(t, style: const TextStyle(color: ColorsConstants.text)),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => time = v ?? time),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: stylist,
              dropdownColor: ColorsConstants.backgroundColor,
              decoration: const InputDecoration(
                labelText: 'Stylist',
                labelStyle: TextStyle(color: ColorsConstants.text),
              ),
              items: kCreators
                  .map((s) => DropdownMenuItem(
                        value: s.name,
                        child: Text(s.name, style: const TextStyle(color: ColorsConstants.text)),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => stylist = v ?? stylist),
            ),
            const SizedBox(height: 8),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Dịch vụ', style: TextStyle(color: ColorsConstants.text)),
                  const SizedBox(height: 4),
                  ...kServices.map((s) {
                    return CheckboxListTile(
                      value: selectedServices.contains(s.label),
                      onChanged: (checked) {
                        setState(() {
                          if (checked == true) {
                            selectedServices.add(s.label);
                          } else {
                            selectedServices.remove(s.label);
                          }
                          _updateTotalPrice();
                        });
                      },
                      title: Text(s.label, style: const TextStyle(color: ColorsConstants.text)),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: ColorsConstants.yellowPrimary,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: _formatPrice(price)),
              readOnly: true,
              style: const TextStyle(color: ColorsConstants.text),
              decoration: const InputDecoration(
                labelText: 'Giá tiền',
                labelStyle: TextStyle(color: ColorsConstants.text),
              ),
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
              service: selectedServices.join(', '),
              price: _formatPrice(price),
              type: widget.model.type,
            ));
            Navigator.of(context).pop();
          },
          child: const Text('Lưu',
              style: TextStyle(color: ColorsConstants.backgroundColor)),
        ),
      ],
    );
  }
}
