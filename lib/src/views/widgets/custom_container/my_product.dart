import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/core/utils/constant.dart';
import 'package:sizer/sizer.dart';

class MyProductContainer extends StatelessWidget {
  final String name;
  final String image;
  final String amount;
  final String btn1name;
  final String? btn2name;
  final Function() btn1OnTap;
  final Function()? btn2OnTap;
  final String? quantity;
  const MyProductContainer(
      {required this.name,
      required this.image,
      required this.amount,
      required this.btn1name,
      required this.btn1OnTap,
        this.quantity,
      this.btn2name,
      this.btn2OnTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 1.h),
        padding: EdgeInsets.all(1.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(223, 217, 217, 0.25),
              offset: Offset(0, 10),
              blurRadius: 15,
            ),
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ],
          border: Border.all(
            width: 0.4,
            color: const Color(0xffEDEDED),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 11.h,
                    width: 5.w,
                    margin: EdgeInsets.only(top: 0.6.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        ApiEndpoints.imageurl+image,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.transparent,
                            child: const Icon(Icons.room_service, size: 50),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 6.h,
                            child: Text(
                              name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.displaySmall?.copyWith(
                                  color: ColorConst.blackColor,
                                  fontSize: 12.sp),
                            ),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Quantity: $quantity",
                                style: textTheme.displaySmall?.copyWith(
                                    color: ColorConst.blackColor,
                                    fontSize: 12.sp),
                              ),
                              Text(
                                amount,
                                style: textTheme.displaySmall?.copyWith(
                                    color: ColorConst.blackColor,
                                    fontSize: 12.sp),
                              ),
                            ],
                          ),
                        ]),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            SvgPicture.asset("assets/images/divline.svg"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: btn1OnTap,
                  child: Text(
                    btn1name,
                    style: textTheme.displaySmall
                        ?.copyWith(color: Color(0xff3B9E3B), fontSize: 12.sp),
                  ),
                ),
                TextButton(
                  onPressed: btn2OnTap,
                  child: Text(
                    btn2name ?? '',
                    style: textTheme.displaySmall
                        ?.copyWith(color: Color(0xffFF1F00), fontSize: 12.sp),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
