import 'package:flutter/material.dart';

class ItemBar extends StatefulWidget {
  final Function(String) onCreatorSelected;

  ItemBar({required this.onCreatorSelected});

  @override
  _ItemBarState createState() => _ItemBarState();
}

class _ItemBarState extends State<ItemBar> {
  String selectedCreator = "";

  final List<Map<String, String>> creators = [
    {"name": "Tran Manh", "image": "assets/images/tho1.jpg"},
    {"name": "Jun Won", "image": "assets/images/tho2.jpg"},
    {"name": "Woo Your", "image": "assets/images/tho3.jpg"},
  ];

  void _selectCreator(String name) {
    setState(() {
      selectedCreator = name;
    });
    widget.onCreatorSelected(name);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            "Chọn nhà tạo mẫu",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: "Roboto",
            ),
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: creators.length,
            itemBuilder: (context, index) {
              return _buildCreatorItem(creators[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCreatorItem(Map<String, String> creator) {
    bool isSelected = selectedCreator == creator["name"];

    return GestureDetector(
      onTap: () => _selectCreator(creator["name"]!),
      child: Card(
        color: isSelected ? Color(0xFF1A3C30) : Color(0xFF345147),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isSelected ? Color(0xFFF3AC40) : Color(0xFF677D75),
            width: 2,
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          width: 127,
          height: 162,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  creator["image"]!,
                  width: 95,
                  height: 95,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8),
              Text(
                creator["name"]!,
                style: TextStyle(
                  color: isSelected ? Color(0xFFF3AC40) : Colors.white,
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
