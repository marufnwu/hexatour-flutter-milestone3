import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';

import '../../../controllers/home_page_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../../models/home/offer_model.dart';

class OffersPage extends StatefulWidget {
  OffersPage({
    Key? key,
    required this.indexx,
    required this.context,
    required this.image,
  }) : super(key: key);

  final BuildContext context;
  final OfferImage image;

  final indexx;

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  final productController = Get.find<ProductController>();
  final homepageController = Get.find<HomePageController>();
  CarouselController controller = CarouselController();
 

  @override
  Widget build(BuildContext context) {
    print("image path ${widget.image.imagepath}");
    return Container(
        padding: EdgeInsets.all(3),
        margin: EdgeInsets.all(8),
        width: 280,
        child: InkWell(
            
            ),
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage('https://nodejs.hackerkernel.com/hexatour/public${widget.image.imagepath}'),
          fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 231, 227, 227),
                  spreadRadius: 2,
                  offset: Offset(1, 3),
                  blurRadius: 3.0)
            ],
            color: ColorConst.whiteColor,
            borderRadius: BorderRadius.circular(9)));
  }
}
