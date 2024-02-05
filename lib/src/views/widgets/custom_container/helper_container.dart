import 'package:flutter/material.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

class HelperCon extends StatelessWidget {
  final String title;
  final Widget widget;
  final TextStyle? style;
  final EdgeInsets? padding;
  const HelperCon(
      {required this.title,
      required this.widget,
      this.padding,
      this.style,
      super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Padding(
      padding: padding ?? EdgeInsets.only(bottom: 2.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title == ""
              ? SizedBox()
              : Text(
                  title,
                  style: style ??
                      theme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorConst.blackColor),
                  overflow: TextOverflow.ellipsis,
                ),
          widget
        ],
      ),
    );
  }
}
