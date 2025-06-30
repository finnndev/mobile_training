import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/stylist_model.dart';
import '../../models/date_time_model.dart';
import '../../models/service_model.dart';
import '../../data/services/stylist_service.dart';
import '../../data/services/date_time_service.dart';
import '../../data/services/hairdressing_service.dart';
import '../../constants/booking_constants.dart';
import '../../models/ewallet_model.dart';

class BookingState with ChangeNotifier {
  int _selectedIndex = 0;
  String _selectedCreator = '';
  DateTime? _selectedDate;
  String _selectedTime = '';
  List<ServiceItem> _selectedServices = [];
  String? _username;
  int _selectedPaymentIndex = 0;
  int _selectedEWalletIndex = 0;

  // Getters
  int get selectedIndex => _selectedIndex;
  String get selectedCreator => _selectedCreator;
  DateTime? get selectedDate => _selectedDate;
  String get selectedTime => _selectedTime;
  List<ServiceItem> get selectedServices => _selectedServices;
  String? get username => _username;
  double get totalPrice => _selectedServices.fold(0.0, (sum, item) => sum + item.price);
  int get selectedPaymentIndex => _selectedPaymentIndex;
  int get selectedEWalletIndex => _selectedEWalletIndex;

  // Getter cho phương thức thanh toán hiện tại
  String get selectedPaymentMethodLabel {
    if (_selectedPaymentIndex == 0) return 'salon';
    if (_selectedPaymentIndex == 1) return 'ewallet';
    return '';
  }

  // Getter cho loại ví điện tử đã chọn (nếu có)
  EWallet? get selectedEWallet {
    if (_selectedPaymentIndex == 1 && _selectedEWalletIndex >= 0 && _selectedEWalletIndex < kEWallets.length) {
      return kEWallets[_selectedEWalletIndex];
    }
    return null;
  }

  // Load và clear dữ liệu
  Future<void> loadInitialData() async {
    await _clearBookingData();
    await _loadAllData();
    notifyListeners();
  }

  Future<void> _loadAllData() async {
    final stylist = await StylistService.getSelectedStylist();
    final dateTime = await DateTimeService.getSelectedDateTime();
    final services = await HairdressingService.getSelectedServices();
    final prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('username') ?? 'Khách';
    _selectedCreator = stylist?.name ?? '';
    _selectedDate = dateTime?.selectedDate;
    _selectedTime = dateTime?.selectedTime ?? '';
    _selectedServices = services ?? [];
    notifyListeners();
  }

  Future<void> _clearBookingData() async {
    await StylistService.clearSelectedStylist();
    await DateTimeService.clearSelectedDateTime();
    await HairdressingService.clearSelectedServices();
    _selectedCreator = '';
    _selectedDate = null;
    _selectedTime = '';
    _selectedServices = [];
    _selectedIndex = 0;
    _selectedPaymentIndex = 0;
    _selectedEWalletIndex = 0;
    notifyListeners();
  }

  
  void updateCreator(String name) {
    _selectedCreator = name;
   
    _saveStylist();
    notifyListeners();
  }

  void updateDate(DateTime date) {
    _selectedDate = date;
    _saveDateTime();
    notifyListeners();
  }

  void updateTime(String time) {
    _selectedTime = time;
    _saveDateTime();
    notifyListeners();
  }

  void updateServices(List<ServiceItem> services) {
    _selectedServices = services;
    _saveServices();
    notifyListeners();
  }

  void toggleService(ServiceItem service) {
    if (_selectedServices.contains(service)) {
      _selectedServices.remove(service);
    } else {
      _selectedServices.add(service);
    }
    _saveServices();
    notifyListeners();
  }

  void selectPaymentMethod(int index) {
    _selectedPaymentIndex = index;
    notifyListeners();
  }

  void selectEWallet(int index) {
    _selectedEWalletIndex = index;
    notifyListeners();
  }

  void continueBooking() {
    if (_selectedIndex < 5) {
      _selectedIndex++;
      notifyListeners();
    }
  }

  void goBack(BuildContext context) {
    if (_selectedIndex > 0) {
      _selectedIndex--;
    } else {
      Navigator.pop(context);
    }
    notifyListeners();
  }

  
  void onTabTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Future<void> _saveStylist() async {
    if (_selectedCreator.isNotEmpty) {
      await StylistService.saveSelectedStylist(Stylist(name: _selectedCreator, image: ''));
    }
  }

  Future<void> _saveDateTime() async {
    if (_selectedDate != null && _selectedTime.isNotEmpty) {
      await DateTimeService.saveSelectedDateTime(
        DateTimeSelection(selectedDate: _selectedDate, selectedTime: _selectedTime),
      );
    }
  }

  Future<void> _saveServices() async {
    await HairdressingService.saveSelectedServices(_selectedServices);
  }
}