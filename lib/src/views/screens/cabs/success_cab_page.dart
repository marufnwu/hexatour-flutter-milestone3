import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/core/utils/Helpers.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/cab_controller.dart';
import '../home/home_page.dart';

class SuccessCabPage extends StatefulWidget {
  final String seater;
  final String? price;

  const SuccessCabPage(
      {required this.seater, required this.price, super.key, String? cabModal});

  @override
  State<SuccessCabPage> createState() => _SuccessCabPageState();
}

class _SuccessCabPageState extends State<SuccessCabPage> {
  final cabController = Get.find<CabController>();

  @override
  void initState() {
    print('whyynot');

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      body: Stack(children: [
        SizedBox(
          height: 130.h,
          width: 100.w,
          child: SvgPicture.asset(
            'assets/images/cabbook1.svg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            top: 26.h,
            left: 12.w,
            right: 12.w,
            child: Text(
              'Cab book successfully ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorConst.whiteColor,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            )),
        Positioned(
            top: 29.h,
            left: 12.w,
            right: 12.w,
            child: Text(
              ' Your ${widget.seater} Seater cab have been successfully booked ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorConst.whiteColor,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400),
            )),
        Positioned(
            top: 56.h,
            left: 23.w,
            child: Container(
              width: 58.w,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: ColorConst.whiteColor,
                  borderRadius: BorderRadius.circular(7)),
              child: Text('Booking ID - 1454785',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorConst.blackColor,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600)),
            )),
        ListView.builder(
            padding: EdgeInsets.only(top: 62.h),
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return paymentCard(
                  cabModal: cabController.itemlist[index]['cab_modal'].toString(),
                  price: !Helpers.isNull(widget.price)
                      ? widget.price.toString()
                      : cabController.itemlist[index]['price'].toString(),
                  contactNumber:
                      cabController.itemlist[index]['contact_number'].toString(),
                  cabNumber:
                      cabController.itemlist[index]['cab_number'].toString(),
                  pricePerKm:
                      cabController.itemlist[index]['price_per_km'].toString());
            }),
        Positioned(
          top: 4.h,
          child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                splashColor: Colors.transparent,
                onPressed: () {
                  Get.offAll(Homepage());
                },
                icon: Icon(
                  Icons.close,
                  color: Color.fromARGB(255, 246, 252, 255),
                )),
          ),
        ),
        // )),
      ]),
    );
  }
}

Widget paymentCard({
  // required String cabSize,

  required String cabNumber,
  required String contactNumber,
  required String pricePerKm,
  required String cabModal,
  required String price,
}) {
  return Container(
    height: 32.h,
    width: 90.w,
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.all(15),
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 254, 254),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(44, 43, 43, 0.247),
            offset: Offset(0, 10),
            blurRadius: 15,
          ),
        ],
        borderRadius: BorderRadius.circular(17)),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            card2('assets/images/card.svg', 'Car number', cabNumber),
            SizedBox(
              width: 3.w,
            ),
            card2('assets/images/c1.svg', 'Car model', cabModal),
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 242, 246, 254),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(contactNumber,
                    style: TextStyle(
                        color: ColorConst.blackColor,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600)),
              ),
              Container(
                // padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 234, 120, 59),
                    borderRadius: BorderRadius.circular(7)),
                child: IconButton(
                  onPressed: () {
                    Helpers.launchCaller(contactNumber);
                  },
                  icon: Icon(Icons.phone),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Text('Total pay: \$${price}',
            style: TextStyle(
                color: ColorConst.blackColor,
                fontSize: 17,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600))
      ],
    ),
  );
}

Widget card2(image, name, cab_numbe) {
  return Row(
    children: [
      Column(
        children: [
          Container(
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 247, 245, 244),
                borderRadius: BorderRadius.circular(7)),
            child: SvgPicture.asset(image),
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(name,
              style: TextStyle(
                  color: ColorConst.blackColor,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500)),
          Text(cab_numbe,
              style: TextStyle(
                  letterSpacing: 0.5,
                  color: ColorConst.blackColor,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600)),
        ],
      )
    ],
  );
}
