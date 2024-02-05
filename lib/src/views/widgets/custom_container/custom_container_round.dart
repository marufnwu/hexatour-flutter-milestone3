import 'package:flutter/material.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

class CusCon extends StatelessWidget {
  final Function() onTap;
  final String name;
  final TextStyle style;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final double? height;
  const CusCon(
      {required this.onTap,
      required this.name,
      required this.style,
      this.boxShadow,
      this.border,
      this.height,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 6.h,
        width: 100.w,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: boxShadow,
          border: border ??
              Border.all(
                width: 1.5,
                color: Color(0xffDDDDDD),
              ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: style,
            ),
            Icon(
              Icons.keyboard_arrow_right_sharp,
              color: ColorConst.blackColor,
            ),
          ],
        ),
      ),
    );
  }
}
