import '../models/service_model.dart';
import '../models/stylist_model.dart';
import '../models/payment_method_model.dart';
import '../models/ewallet_model.dart';
import 'asset_path.dart';

final List<Stylist> kCreators = [
  Stylist(name: "Tran Manh", image: AssetPath.stylist1),
  Stylist(name: "Jun Won", image: AssetPath.stylist2),
  Stylist(name: "Woo Your", image: AssetPath.stylist3),
];

const List<String> kTimeSlots = [
  "08:00", "08:30", "09:00", "09:30", "10:00"
];

final List<PaymentMethod> kPaymentMethods = [
  PaymentMethod(label: 'Thanh toán tại salon', image: AssetPath.icWallet),
  PaymentMethod(label: 'Ví điện tử', image: AssetPath.icWalletCards),
];

final List<EWallet> kEWallets = [
  EWallet(label: 'VNPAY', image: AssetPath.icVnpay),
  EWallet(label: 'Momo', image: AssetPath.icMomo),
  EWallet(label: 'ZaloPay', image: AssetPath.icZaloPay),
];

const Map<String, double> kServicePrices = {
  'Cắt tóc': 150000,
  'Gội đầu': 100000,
  'Uốn tóc': 300000,
  'Nhuộm tóc': 400000,
  'Ép tóc': 250000,
  'Tạo màu': 200000,
};

final List<ServiceItem> kServices = [
  ServiceItem(iconPath: AssetPath.cut, label: "Cắt tóc", price: 150000),
  ServiceItem(iconPath: AssetPath.curling, label: "Uốn tóc", price: 300000),
  ServiceItem(iconPath: AssetPath.dying, label: "Nhuộm tóc", price: 400000),
  ServiceItem(iconPath: AssetPath.paintbrush, label: "Ép tóc", price: 250000),
  ServiceItem(iconPath: AssetPath.washing, label: "Gội đầu", price: 100000),
  ServiceItem(iconPath: AssetPath.color, label: "Tạo màu", price: 200000),
];

double getServicePrice(String serviceLabel) => kServicePrices[serviceLabel] ?? 0.0;
