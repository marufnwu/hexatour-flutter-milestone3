




import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../widgets/buttons/custom_button.dart';

Widget exclusiveoffers(
    {required String name,
    required String image,
    required int flat_off,
    required int discount_percent,
    context}) {
  TextTheme theme = Theme.of(context).textTheme;

  return Container(
       height: MediaQuery.of(context).size.height * 0.40,
   
      width: MediaQuery.of(context).size.width * 0.35,
      margin: EdgeInsets.only(top: 1.5.h),
      padding: EdgeInsets.all(2.w),
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
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          'https://nodejs.hackerkernel.com/hexatour/public${image}',
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
        style: theme.displaySmall?.copyWith(
            color: ColorConst.blackColor, fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 0.4.h,
      ),
      SvgPicture.asset("assets/images/divline.svg"),
      SizedBox(
        height: 1.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
      
          col(
              text1: "discount",
              text2: '${discount_percent}%'.toString(),
              theme: theme),

              Expanded(
            child: CustomButton(
              name: 'Apply',
           onTap:  () {
             
           },
           
              right: 22,
              left: 22,
              color: ColorConst.kGreenColor,
              height: 5.h,
              width: 6.w,
              textStyle: theme.headlineMedium,
              radius: 9,
            ),
          ),
    
        // 
        ],
      ),
    ]),
  );
}


Widget col(
    {required String text1, required String text2, required TextTheme theme}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  
    children: [
      Text(
        text1,
        style: theme.displaySmall?.copyWith(color: ColorConst.blackColor),
      ),
      
      Text(
        text2,
        textAlign: TextAlign.center,
        style: theme.displaySmall?.copyWith(
            color: ColorConst.blackColor, fontWeight: FontWeight.w500),
      ),
    
    ],
  );
}