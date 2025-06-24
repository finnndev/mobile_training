import 'package:flutter/material.dart';
import 'package:hps_app/module/booking/models/stylist_model.dart';
import 'package:hps_app/shared/constants/colors.dart';
import '../services/stylist_service.dart';

final List<Map<String, String>> kCreators = [
  {"name": "Tran Manh", "image": "assets/images/stylist.jpg"},
  {"name": "Jun Won", "image": "assets/images/stylist2.jpg"},
  {"name": "Woo Your", "image": "assets/images/stylist3.jpg"},
];

class StylistSelector extends StatefulWidget {
  final Function(String) onCreatorSelected;

  const StylistSelector({super.key, required this.onCreatorSelected});

  @override
  _StylistSelectorState createState() => _StylistSelectorState();
}

class _StylistSelectorState extends State<StylistSelector> {
  String selectedCreator = "";

  final double _cardWidth = 127.0;
  final double _cardHeight = 162.0;
  final double _imageSize = 95.0;
  final double _horizontalMargin = 8.0;
  final double _verticalPadding = 8.0;

  @override
  void initState() {
    super.initState();
    _loadSelectedCreator();
  }

  Future<void> _loadSelectedCreator() async {
    final stylist = await StylistService.getSelectedStylist();
    setState(() {
      selectedCreator = stylist?.name ?? ""; 
      widget.onCreatorSelected(selectedCreator);
    });
  }

  void _selectCreator(String name) {
    setState(() {
      selectedCreator = name;
    });
    widget.onCreatorSelected(name); 
    _saveSelectedCreator(name); 
  }

  Future<void> _saveSelectedCreator(String name) async {
    await StylistService.saveSelectedStylist(Stylist(name: name, image: ''));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            "Chọn nhà tạo mẫu",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: ColorsConstants.text,
              fontFamily: "Roboto",
            ),
          ),
        ),
        SizedBox(
          height: _cardHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: kCreators.length,
            itemBuilder: (context, index) {
              return _buildCreatorItem(kCreators[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCreatorItem(Map<String, String> creator) {
    final isSelected = selectedCreator == creator["name"];

    return GestureDetector(
      onTap: () => _selectCreator(creator["name"]!),
      child: Card(
        color: isSelected ? ColorsConstants.secondsBackground : ColorsConstants.gray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isSelected ? ColorsConstants.yellowPrimary : ColorsConstants.grayLight,
            width: 2,
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: _horizontalMargin),
        child: SizedBox(
          width: _cardWidth,
          height: _cardHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  creator["image"]!,
                  width: _imageSize,
                  height: _imageSize,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: _verticalPadding),
              Text(
                creator["name"]!,
                style: TextStyle(
                  color: isSelected ? ColorsConstants.yellowPrimary : ColorsConstants.text,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Roboto",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}