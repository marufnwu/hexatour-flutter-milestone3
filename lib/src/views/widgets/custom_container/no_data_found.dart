import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

Widget NoDataFound(title, context) {
  TextTheme theme = Theme.of(context).textTheme;
  return Center(
    child: Text(
      title,
      style: theme.displaySmall
          ?.copyWith(fontWeight: FontWeight.w500, color: ColorConst.blackColor),
    ),
  );
}
