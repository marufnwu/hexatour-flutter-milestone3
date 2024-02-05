import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/core/theme/text_style.dart';
import 'package:hexatour/src/views/screens/home/home_page.dart';
import 'package:sizer/sizer.dart';

class SuccessServicePage extends StatefulWidget {
  String transactionId;
  int date;

  SuccessServicePage(
      {super.key, required this.transactionId, required this.date});

  @override
  State<SuccessServicePage> createState() => _SuccessServicePageState();
}

class _SuccessServicePageState extends State<SuccessServicePage> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: ColorConst.kGreenColor,
          ),
          Positioned(
            top: 39.h,
            left: 10.w,
            child: Image.asset(
              "assets/images/donation/donation_img_pay.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 37.h,
            right: 10.w,
            child: Image.asset(
              "assets/images/donation/donation_img_pay.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              top: 50.h,
              child: SizedBox(
                width: 100.w,
                child: Image.asset(
                  "assets/images/donation/donation_circle.png",
                  fit: BoxFit.cover,
                ),
              )),
          Positioned(
            top: 0.h,
            right: 0,
            child: Image.asset(
              "assets/images/donation/donation_img_ribon.png",
              scale: 1.3,
            ),
          ),
          Positioned(
            top: 10.h,
            left: 15.w,
            child: Row(
              children: [
                Image.asset(
                  "assets/images/donation/donation_img_cloud_small.png",
                ),
                SizedBox(
                  width: 8.w,
                ),
                Image.asset(
                  "assets/images/donation/donation_img_check.png",
                  scale: 1.2,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Image.asset(
                  "assets/images/donation/donation_img_cloud.png",
                ),
              ],
            ),
          ),
          Positioned(
            top: 22.h,
            left: 10.w,
            child: SizedBox(
              width: 80.w,
              child: Column(
                children: [
                  Text(
                    "Donation successfully Your donation is done successfully",
                    textAlign: TextAlign.center,
                    style: textTheme.displayMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Image.asset(
                    "assets/images/donation/donation_img.png",
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConst.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Transaction ID : ",
                            style: textStyleDetailHead,
                          ),
                          Text(
                            "${widget.transactionId}",
                            style: textStyleDetailHead,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Divider(
                            color: Color(0xffDDDDDD),
                            height: 0.5,
                            endIndent: 35.w,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                          
                            "Date - ${(new DateTime.now())}",
                            textAlign: TextAlign.center,
                            style: textStyleDetailHead,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 8.h,
            left: 2.h,
            child: IconButton(
                splashColor: Colors.transparent,
                onPressed: () {
                  Get.offAll(Homepage());
                },
                icon: Icon(
                  Icons.close,
                  color: Color.fromARGB(255, 246, 252, 255),
                )),
          )
        ],
      ),
    );
  }
}
