
class ServiceItem {
  final String iconPath;
  final String label;
  final double price;

  ServiceItem({required this.iconPath, required this.label, required this.price});

  
  Map<String, dynamic> toJson() => {
        'iconPath': iconPath,
        'label': label,
        'price': price,
      };


  factory ServiceItem.fromJson(Map<String, dynamic> json) {
    return ServiceItem(
      iconPath: json['iconPath'],
      label: json['label'],
      price: (json['price'] as num).toDouble(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceItem &&
          runtimeType == other.runtimeType &&
          iconPath == other.iconPath &&
          label == other.label &&
          price == other.price;

  @override
  int get hashCode => iconPath.hashCode ^ label.hashCode ^ price.hashCode;
}