import 'package:flutter/material.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

class DisabledContainer extends StatelessWidget {
  final String text;
  final Icon? icon;
  final isElipsis;

  const DisabledContainer(
      {required this.text, this.icon, this.isElipsis = false, super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      height: 6.h,
      padding: EdgeInsets.only(left: 4.w, right: 2.w, top: 1.h, bottom: 1.h),
      decoration: BoxDecoration(
        color: ColorConst.whiteShadow,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        if (this.isElipsis)
          SizedBox(width: 80.w, child: getTitle(text, textTheme)),
        if (!this.isElipsis) getTitle(text, textTheme),
        icon ?? SizedBox()
      ]),
    );
  }
}

Widget getTitle(text, textTheme) {
  return Text(
    text,
    style: textTheme.displaySmall
        ?.copyWith(fontWeight: FontWeight.w500, color: ColorConst.blackColor),
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
  );
}
