


import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';

Widget roo(
    {required String name1,
    required String name2,
    EdgeInsets? padding,
    required TextTheme theme,
    TextStyle? style}) {
  return Padding(
    padding: padding ?? EdgeInsets.only(bottom: 2.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name1,
          style: style ??
              theme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500, color: ColorConst.blackColor),
        ),
        Text(
          name2,
          style: style ??
              theme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500, color: ColorConst.blackColor),
        )
      ],
    ),
  );
}