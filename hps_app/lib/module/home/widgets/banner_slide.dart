import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  final List<String> bannerImages;
  final int activeIndex;
  final Function(int) onChanged;

  const BannerSlider({
    super.key,
    required this.bannerImages,
    required this.activeIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: bannerImages.length,
          itemBuilder: (context, index, realIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(bannerImages[index], fit: BoxFit.cover, width: 1000),
            );
          },
          options: CarouselOptions(
            height: 150,
            autoPlay: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) => onChanged(index),
          ),
        ),
        const SizedBox(height: 8),
        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: bannerImages.length,
          effect: const WormEffect(dotWidth: 8, dotHeight: 8, activeDotColor: Colors.yellow),
        ),
      ],
    );
  }
}
