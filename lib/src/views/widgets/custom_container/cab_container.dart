import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/views/widgets/custom_container/helper_container.dart';
import 'package:sizer/sizer.dart';

import '../buttons/custom_button.dart';

class CabContainer extends StatelessWidget {
  final String pickup;
  final String drop;
  final String btnName;
  final Function() onTap;
  const CabContainer(
      {required this.pickup,
      required this.drop,
      required this.btnName,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        width: 100.w,
        margin: EdgeInsets.only(top: 1.5.h),
        padding: EdgeInsets.all(1.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xffEDEDED), width: 0.4),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(223, 217, 217, 0.25),
                offset: Offset(0, 10),
                blurRadius: 15,
              ),
              BoxShadow(
                  color: ColorConst.whiteColor,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0,
                  spreadRadius: 0)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/images/drop.svg",
                        height: 3.5.h,
                        width: 8.w,
                        fit: BoxFit.cover,
                      ),
                      SvgPicture.asset("assets/images/vline.svg", height: 4.h),
                      SvgPicture.asset("assets/images/picku.svg",
                          height: 3.5.h, width: 8.w, fit: BoxFit.cover),
                    ],
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  flex: 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HelperCon(
                        padding: EdgeInsets.only(bottom: 1.h),
                        title: "PickUp",
                        style: theme.displayMedium?.copyWith(
                            color: ColorConst.blackColor, fontSize: 15.sp),
                        widget: Text(
                          pickup,
                          style: theme.displaySmall?.copyWith(
                              color: ColorConst.blackColor, fontSize: 13.sp),
                        ),
                      ),
                      HelperCon(
                        padding: EdgeInsets.only(bottom: 1.h),
                        title: "Drop",
                        style: theme.displayMedium?.copyWith(
                            color: ColorConst.blackColor, fontSize: 15.sp),
                        widget: Text(
                          drop,
                          style: theme.displaySmall?.copyWith(
                              color: ColorConst.blackColor, fontSize: 13.sp),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 0.4.h,
            ),
            SvgPicture.asset("assets/images/divline.svg"),
            SizedBox(
              height: 0.5.h,
            ),
            Row(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: 1,
                    child: SvgPicture.asset(
                      "assets/images/price.svg",
                      height: 4.h,
                    )),
                col(text1: "Price", text2: "\$200.20", theme: theme),
                Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: 1,
                    child: SvgPicture.asset(
                      "assets/images/cal.svg",
                      height: 4.h,
                    )),
                col(text1: "Date", text2: "15/01/2023", theme: theme),
                SizedBox(width: 3.w),
                Expanded(
                    child: CustomButton(
                  name: btnName,
                  onTap: onTap,
                  color: ColorConst.kGreenColor,
                  height: 4.h,
                  textStyle: theme.displaySmall?.copyWith(fontSize: 13.sp),
                  radius: 10,
                ))
              ],
            ),
            SizedBox(
              height: 1.h,
            )
          ],
        ),
      ),
    );
  }
}

Widget col(
    {required String text1, required String text2, required TextTheme theme}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: theme.displaySmall
              ?.copyWith(color: ColorConst.blackColor, fontSize: 12.sp),
        ),
        Text(
          text2,
          maxLines: 1,
          style: theme.displaySmall?.copyWith(
              color: ColorConst.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 12.sp),
        )
      ],
    ),
  );
}
