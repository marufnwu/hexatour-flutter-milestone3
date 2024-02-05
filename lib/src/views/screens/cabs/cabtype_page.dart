import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/theme/colors.dart';
import '../../../controllers/cab_controller.dart';
import '../../../models/cab/cab_model.dart';
import '../../widgets/buttons/custom_button.dart';
import '../service/widgets/service_widgets.dart';
import 'cab_finalising.dart';

class CabType extends StatefulWidget {
  String type;
  double totalKm;
  String mobile;
  String dateOfTravel;
  String timeOfTravel;

  CabType(
      {super.key,
      required this.type,
      required this.totalKm,
      required this.dateOfTravel,
      required this.timeOfTravel,
      required this.mobile});

  @override
  State<CabType> createState() => _CabTypeState();
}

class _CabTypeState extends State<CabType> {
  final cabController = Get.find<CabController>();
  var isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConst.kGreenColor,
          title: Text('Cabs Available'),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(2.h),
              itemCount: cabController.itemlist.length,
              itemBuilder: (context, index) {
                return exclusivecabtype(
                    onTap: () {
                      String price = '0';

                      if (widget.type == 'Outdoor') {
                        price =
                            cabController.itemlist[index]['price'].toString();
                      } else {
                        price = cabController.itemlist[index]['price_per_km']
                            .toString();
                      }

                      Get.off(CabFinalising(
                        cabId: cabController.itemlist[index]['id'].toString(),
                        seater:
                            cabController.itemlist[index]['cab_size'].toString(),
                        cabType: cabController.itemlist[index]['cab_type'],
                        drop: '',
                        pickup: '',
                        price: price,
                        minimumBookingAmount: cabController
                            .itemlist[index]['minimum_booking_amount']
                            .toString(),
                        type: widget.type,
                        totalKm: widget.totalKm,
                        contactNumber: widget.mobile,
                        date: widget.dateOfTravel,
                        time: widget.timeOfTravel,
                      ));
                    },
                    context: context,
                    cabSize: cabController.itemlist[index]['cab_size'].toString(),
                    cabType: cabController.itemlist[index]['cab_type'].toString(),
                    imagepath: cabController.itemlist[index]['image']['imagepath'],
                    cab_status: cabController.itemlist[index]['cab_status'],
                    cab_number: cabController.itemlist[index]['cab_number'].toString(),
                    contact_number: widget.mobile,
                    price: cabController.itemlist[index]['price'].toString(),
                    price_per_km:
                        cabController.itemlist[index]['price_per_km'].toString());

                //
              }),
        ));
  }
}

Widget exclusivecabtype(
    {required String cabSize,
    required String cab_status,
    required String imagepath,
    required String cab_number,
    required String contact_number,
    required String cabType,
    required String price,
    required String price_per_km,
    // required bool isSelected,
    context,
    required Function() onTap}) {
  TextTheme theme = Theme.of(context).textTheme;
  return InkWell(
      child: Container(
          height: 39.h,
          width: 100.w,
          margin: EdgeInsets.only(top: 1.5.h),
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              // border: Border.all(
              //     color: isSelected == true
              //         ? ColorConst.kGreenColor
              //         : Colors.transparent),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(33, 30, 30, 0.239),
                  offset: Offset(0, 10),
                  blurRadius: 15,
                ),
                BoxShadow(
                    color: Color.fromARGB(255, 245, 245, 245),
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0,
                    spreadRadius: 0)
              ]),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://nodejs.hackerkernel.com/hexatour/public${imagepath}',
                fit: BoxFit.fill,
                height: 20.h,
                width: 100.w,
              ),
            ),
            SizedBox(
              height: 0.8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                roo(
                    name1: cabSize,
                    name2: "Seater",
                    theme: theme,
                    style: theme.headlineMedium?.copyWith(
                        color: ColorConst.blackColor,
                        fontWeight: FontWeight.w600)),
                if (cabType != "outstation")
                  roo(
                      name1: 'price',
                      name2: ' \$' + price_per_km + '/km',
                      theme: theme,
                      style: theme.headlineMedium?.copyWith(
                          color: ColorConst.blackColor,
                          fontWeight: FontWeight.w600)),
              ],
            ),
            SizedBox(
              height: 0.4.h,
            ),
            SvgPicture.asset("assets/images/divline.svg"),
            SizedBox(
              height: 1.4.h,
            ),
            Text(cab_number,
                textAlign: TextAlign.center,
                style: theme.headlineMedium?.copyWith(
                    color: Color.fromARGB(255, 17, 18, 17),
                    fontWeight: FontWeight.w600)),

            CustomButton(
              name: 'select',
              onTap: onTap,
              right: 15,
              left: 50.w,
              // top: 2.h,
              bottom: 2.h,
              color: ColorConst.kGreenColor,
              height: 4.h,

              textStyle: theme.headlineMedium,
              radius: 7,
            ),
            // Text(cab_status,
            //     textAlign: TextAlign.center,
            //     style: theme.headlineMedium?.copyWith(
            //         color: Color.fromARGB(255, 129, 212, 129),
            //         fontWeight: FontWeight.w600)),

            //         CustomButton(
            //           name: 'select',
            //           onTap: onTap,
            //           right: 15,
            //           left: 50.w,
            //           top: 2.h,
            //           // bottom: 1.h,
            //           color: ColorConst.kGreenColor,
            //           height: 4.h,

            //           textStyle: theme.headlineMedium,
            //           radius: 7,
            //         ),

            // SizedBox(
            //   height: 3.h,
            // ),
            //   Row(
            //     children: [
            //       Expanded(
            //         child: CustomButton(
            //           name: 'select',
            //           onTap: onTap,
            //           right: 15,
            //           left: 5,
            //           color: ColorConst.kGreenColor,
            //           height: 5.h,
            //           textStyle: theme.headlineMedium,
            //           radius: 7,
            //         ),

            // ),

            //   ])
          ])));
}
