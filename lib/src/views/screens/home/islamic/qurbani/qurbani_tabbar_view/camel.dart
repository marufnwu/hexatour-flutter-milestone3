import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/views/screens/home/islamic/qurbani/qurbani_tabbar_view/qurbani_fill_details.dart';
import 'package:hexatour/src/views/widgets/buttons/custom_button.dart';
import 'package:hexatour/src/views/widgets/carousel/slider.dart';
import 'package:sizer/sizer.dart';

class Camel extends StatefulWidget {
 Camel({
    Key? key,
    required this.id,
  
    required this.qurbaniType,
    // required this.imagepath,
    this.description,
    this.price,
  }) : super(key: key);

  // final List<TourImages> imagepath;
  final String? qurbaniType;
  final String? description;
  final String? id;
  final String? price;

  @override
  State<Camel> createState() => _CamelState();
}

class _CamelState extends State<Camel> {
  @override
  Widget build(BuildContext context) {
    CarouselController controller = CarouselController();
    TextTheme textTheme = Theme.of(context).textTheme;
    RxInt _activePage = 0.obs;

    List<String> images = [
     'https://tse1.mm.bing.net/th?id=OIP.0tRPGNo4ZGK5ZqM_La64TQHaFj&pid=Api&rs=1&c=1&qlt=95&w=140&h=105',
     'https://tse1.mm.bing.net/th?id=OIP.0tRPGNo4ZGK5ZqM_La64TQHaFj&pid=Api&rs=1&c=1&qlt=95&w=140&h=105',
     'https://tse1.mm.bing.net/th?id=OIP.0tRPGNo4ZGK5ZqM_La64TQHaFj&pid=Api&rs=1&c=1&qlt=95&w=140&h=105'
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 30.h,
                width: 100.w,
                child: Carousel(
                    count: images.length,
                    img: images,
                    controller: controller,
                    onPageChanged: (index, reason) {
                      _activePage.value = index;
                    }),
              ),
              Obx(
                () => Positioned(
                  bottom: -3.h,
                  left: 38.w,
                  right: 0,
                  height: 80,
                  child: Row(
                    children: List.generate(
                      images.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: _activePage == index
                                      ? ColorConst.whiteColor
                                      : Colors.transparent),
                              shape: BoxShape.circle),
                          padding: EdgeInsets.all(3),
                          child: CircleAvatar(
                            radius: 3,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description",
                  style: textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorConst.blackColor),
                ),
                SizedBox(height: 0.8.h),
                Text(
                 widget.description.toString(),
                  style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorConst.blackColor),
                ),
                SizedBox(height: 25.h),
                CustomButton(
                  name: 'Book Now',
                  color: ColorConst.kGreenColor,
                  textStyle: textTheme.displaySmall,
                  height: 7.h,
                  onTap: () {
                    Get.to(FillQurbaniDetails(
                      id: widget.id.toString() ,
                      qurbaniType: widget.qurbaniType ,
                    ));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
