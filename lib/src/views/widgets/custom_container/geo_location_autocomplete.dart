import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

Widget geoLocationAutocompleteContainer(suggestions, onTap) {
  return Obx(() {
    if (suggestions.length != 0)
      return Container(
        constraints:
            BoxConstraints(minHeight: 5.h, minWidth: 100.w, maxHeight: 20.h),
        decoration: BoxDecoration(
          color: ColorConst.whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                      visualDensity: VisualDensity.compact,
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      leading: const Icon(Icons.location_on),
                      onTap: onTap(index),
                      title: Text(suggestions[index].description));
                }))),
      );
    return SizedBox();
  });
}
