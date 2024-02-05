import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

class CustomDropDown extends StatelessWidget {
  final RxString? hint;
  final List<DropdownMenuItem<dynamic>>? items;
  final Color? color;
  final Function(dynamic)? onChanged;
  const CustomDropDown(
      {this.hint, this.items, this.color, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<dynamic>(
        hint: Obx(() => Text(
              hint!.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
        items: items,
        menuMaxHeight: 30.h,
        
        isExpanded: true,
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w500, color: ColorConst.blackColor),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 2.w,),
          fillColor: color ?? ColorConst.whiteShadow,
          filled: true,
          enabledBorder: OutlineInputBorder(
              gapPadding: 0,
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 0.1, color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 0.1, color: Colors.transparent),
            gapPadding: 0,
          ),
        ),
        onChanged: (value) {
          hint?.value = value.toString();
          onChanged!(value);
        });
  }
}
