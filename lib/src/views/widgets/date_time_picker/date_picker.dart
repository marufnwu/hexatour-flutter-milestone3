import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class DatePicker extends StatelessWidget {
  final RxString? value;
  final Function(String date)? onSelect;
  final firstDate;
  final isTimePicker;

  const DatePicker(
      {required this.value,
      this.onSelect,
      this.firstDate,
      this.isTimePicker = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    RxString? showValue =
        this.isTimePicker ? 'Select Time'.obs : 'Select Date'.obs;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
        height: 6.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xffF4F6F8), borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.only(left: 4.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Text(
                showValue.value,
                style: textTheme.displaySmall?.copyWith(
                    color:
                        showValue == "Select Date" || showValue == "Select Time"
                            ? Color(0xffC6C5C5)
                            : ColorConst.blackColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
            IconButton(
              splashColor: Colors.transparent,
              onPressed: () async {
                var picked;
                if (!isTimePicker) {
                  picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: firstDate ?? DateTime(1990),
                      lastDate: DateTime.utc(2099));
                } else {
                  picked = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                }
                          
                if (picked != null) {
                  if (this.isTimePicker) {
                    showValue.value = '${picked.hour}:${picked.minute}:00';
                    onSelect!(showValue.value);
                  } else {
                    showValue.value = DateFormat('yyyy-MM-dd').format(picked);
                    onSelect!(showValue.value);
                  }
                }
              },
              icon: Icon(
                Icons.calendar_today_outlined,
                color: Color(0xffA9ABAC),
              ),
            )
          ],
        ));
  }
}
