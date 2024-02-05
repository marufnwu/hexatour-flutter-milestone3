import 'package:flutter/material.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

class CheckBox extends StatefulWidget {
  final String title;
  final bool value;
  final Function(dynamic) onChanged;
  final OutlinedBorder? shape;
  final TextStyle? style;
  const CheckBox(
      {required this.title,
      required this.value,
      required this.onChanged,
      this.style,
      this.shape,
      super.key});
  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 3.5.h),
        padding: EdgeInsets.only(left: 2.w),
        height: 7.h,
        width: 70.w,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 254, 254),
            border: Border.all(
                width: 2, color: const Color.fromARGB(26, 154, 149, 149)),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: widget.style,
            ),
            Container(
              margin: EdgeInsets.only(right: 2.w),
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  border: Border.all(
                      width: 2.0,
                      color: widget.value == true
                          ? ColorConst.kGreenColor
                          : ColorConst.greyColor)),
              child: Checkbox(
                  checkColor: ColorConst.kGreenColor,
                  fillColor: MaterialStateProperty.all<Color>(Colors.white),
                  value: widget.value,
                  shape: widget.shape,
                  onChanged: widget.onChanged),
            )
          ],
        ));
  }
}
