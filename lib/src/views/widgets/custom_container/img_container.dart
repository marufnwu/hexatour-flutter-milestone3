import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/views/widgets/buttons/custom_button.dart';
import 'package:sizer/sizer.dart';


class ImgContainer extends StatelessWidget {
  final String img;
  final String name;
  final String price;
  final String description;
  final String btnName;
  final Function() onTap;
  const ImgContainer(
      {
        required this.img,
        required this.name,
        this.price = '0',
        required this.description,
        required this.btnName,
        required this.onTap,
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Container(
      height: 46.h,
      width: 100.w,
      margin: EdgeInsets.only(top: 1.5.h),
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xffEDEDED), width: 0.4),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(223, 217, 217, 0.25),
              offset: Offset(0, 10),
              blurRadius: 15,
            ),
            BoxShadow(
                color: ColorConst.whiteColor,
                offset: Offset(0.0, 0.0),
                blurRadius: 0,
                spreadRadius: 0)
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            img,
            fit: BoxFit.fill,
            height: 23.h,
            width: 100.w,
          ),
        ),
        SizedBox(
          height: 0.2.h,
        ),
        Text(
          name,
          style: theme.headlineMedium?.copyWith(
              color: ColorConst.blackColor, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 0.2.h,
        ),
        Text(
          description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: theme.headlineMedium?.copyWith(
            color: ColorConst.blackColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 0.4.h,
        ),
        SvgPicture.asset("assets/images/divline.svg"),
        SizedBox(
          height: 1.h,
        ),
        Row(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                widthFactor: 1.2,
                child: SvgPicture.asset(
                  "assets/images/price.svg",
                  height: 4.h,
                )),
            col(text1: "Price", text2: "\$$price", theme: theme),
            Align(
                alignment: Alignment.centerLeft,
                widthFactor: 1.2,
                child: SvgPicture.asset(
                  "assets/images/cal.svg",
                  height: 4.h,
                )),
            col(text1: "Days left", text2: "2 Days", theme: theme),
            Expanded(
                child: CustomButton(
              name: btnName,
              onTap: onTap,
              color: ColorConst.kGreenColor,
              height: 4.h,
              textStyle: theme.headlineMedium,
              radius: 10,
            ))
          ],
        )
      ]),
    );
  }
}

Widget col(
    {required String text1, required String text2, required TextTheme theme}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: theme.headlineMedium?.copyWith(color: ColorConst.blackColor),
        ),
        Text(
          text2,
          style: theme.headlineMedium?.copyWith(
              color: ColorConst.blackColor, fontWeight: FontWeight.w500),
        )
      ],
    ),
  );
}
