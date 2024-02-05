import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Carousel extends StatelessWidget {
  final int count;
  final List<String> img;
  final CarouselController controller;
  final Function onPageChanged;
  final double? view;
  final BorderRadius? border;
  const Carousel(
      {required this.count,
      required this.img,
      required this.controller,
      required this.onPageChanged,
      this.view = 1.0,
      this.border,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        carouselController: controller,
        itemCount: count,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return Container(
            width: 100.w,
            child: ClipRRect(
              borderRadius: view != 1
                  ? BorderRadius.circular(8.0)
                  : border ?? BorderRadius.zero,
              child: Image.network(
                img[itemIndex],
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.black,
                    child: const Icon(Icons.room_service, size: 50),
                  );
                },
              ),
            ),
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          height: 80.h,
          viewportFraction: view!,
          enlargeCenterPage: true,
          enlargeFactor: 0.1,
          onPageChanged: (index, reason) {
            onPageChanged(index, reason);
          },
        ));
  }
}
