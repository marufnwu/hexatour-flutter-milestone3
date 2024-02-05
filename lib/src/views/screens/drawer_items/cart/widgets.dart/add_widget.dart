import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../cabs/widgets/cab_widgets.dart';


Widget paybill(context,amount) {

  TextTheme textTheme = Theme.of(context).textTheme;
  return Container(
    // height: 24.h,
    width: 100.w,
    padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 4.w),
    margin: EdgeInsets.only(bottom: 2.h, top: 1.h, left: 3.w, right: 3.w),
    decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage("assets/images/receipt.png"), fit: BoxFit.fill),
    ),
    child: Column(children: [
      SizedBox(height: 2.h),
      roo(name1: "Subtotal", name2: 'SAR $amount', theme: textTheme),
      // roo(name1: "Fees & tax", name2: "\$60", theme: textTheme),
      roo(name1: "Coupon Applied", name2: "SAR 0", theme: textTheme),
      // SizedBox(height: 0.1.h),
      Image.asset(
        "assets/images/Line.png",
        fit: BoxFit.fitWidth,
        width: 100.w,
      ),
      SizedBox(
        height: 2.5.h,
      ),

      roo(
          padding: EdgeInsets.only(bottom: 0.5.h),
          name1: "Total",
          name2: "SAR $amount ",
          theme: textTheme,
          style: textTheme.displaySmall?.copyWith(
              color: Color.fromARGB(255, 23, 22, 22),
              fontWeight: FontWeight.w500)),
    ]),
  );
}
