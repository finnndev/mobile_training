
class DateTimeSelection {
  final DateTime? selectedDate;
  final String? selectedTime;

  DateTimeSelection({this.selectedDate, this.selectedTime});

  
  Map<String, dynamic> toJson() => {
        'selectedDate': selectedDate?.toIso8601String(),
        'selectedTime': selectedTime,
      };

  
  factory DateTimeSelection.fromJson(Map<String, dynamic> json) {
    return DateTimeSelection(
      selectedDate: json['selectedDate'] != null
          ? DateTime.parse(json['selectedDate'])
          : null,
      selectedTime: json['selectedTime'] as String?,
    );
  }
}