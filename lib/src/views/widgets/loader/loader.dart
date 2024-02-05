import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

Widget Loader() {
  return Center(
    child: CircularProgressIndicator(
      color: ColorConst.primarySwatchColor,
    ),
  );
}
