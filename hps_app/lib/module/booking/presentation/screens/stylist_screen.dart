import 'package:flutter/material.dart';
import 'package:hps_app/module/booking/presentation/providers/booking_state.dart';
import 'package:hps_app/shared/constants/colors.dart';
import 'package:provider/provider.dart';
import '../../constants/booking_constants.dart';
import '../../models/stylist_model.dart';

class StylistSelector extends StatelessWidget {
  const StylistSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingState>(
      builder: (context, state, child) {
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
              height: 162.0, // _cardHeight
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: kCreators.length,
                itemBuilder: (context, index) {
                  return _buildCreatorItem(context, kCreators[index], state);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCreatorItem(BuildContext context, Stylist creator, BookingState state) {
    final isSelected = state.selectedCreator == creator.name;
    final double _cardWidth = 127.0;
    final double _cardHeight = 162.0;
    final double _imageSize = 95.0;
    final double _horizontalMargin = 8.0;
    final double _verticalPadding = 8.0;

    return GestureDetector(
      onTap: () => state.updateCreator(creator.name),
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
                  creator.image,
                  width: _imageSize,
                  height: _imageSize,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: _verticalPadding),
              Text(
                creator.name,
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