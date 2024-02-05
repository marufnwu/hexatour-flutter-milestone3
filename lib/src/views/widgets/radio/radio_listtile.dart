import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';

class CustomRadio extends StatelessWidget {
  final String title;
  final RxString groupVal;
  final Function(dynamic) onChanged;
  const CustomRadio(
      {required this.title,
      required this.groupVal,
      required this.onChanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RadioListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: ColorConst.blackColor, fontWeight: FontWeight.w500),
        ),
        value: title,
        groupValue: groupVal.value,
        controlAffinity: ListTileControlAffinity.platform,
        onChanged: (value) {
          groupVal.value = value.toString();
          onChanged(value);
        },
        activeColor: ColorConst.kGreenColor,
        visualDensity: VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity),
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
