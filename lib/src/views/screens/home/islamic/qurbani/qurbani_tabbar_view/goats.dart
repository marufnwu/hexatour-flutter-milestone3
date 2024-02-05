import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/views/screens/home/islamic/qurbani/qurbani_tabbar_view/qurbani_fill_details.dart';
import 'package:hexatour/src/views/widgets/buttons/custom_button.dart';
import 'package:hexatour/src/views/widgets/carousel/slider.dart';
import 'package:hexatour/src/views/widgets/dropdown/customdropdown.dart';
import 'package:sizer/sizer.dart';

import '../../../../../widgets/custom_container/helper_container.dart';

class Goats extends StatefulWidget {
  Goats({
    Key? key,
    required this.id,
    this.qurbaniType,
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
  State<Goats> createState() => _GoatsState();
}

class _GoatsState extends State<Goats> {
  @override
  Widget build(BuildContext context) {
    CarouselController controller = CarouselController();
    TextTheme textTheme = Theme.of(context).textTheme;
    RxInt _activePage = 0.obs;
    RxString kind = 'Select Kind'.obs;

    List<String> images = [
      'https://tse1.mm.bing.net/th?id=OIP.X8ckRhahEN70-vwlOqL3lAHaE8&pid=Api&rs=1&c=1&qlt=95&w=177&h=118',
         'https://tse1.mm.bing.net/th?id=OIP.X8ckRhahEN70-vwlOqL3lAHaE8&pid=Api&rs=1&c=1&qlt=95&w=177&h=118',
           'https://tse1.mm.bing.net/th?id=OIP.X8ckRhahEN70-vwlOqL3lAHaE8&pid=Api&rs=1&c=1&qlt=95&w=177&h=118'
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
                  widget.qurbaniType.toString(),
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
                SizedBox(height: 2.h),
                SvgPicture.asset("assets/images/divline.svg"),
                SizedBox(
                  height: 2.h,
                ),
                HelperCon(
                  title: "Kind of Goats",
                  widget: CustomDropDown(
                    key: Key(math.Random().nextInt(9999).toString()),
                    hint: kind,
                    items: <String>["small", "medium", "large"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(height: 10.h),
                CustomButton(
                  name: 'Book Now',
                  color: ColorConst.kGreenColor,
                  textStyle: textTheme.displaySmall,
                  height: 7.h,
                  onTap: () {
                    Get.to(FillQurbaniDetails(
                      kind: kind.toString(),
                      id: widget.id,
                      qurbaniType: widget.qurbaniType,
                      
                    ));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
