import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/api_services/Providers.dart';

class BannerSlider extends ConsumerStatefulWidget {
  const BannerSlider({super.key});

  @override
  ConsumerState<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends ConsumerState<BannerSlider> {
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final bannersAsync = ref.watch(bannarProvider);
    return Column(
      children: [
        CarouselSlider(
          items:
              bannersAsync.map((imagePath) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(imagePath.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
          // carouselController: _controller,
          options: CarouselOptions(
            height: 175,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            aspectRatio: 16 / 9,
            autoPlayInterval: const Duration(seconds: 3),
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),

        const SizedBox(height: 10),

        /// 🔹 Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              bannersAsync.asMap().entries.map((entry) {
                return GestureDetector(
                  // onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: _currentIndex == entry.key ? 12.0 : 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _currentIndex == entry.key
                              ? Colors.blue
                              : Colors.grey.shade400,
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
