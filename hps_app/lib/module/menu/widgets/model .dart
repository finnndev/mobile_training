
class ScheduleModel {
  final String time, date, stylist, service, price, type;

  ScheduleModel({
    required this.time,
    required this.date,
    required this.stylist,
    required this.service,
    required this.price,
    required this.type, 
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        time: json['time'],
        date: json['date'],
        stylist: json['stylist'],
        service: json['service'],
        price: json['price'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'time': time,
        'date': date,
        'stylist': stylist,
        'service': service,
        'price': price,
        'type': type,
      };
}