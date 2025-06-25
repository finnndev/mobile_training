import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hps_app/shared/utils/asset_path.dart';

class TrendingStyles extends StatelessWidget {
  const TrendingStyles({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> trendingHairImage = [
      AssetPath.urlImage.trending1,
      AssetPath.urlImage.trending2,
    ];

    return CarouselSlider.builder(
      itemCount: trendingHairImage.length,
      itemBuilder: (context, index, realIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  trendingHairImage[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              const Positioned(
                top: 10,
                right: 10,
                child: Icon(Icons.favorite_outline, color: Colors.white),
              ),
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: 160,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        autoPlayInterval: const Duration(seconds: 3),
      ),
    );
  }
}
