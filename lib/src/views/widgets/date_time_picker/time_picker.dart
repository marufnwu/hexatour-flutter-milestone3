import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

class TimePicker extends StatelessWidget {
  final Function(String time)? onSelect;

  const TimePicker({this.onSelect, super.key});

  @override
  Widget build(BuildContext context) {
    RxString? showValue = 'Select Time'.obs;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      alignment: Alignment.center,
      height: 6.h,
      padding: EdgeInsets.only(left: 4.w),
      decoration: BoxDecoration(
        color: Color(0xffF4F6F8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => Text(
              showValue.value,
              style: textTheme.displaySmall?.copyWith(
                  color: showValue == "Select Time"
                      ? Color(0xffC6C5C5)
                      : ColorConst.blackColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          IconButton(
            splashColor: Colors.transparent,
            onPressed: () async {
              final TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              if (picked != null) {
                showValue.value = picked.format(context);
                print(showValue.value);
                print('noo');
                onSelect!(showValue.value);
              }
            },
            icon: Icon(
              Icons.access_time_outlined,
              color: Color(0xffA9ABAC),
            ),
          )
        ],
      ),
    );
  }
}
