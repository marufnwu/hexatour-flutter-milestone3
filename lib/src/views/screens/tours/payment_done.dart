import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';


import 'package:sizer/sizer.dart';

import '../home/home_page.dart';

class PaymentDone extends StatefulWidget {
  const PaymentDone({super.key});

  @override
  State<PaymentDone> createState() => _PaymentDoneState();
}

class _PaymentDoneState extends State<PaymentDone> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  splashColor: Color.fromRGBO(0, 0, 0, 0),
                  onPressed: () {
                    Get.offAll(Homepage());
                  },
                  icon: Icon(
                    Icons.close,
                    color: Color.fromARGB(255, 20, 21, 21),
                  )),
            ),
            SizedBox(height: 11.h),
            Image(
              image: AssetImage('assets/images/order.png'),
              height: 30.h,
              width: 30.h,
            ),
            Text('Order Placed Successfully!',
                textAlign: TextAlign.center,
                style: textTheme.displaySmall!.copyWith(
                    color: ColorConst.blackColor, fontWeight: FontWeight.w600)),
            SizedBox(height: 1.h),
            Text(
                'Thank you for placing your order. we are glad to serve you on your journey',
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium!.copyWith(
                    color: ColorConst.blackColor, fontWeight: FontWeight.w500)),
            SizedBox(height: 3.h),
            Text('Order ID: 145236',
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium!.copyWith(
                    color: ColorConst.blackColor, fontWeight: FontWeight.w600)),
            SizedBox(height: 1.h),
            Container(
              padding: EdgeInsets.fromLTRB(75, 7, 75, 9),
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder?>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorConst.kGreenColor),
                      shadowColor: MaterialStateProperty.all<Color>(
                          ColorConst.kGreenColor),
                      elevation: MaterialStateProperty.all<double>(13.0),
                      padding:
                          MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                              (Set<MaterialState> states) {
                        return const EdgeInsets.fromLTRB(8, 13, 8, 13);
                      })),
                  onPressed: () {
                    Get.offAll(Homepage());
                  },
                  child: Text("OK")),
            ),
          ],
        ),
      )),
    );
  }
}
