import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/views/widgets/buttons/custom_button.dart';
import 'package:sizer/sizer.dart';

class ViewBookingPage extends StatelessWidget {
  final String btnName;
  final Function() onTap;
  const ViewBookingPage(
      {required this.btnName, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: DraggableFab(
        child: FloatingActionButton(
          onPressed: (() {}),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: SvgPicture.asset(
            "assets/icons/whatsapp.svg",
            height: 6.h,
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("My Booking"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: ColorConst.kGreenColor,
            image: DecorationImage(
              image: AssetImage("assets/images/appbar.png"),
            ),
          ),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Image.network(
            'https://t4.ftcdn.net/jpg/02/40/98/49/360_F_240984942_eZXNlIqQ0SRIMyIZMOqVYG3kAmKqpCPJ.jpg'),
        SizedBox(height: 2.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Umrah Visa Package",
              style: theme.displaySmall?.copyWith(color: ColorConst.blackColor),
            ),
            SizedBox(height: 1.h),
            Text(
              "So, if you are planning to do Umrah from Dhaka! Book with ITS Holidays Limited – as we serve the best-quality Umrah Package fat incomparable standard prices, fully committed that all of your Umrah related needs",
              style: theme.displaySmall?.copyWith(
                  color: ColorConst.blackColor, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 2.h,
            ),
            SvgPicture.asset("assets/images/divline.svg"),
            SizedBox(
              height: 2.h,
            ),
            Row(
              children: [
                Align(
                    alignment: Alignment.center,
                    widthFactor: 1.2,
                    child: SvgPicture.asset(
                      "assets/images/price.svg",
                      height: 6.h,
                    )),
                col(text1: "Price", text2: "\$200.20", theme: theme),
                Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: 1.2,
                    child: SvgPicture.asset(
                      "assets/images/price.svg",
                      height: 6.h,
                    )),
                col(text1: "Days left", text2: "2 Days", theme: theme),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            SvgPicture.asset("assets/images/divline.svg"),
            SizedBox(height: 6.h),
            CustomButton(
              height: 6.h,
              name: btnName,
              onTap: onTap,
              color: ColorConst.kGreenColor,
              width: 100.w,
              textStyle: theme.displaySmall,
              radius: 10,
            )
          ]),
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
          style: theme.displaySmall?.copyWith(color: ColorConst.blackColor),
        ),
        Text(
          text2,
          style: theme.displaySmall?.copyWith(
              color: ColorConst.blackColor, fontWeight: FontWeight.w500),
        )
      ],
    ),
  );
}
