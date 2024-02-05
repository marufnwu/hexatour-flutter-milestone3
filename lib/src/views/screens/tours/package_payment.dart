import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/core/utils/constant.dart';
import 'package:hexatour/src/views/screens/cabs/widgets/cab_widgets.dart';
import 'package:hexatour/src/views/screens/offers/offer_detail.dart';
import 'package:hexatour/src/views/screens/tours/payment_done.dart';
import 'package:hexatour/src/views/screens/tours/widgets/tour_widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:dartz/dartz.dart' as dev;
import '../../../../core/utils/Helpers.dart';
import '../../../controllers/home_page_controller.dart';
import '../../../controllers/servive_payment_controller.dart';
import '../../../controllers/tour_controller.dart';
import '../../widgets/custom_container/custom_container_round.dart';
import '../../widgets/radio/radio_listtile.dart';

RxString groupVal = "Full Pay".obs;

class PackagePayment extends StatefulWidget {
  final String tourName;
  final String price;
  final String minimumBookingAmount;
  final String mobile;
  final String dateOfTravel;
  final String timeOfTravel;

  const PackagePayment(
      {required this.price,
      required this.minimumBookingAmount,
      required this.tourName,
      required this.dateOfTravel,
      required this.mobile,
      required this.timeOfTravel});
  @override
  State<PackagePayment> createState() => _PackagePaymentState();
}

class _PackagePaymentState extends State<PackagePayment> {
  final paymentController = Get.find<PaymentController>();
  final homepageController = Get.find<HomePageController>();
  final tourController = Get.find<TourController>();
  bool paymentLoading = false;
  Map<String, dynamic> offerApplied = {
    "discount_percent": 0,
    "flat_off": 0,
    "name": null
  };

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    discountAmount() {
      double price = Helpers.toDouble(widget.price);

      print(groupVal);
      return Helpers.calculateDiscountAmount(
          offerApplied['discount_percent'], price);
    }

    totalAmount() {
      double price = Helpers.toDouble(widget.price);

      return ((groupVal.toString() == 'Full Pay'
              ? price - discountAmount()
              : (Helpers.toDouble(widget.minimumBookingAmount))))
          .toString();
    }

    dueAmount() {
      return (Helpers.toDouble(widget.price) - discountAmount()) -
          (Helpers.toDouble(widget.minimumBookingAmount));
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140),
        child: AppBar(
          centerTitle: true,
          title: Text('Payment'),
          backgroundColor: Color(0xff90EE90),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                color: ColorConst.kGreenColor,
                image: DecorationImage(
                  image: AssetImage("assets/images/appbar.png"),
                ),
              ),
            ),
            titlePadding: EdgeInsets.only(top: 5.h, bottom: 1.h),
            title: Container(
              padding: EdgeInsets.all(5.0),
              height: 9.h,
              decoration: BoxDecoration(
                  color: Color(0xff8AE78A),
                  borderRadius: BorderRadius.circular(10)),
              width: 90.w,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "${widget.price}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              boxs(context),
              SizedBox(
                height: 4.h,
              ),
              CustomRadio(
                  title: "Full Pay",
                  groupVal: groupVal,
                  onChanged: (value) {
                    setState(() {
                      tourController.paymentType.value = value;
                      groupVal.value = "Full Pay";
                    });
                  }),
              Divider(
                height: 1,
                color: Color.fromARGB(255, 225, 231, 233),
                thickness: 1,
              ),
              CustomRadio(
                  title: "Minimum Pay",
                  groupVal: groupVal,
                  onChanged: (value) {
                    var a = 5000;
                    var b = 2;
                    tourController.paymentType.value = value;
                    var cab = (a / b).toString();
                    // cabController.payment.value = cab;
                    setState(() {
                      tourController.payment.value = cab;
                      groupVal.value = "Minimum Pay";
                    });
                  }),
              Divider(
                height: 1,
                color: Color.fromARGB(255, 225, 231, 233),
                thickness: 1,
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 1.h),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         "Price",
              //         style: Theme.of(context).textTheme.displaySmall?.copyWith(
              //             color: ColorConst.blackColor,
              //             fontWeight: FontWeight.w500),
              //       ),
              //       Text(
              //         '\$' +
              //             (groupVal.toString() == 'Full Pay'
              //                 ? widget.price
              //                 : widget.minimumBookingAmount),
              //         style: Theme.of(context).textTheme.displaySmall?.copyWith(
              //             color: ColorConst.blackColor,
              //             fontWeight: FontWeight.w500),
              //       ),
              //     ],
              //   ),
              // ),
              // Divider(
              //   height: 1,
              //   color: Color.fromARGB(255, 225, 231, 233),
              //   thickness: 1,
              // ),
              // if (!Helpers.isNull(offerApplied['name']))
              //   Padding(
              //     padding: EdgeInsets.symmetric(vertical: 1.h),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           "Discount",
              //           style: Theme.of(context)
              //               .textTheme
              //               .displaySmall
              //               ?.copyWith(
              //                   color: ColorConst.blackColor,
              //                   fontWeight: FontWeight.w500),
              //         ),
              //         Text(
              //           '-\$' + (discountAmount().toStringAsFixed(1)),
              //           style: Theme.of(context)
              //               .textTheme
              //               .displaySmall
              //               ?.copyWith(
              //                   color: ColorConst.blackColor,
              //                   fontWeight: FontWeight.w500),
              //         ),
              //       ],
              //     ),
              //   ),
              // if (!Helpers.isNull(offerApplied['name']))
              //   Divider(
              //     height: 1,
              //     color: Color.fromARGB(255, 225, 231, 233),
              //     thickness: 1,
              //   ),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 1.h),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         "Total",
              //         style: Theme.of(context).textTheme.displaySmall?.copyWith(
              //             color: ColorConst.blackColor,
              //             fontWeight: FontWeight.w500),
              //       ),
              //       Text(
              //         '\$' +
              //             (groupVal.toString() == 'Full Pay'
              //                 ? (Helpers.toInt(widget.price) - discountAmount())
              //                     .toString()
              //                 : (Helpers.toInt(widget.minimumBookingAmount) -
              //                         discountAmount())
              //                     .toString()),
              //         style: Theme.of(context).textTheme.displaySmall?.copyWith(
              //             color: ColorConst.blackColor,
              //             fontWeight: FontWeight.w500),
              //       ),
              //     ],
              //   ),
              // ),
              // Divider(
              //   height: 1,
              //   color: Color.fromARGB(255, 225, 231, 233),
              //   thickness: 1,
              // ),
              SizedBox(
                height: 2.h,
              ),
              CusCon(
                onTap: () async {
                  dev.Tuple2 result =
                      await homepageController.getOffertype(value: 'tours');
                  if (result.value1) {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => OfferDetail())))
                        .then((data) => {
                              if (!Helpers.isNull(data))
                                {
                                  offerApplied = data,
                                  print("offer selected is : $offerApplied"),
                                  setState(() {})
                                }
                            });
                  } else {
                    Helpers.showSnackbar(
                        text: 'Currently no offers available',
                        color: ColorConst.redColor,
                        context: context);
                  }
                },
                name: Helpers.isNull(offerApplied['name'])
                    ? "Available Offers"
                    : offerApplied['name'],
                style: textTheme.displaySmall!.copyWith(
                    color: ColorConst.blackColor, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Fare Breakup",
                style: textTheme.displaySmall!
                    .copyWith(color: ColorConst.blackColor),
              ),
              Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 4.w),
                margin: EdgeInsets.only(bottom: 2.h, top: 2.h),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/receipt.png"),
                      fit: BoxFit.fill),
                ),
                child: Column(children: [
                  roo(
                      name1: "Total fare cost",
                      name2:
                          'SAR' + (Helpers.toDouble(widget.price)).toString(),
                      theme: textTheme),
                  Obx(() => (groupVal.toString() != 'Full Pay')
                      ? roo(
                          name1: "Min payment",
                          name2: '\SAR' +
                              (Helpers.toDouble(widget.minimumBookingAmount))
                                  .toString(),
                          theme: textTheme)
                      : SizedBox()),
                  if (!Helpers.isNull(offerApplied['name']))
                    Obx(() => roo(
                        name1: "Discount",
                        name2: '-SAR' + (discountAmount().toStringAsFixed(1)),
                        theme: textTheme)),
                  SizedBox(height: 1.5.h),
                  Image.asset(
                    "assets/images/Line.png",
                    fit: BoxFit.fitWidth,
                    width: 100.w,
                  ),
                  SizedBox(
                    height: 1.8.h,
                  ),
                  Obx(() => (groupVal.toString() != 'Full Pay')
                      ? roo(
                          padding: EdgeInsets.only(bottom: 0.12.h),
                          name1: "Amount Due",
                          name2: 'SAR' + dueAmount().toString(),
                          theme: textTheme,
                          style: textTheme.displaySmall?.copyWith(
                              color: ColorConst.redColor,
                              fontWeight: FontWeight.w500))
                      : SizedBox()),
                  SizedBox(
                    height: 1.8.h,
                  ),
                  Obx(() => roo(
                      name1: "Final fare cost",
                      name2: 'SAR' + totalAmount().toString(),
                      theme: textTheme)),
                ]),
              ),
              SizedBox(
                height: 10.h,
              ),
              if (paymentLoading)
                CircularProgressIndicator(
                  color: ColorConst.greenColor,
                ),
              if (!paymentLoading)
                ElevatedButton(
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
                        padding: MaterialStateProperty.resolveWith<
                            EdgeInsetsGeometry>((Set<MaterialState> states) {
                          return const EdgeInsets.fromLTRB(70, 13, 70, 13);
                        })),
                    onPressed: () async {
                      String paymentType =
                          groupVal.value == 'Full Pay' ? 'full' : 'partial';

                      setState(() {
                        paymentLoading = true;
                      });

                      dev.Tuple2 result = await paymentController.tourPaymentType(
                          tour_id:
                              tourController.tourDetails.value.id.toString(),
                          destination_id: tourController
                              .tourDetails.value.destinationId
                              .toString(),
                          travel_date:
                              '${widget.dateOfTravel}',
                          payment_type: paymentType,
                          contact_number: widget.mobile,
                          currency: Payment.PaymentCurrency,
                          due_amount: paymentType == 'full'
                              ? '0'
                              : dueAmount().toString(),
                          total_amount: totalAmount().toString(),
                          source_id: tourController.tourDetails.value.sourceId
                              .toString(),
                          payment_method: "card");
                      setState(() {
                        paymentLoading = false;
                      });
                      if (result.value1) {
                        Helpers.showSnackbar(
                            text: "Tour Booked Successfully",
                            color: ColorConst.greenColor,
                            context: context);
                        Get.offAll(PaymentDone());
                      } else {
                        Helpers.showSnackbar(
                            text: result.value2,
                            color: ColorConst.redColor,
                            context: context);
                      }
                    },
                    child: Text(
                      "Pay Now",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins'),
                    )),
            ],
          )),
    );
  }
}
