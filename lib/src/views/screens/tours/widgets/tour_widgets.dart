


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../models/tour/Tour_model.dart';
import '../../../widgets/buttons/custom_button.dart';

Widget exclusivepackage(
    {required String name,
    required TourImage imagepath,
    context,
    required Function() onTap}) {
  TextTheme theme = Theme.of(context).textTheme;
  return Container(
    height: 36.h,
    width: 100.w,
    margin: EdgeInsets.only(top: 1.5.h),
    padding: EdgeInsets.all(2.w),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffEDEDED), width: 0.4),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(33, 30, 30, 0.239),
            offset: Offset(0, 10),
            blurRadius: 15,
          ),
          BoxShadow(
              color: Color.fromARGB(255, 245, 245, 245),
              offset: Offset(0.0, 0.0),
              blurRadius: 0,
              spreadRadius: 0)
        ]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          'https://nodejs.hackerkernel.com/hexatour/public${imagepath.imagepath}',
          fit: BoxFit.fill,
          height: 20.h,
          width: 100.w,
        ),
      ),
      SizedBox(
        height: 0.8.h,
      ),
      Text(
        name,
        style: theme.headlineMedium?.copyWith(
            color: ColorConst.blackColor, fontWeight: FontWeight.w600),
      ),
      SizedBox(
        height: 0.4.h,
      ),
      SvgPicture.asset("assets/images/divline.svg"),
      SizedBox(
        height: 1.h,
      ),
      Row(
        children: [
          Expanded(
            child: CustomButton(
              name: 'Read more',
              onTap: onTap,
              right: 15,
              left: 5,
              color: ColorConst.kGreenColor,
              height: 5.h,
              textStyle: theme.headlineMedium,
              radius: 7,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),

          //
        ],
      )
    ]),
  );
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
          style: theme.headlineMedium?.copyWith(color: ColorConst.blackColor),
        ),
        Text(
          text2,
          style: theme.headlineMedium?.copyWith(
              color: ColorConst.blackColor, fontWeight: FontWeight.w500),
        )
      ],
    ),
  );
}



Widget checkbox(title, context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  bool value = false;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: textTheme.displaySmall
            ?.copyWith(fontSize: 14.sp, color: ColorConst.blackColor),
      ),
      Checkbox(value: value, onChanged: ((value) {}))
      //Chec
    ],
  );
}

Widget boxs(context) {
 
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      color: Colors.amber[100],
    ),
    padding: EdgeInsets.all(13),
    height: 10.h,
    width: 90.w,
    child: Row(children: [
      Image(image: AssetImage('assets/images/frame.png')),
      Image(image: AssetImage('assets/images/text.png')),
    ]),
  );
}