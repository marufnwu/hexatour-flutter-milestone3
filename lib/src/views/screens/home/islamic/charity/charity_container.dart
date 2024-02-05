import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/views/widgets/carousel/slider.dart';
import 'package:hexatour/src/views/widgets/custom_container/helper_container.dart';
import 'package:hexatour/src/views/widgets/date_time_picker/time_picker.dart';
import 'package:hexatour/src/views/widgets/textfields/custom_textfield.dart';
import 'package:sizer/sizer.dart';

import '../../../../widgets/buttons/custom_button.dart';

class CharityContainer extends StatelessWidget {
  final TextEditingController nameControl;
  final TextEditingController hotelControl;
  final TextEditingController roomControl;
  final TextEditingController mobileControl;
  final TextEditingController unitControl;
  final Function() onTap;
  final Function(dynamic) onSelect;
  final List<String> images;
  final String? id;
  final String? description;
  CharityContainer(
      {required this.nameControl,
      required this.hotelControl,
      required this.roomControl,
      required this.mobileControl,
      required this.unitControl,
      required this.images,
      required this.onTap,
      required this.onSelect,
      required this.description,
      required this.id,
      super.key});

  @override
  Widget build(BuildContext context) {
    CarouselController controller = CarouselController();
    TextTheme textTheme = Theme.of(context).textTheme;
    RxInt _activePage = 0.obs;
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    fontWeight: FontWeight.w600, color: ColorConst.blackColor),
              ),
              SizedBox(height: 0.8.h),
              Text(
                description.toString(),
                style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w500, color: ColorConst.blackColor),
              ),
              SizedBox(
                height: 2.h,
              ),
              HelperCon(
                title: "Enter Name",
                widget: CustomTextField(
                  control: nameControl,
                  hint: "Enter Your Name",
                  isRequired: true,
                  keyboardType: TextInputType.name,
                  isNumber: false,
                  textInputAction: TextInputAction.next,
                  style: textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorConst.blackColor),
                ),
              ),
              HelperCon(
                title: "Hotel Name",
                widget: CustomTextField(
                    control: hotelControl,
                    hint: "Enter Hotel Name",
                    isRequired: true,
                    keyboardType: TextInputType.name,
                    isNumber: false,
                    textInputAction: TextInputAction.next,
                    style: textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConst.blackColor)),
              ),
              HelperCon(
                title: "Room No.",
                widget: CustomTextField(
                  control: roomControl,
                  hint: "Enter Room No.",
                  isRequired: true,
                  keyboardType: TextInputType.name,
                  isNumber: false,
                  textInputAction: TextInputAction.next,
                  style: textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorConst.blackColor),
                ),
              ),
              HelperCon(
                title: "Mobile No.",
                widget: CustomTextField(
                  control: mobileControl,
                  hint: "Mobile Number",
                  isRequired: true,
                  prefIcon: Container(
                    margin: EdgeInsets.all(2.w),
                    width: 28.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorConst.whiteColor,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/saudi.png"),
                          Text(
                            " +966",
                            style: textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: ColorConst.blackColor,
                                fontSize: 13.sp),
                          ),
                          Icon(Icons.keyboard_arrow_down_outlined)
                        ]),
                  ),
                  keyboardType: TextInputType.number,
                  isNumber: true,
                  textInputAction: TextInputAction.next,
                  style: textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorConst.blackColor),
                ),
              ),
              HelperCon(
                title: "Preffered Time",
                widget: TimePicker(
                  onSelect: onSelect,
                ),
              ),
              HelperCon(
                  title: "Unit",
                  widget: CustomTextField(
                    control: unitControl,
                    hint: "Enter Number",
                    isRequired: true,
                    keyboardType: TextInputType.number,
                    isNumber: false,
                    textInputAction: TextInputAction.done,
                    style: textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConst.blackColor),
                  )),
              SizedBox(height: 2.h),
              CustomButton(
                name: 'Make Payment',
                height: 7.h,
                color: ColorConst.kGreenColor,
                textStyle: textTheme.displaySmall,
                onTap: onTap,
              )
            ],
          ),
        )
      ]),
    );
  }
}
