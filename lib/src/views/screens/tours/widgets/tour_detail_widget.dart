import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../models/tour/Tour_model.dart';
import '../../../../models/tour/tour_detail_model.dart';

Widget colorContainer(image, Color color, title) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(
        margin: EdgeInsets.fromLTRB(1, 7, 10, 6),
        padding: EdgeInsets.all(10),
        height: 50,
        width: 50,
        child: Image(image: AssetImage(image)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: color,
        )),
    Text(
      title,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.none,
          color: ColorConst.kBlackColor),
    ),
  ]);
}

Widget time(
  image,
  title,
  title2,
  context,
) {
  return Row(children: [
    InkWell(
      onTap: () {},
      child: Image(image: AssetImage(image)),
    ),
    SizedBox(
      width: 3.w,
    ),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: ColorConst.kBlackColor,
                decoration: TextDecoration.none),
          ),
          Text(
            title2,
            // maxLines: 1,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: ColorConst.kBlackColor,
                decoration: TextDecoration.none),
          ),
        ],
      ),
    ),
  ]);
}

Widget points(title, image, context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
    Image(image: AssetImage('assets/images/right.png')),
    SizedBox(
      height: 40,
    ),
    Padding(padding: EdgeInsets.all(10)),
    Text(
      title,
      style: textTheme.headlineMedium
          ?.copyWith(fontWeight: FontWeight.w400, color: ColorConst.blackColor),
    ),
  ]);
}

Widget Payment(context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return Container(
    padding: EdgeInsets.all(15),
    height: 169,
    width: 336,
//
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: ColorConst.kGrayColor,
        width: 1,
      ),
      color: Color.fromARGB(255, 246, 252, 255),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Package Details',
          style: textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w600, color: ColorConst.blackColor),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pay',
              style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500, color: ColorConst.blackColor),
            ),
            Text(
              '',
              style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500, color: ColorConst.blackColor),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tax',
              style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500, color: ColorConst.blackColor),
            ),
            Text(
              '\$5.00',
              style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500, color: ColorConst.blackColor),
            ),
          ],
        ),
        Image(image: AssetImage('assets/images/Line.png')),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w600, color: ColorConst.blackColor),
            ),
            Text(
              '\$605',
              style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w600, color: ColorConst.blackColor),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildImage({required TourImage imagepath}) {
  return Container(
      // padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(2),
      width: 200,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://nodejs.hackerkernel.com/hexatour/public${imagepath.imagepath}'),
              fit: BoxFit.cover),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 231, 227, 227),
                spreadRadius: 2,
                offset: Offset(1, 3),
                blurRadius: 3.0)
          ],
          color: ColorConst.whiteColor,
          borderRadius: BorderRadius.circular(10)));
}

Widget help(
    {required String title,
    required Widget widget,
    required TextTheme theme,
    padding}) {
  return Padding(
    padding: padding ?? EdgeInsets.only(bottom: 2.h, left: 3.w, right: 3.w),
    child: Column(
      // mainAxisAlignment: MainAxisAlignmen,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w500, color: ColorConst.blackColor),
        ),
        widget
      ],
    ),
  );
}

Widget Tours({TourImages? imagepath}) {
  return Container(
      // padding: EdgeInsets.all(6),
      // margin: EdgeInsets.all(8),
      width: 128.w,
      child: InkWell(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://nodejs.hackerkernel.com/hexatour/public${imagepath?.imagepath}'),
              fit: BoxFit.fill),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 231, 227, 227),
                spreadRadius: 2,
                offset: Offset(1, 3),
                blurRadius: 3.0)
          ],
          color: ColorConst.whiteColor,
          borderRadius: BorderRadius.circular(6)));
}
