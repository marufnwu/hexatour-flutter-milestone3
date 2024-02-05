import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/src/views/screens/cabs/success_cab_page.dart';
import 'package:hexatour/src/views/screens/cabs/widgets/cab_widgets.dart';
import 'package:hexatour/src/views/screens/offers/offer_detail.dart';
import 'package:sizer/sizer.dart';
import 'package:dartz/dartz.dart' as dev;
import '../../../../core/theme/colors.dart';
import '../../../../core/utils/Helpers.dart';
import '../../../controllers/cab_controller.dart';
import '../../../controllers/home_page_controller.dart';
import '../../../controllers/servive_payment_controller.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/custom_container/custom_container_round.dart';
import '../../widgets/custom_container/disabled_text_container.dart';
import '../../widgets/custom_container/helper_container.dart';
import '../../widgets/radio/radio_listtile.dart';

RxString groupVal = "Full Pay".obs;

class CabFinalising extends StatefulWidget {
  final String cabType;
  final String cabId;
  final String? package;
  final String pickup;
  final String drop;
  final String? price;
  final String? minimumBookingAmount;
  final String? date;
  final String? time;
  final String seater;
  final String? cabModal;
  final String? cabNumber;
  final String contactNumber;
  final String? price_per_km;
  String type;
  double totalKm;

  CabFinalising(
      {required this.cabType,
      required this.cabId,
      this.package,
      this.cabModal,
      this.cabNumber,
      required this.contactNumber,
      required this.pickup,
      required this.drop,
      this.date,
      this.time,
      this.price_per_km,
      required this.price,
      this.minimumBookingAmount = '0',
      required this.seater,
      required this.type,
      required this.totalKm,
      super.key});

  @override
  State<CabFinalising> createState() => _CabFinalisingState();
}

class _CabFinalisingState extends State<CabFinalising> {
  final cabController = Get.find<CabController>();
  final paymentController = Get.find<PaymentController>();
  final homepageController = Get.find<HomePageController>();
  bool paymentLoading = false;
  Map<String, dynamic> offerApplied = {
    "discount_percent": 0,
    "flat_off": 0,
    "name": null
  };

  discountAmount() {
    double price = 0;

    if (isIntercity()) {
      price = Helpers.toInt(widget.price) * Helpers.toDouble(widget.totalKm);
    } else {
      price = Helpers.toDouble(widget.price);
    }

    print(groupVal);
    return Helpers.calculateDiscountAmount(
        offerApplied['discount_percent'], price);
    // groupVal.toString() == 'Full Pay' ? (price) : ((price) / 2));
  }

  totalAmount() {
    double price = 0;

    if (isIntercity()) {
      price = Helpers.toInt(widget.price) * Helpers.toDouble(widget.totalKm);
    } else {
      price = Helpers.toDouble(widget.price);
    }

    return ((groupVal.toString() == 'Full Pay'
            ? price - discountAmount()
            : (Helpers.toDouble(widget.minimumBookingAmount))))
        .toString();
  }

  dueAmount() {
    return Helpers.toDouble(widget.price) -
        (Helpers.toDouble(widget.minimumBookingAmount) + discountAmount());
  }

  isIntercity() {
    print(groupVal);
    return widget.cabType != 'outstation';
  }

  @override
  void dispose() {
    groupVal.value = 'Full Pay';
    // TODO: implement dispose
    super.dispose();
  }

  var b = 2;
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text("Book Cab Details"),
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
        body: SingleChildScrollView(
            padding: EdgeInsets.all(2.h),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              HelperCon(
                title: "Cab Service Type",
                widget: DisabledContainer(
                  text: widget.cabType,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: ColorConst.blackColor,
                  ),
                ),
              ),
              // if (widget.cabType != "in city" &&
              //     widget.package != "Select Package")
              //   HelperCon(
              //     title: "Package",
              //     widget: DisabledContainer(
              //       text: cabController.package.value,
              //       icon: Icon(
              //         Icons.arrow_drop_down,
              //         color: ColorConst.blackColor,
              //       ),
              //     ),
              //   ),
              HelperCon(
                title: "Pickup Location",
                widget: DisabledContainer(
                    text: cabController.pickup.value, isElipsis: true),
              ),
              HelperCon(
                title: "Drop Destination",
                widget: DisabledContainer(
                    text: cabController.drop.value, isElipsis: true),
              ),
              if (widget.cabType != "in city")
                HelperCon(
                  title: "Date of Travel",
                  widget: DisabledContainer(
                    text: cabController.date.value,
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: Color(0xffA9ABAC),
                    ),
                  ),
                ),
              if (widget.cabType != "in city")
                HelperCon(
                  title: "Time of Travel",
                  widget: DisabledContainer(
                    text: cabController.time.value,
                    icon: Icon(
                      Icons.access_time_outlined,
                      color: Color(0xffA9ABAC),
                    ),
                  ),
                ),
              HelperCon(
                title: "Car Size",
                widget: DisabledContainer(text: widget.seater),
              ),
              CusCon(
                onTap: () async {
                  dev.Tuple2 result =
                      (await homepageController.getOffertype(value: 'cab'));
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
                        text: 'Currently no offers availale',
                        color: ColorConst.redColor,
                        context: context);
                  }
                },
                name: Helpers.isNull(offerApplied['name'])
                    ? "Available Offers"
                    : offerApplied['name'],
                style: theme.displaySmall!.copyWith(
                    color: ColorConst.blackColor, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 1.h,
              ),
              CusCon(
                onTap: () {},
                name: "Cancellation Policy",
                style: theme.displaySmall!.copyWith(
                    color: ColorConst.blackColor, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 1.h),
              if (!isIntercity())
                CustomRadio(
                    title: "Full Pay",
                    groupVal: groupVal,
                    onChanged: (value) {
                      groupVal.value = "Full Pay";
                    }),
              if (!isIntercity())
                Divider(
                  color: Color(0xffE6E6E6),
                  height: 0,
                  thickness: 1,
                ),
              if (!isIntercity())
                CustomRadio(
                    title: "Minimum Pay",
                    groupVal: groupVal,
                    onChanged: (value) {
                      groupVal.value = "Minimum Pay";
                    }),
              SizedBox(
                height: 1.h,
              ),
              // Divider(
              //   color: Color(0xffE6E6E6),
              //   height: 0,
              //   thickness: 1,
              // ),
              // if (isIntercity())
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 1.h),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         !isIntercity() ? 'Price' : 'Price(km)',
              //         style: Theme.of(context).textTheme.displaySmall?.copyWith(
              //             color: ColorConst.blackColor,
              //             fontWeight: FontWeight.w500),
              //       ),
              //       Obx(
              //         () => Text(
              //           '\$' +
              //               (groupVal.toString() == 'Full Pay'
              //                   ? (Helpers.toDouble(widget.price)).toString()
              //                   : ((Helpers.toDouble(widget.price) / 2))
              //                       .toString()),
              //           style: Theme.of(context)
              //               .textTheme
              //               .displaySmall
              //               ?.copyWith(
              //                   color: ColorConst.blackColor,
              //                   fontWeight: FontWeight.w500),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              // Divider(
              //   height: 1,
              //   color: Color.fromARGB(255, 225, 231, 233),
              //   thickness: 1,
              // ),
              // if (isIntercity())
              //   Padding(
              //     padding: EdgeInsets.symmetric(vertical: 1.h),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           "Total Km",
              //           style: Theme.of(context)
              //               .textTheme
              //               .displaySmall
              //               ?.copyWith(
              //                   color: ColorConst.blackColor,
              //                   fontWeight: FontWeight.w500),
              //         ),
              //         Text(
              //           widget.totalKm.toString() + 'Km',
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
              // if (isIntercity())
              //   Divider(
              //     height: 1,
              //     color: Color.fromARGB(255, 225, 231, 233),
              //     thickness: 1,
              //   ),
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
              //     height: 0,
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
              //       Obx(
              //         () => Text(
              //           '\$' + totalAmount().toString(),
              //           style: Theme.of(context)
              //               .textTheme
              //               .displaySmall
              //               ?.copyWith(
              //                   color: ColorConst.blackColor,
              //                   fontWeight: FontWeight.w500),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              // Divider(
              //   height: 1,
              //   color: Color.fromARGB(255, 225, 231, 233),
              //   thickness: 1,
              // ),
              // SizedBox(
              //   height: 4.h,
              // ),
              // SizedBox(
              //   height: 2.h,
              // ),
              // if (widget.cabType != "in city")
              Text(
                "Fare Breakup",
                style:
                    theme.displaySmall!.copyWith(color: ColorConst.blackColor),
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
                      name1:
                          !isIntercity() ? "Total fare cost" : "Fare cost(km)",
                      name2:  'SAR  ${(Helpers.toDouble(widget.price))}'.toString(),
                     
                      theme: theme),
                  if (isIntercity())
                    roo(
                        name1: "Fare distance(km)",
                        name2: widget.totalKm.toString(),
                        theme: theme),
                  Obx(() => (!isIntercity() &&
                          groupVal.toString() != 'Full Pay')
                      ? roo(
                          name1: "Min payment",
                          name2: 'SAR ${
                              (Helpers.toDouble(widget.minimumBookingAmount))}'
                                  .toString(),
                          theme: theme)
                      : SizedBox()),
                  if (!Helpers.isNull(offerApplied['name']))
                    Obx(() => roo(
                        name1: "Discount",
                        name2: '-SAR' + (discountAmount().toStringAsFixed(1)),
                        theme: theme)),
                  if (cabController.paymentType.value != '')
                    roo(
                        name1: "Min Payment",
                        name2: cabController.payment.value,
                        theme: theme),
                  SizedBox(height: 1.5.h),
                  Image.asset(
                    "assets/images/Line.png",
                    fit: BoxFit.fitWidth,
                    width: 100.w,
                  ),
                  SizedBox(
                    height: 1.8.h,
                  ),
                  Obx(() =>
                      (!isIntercity() && groupVal.toString() != 'Full Pay')
                          ? roo(
                              padding: EdgeInsets.only(bottom: 0.12.h),
                              name1: "Amount Due",
                              name2: 'SAR ${dueAmount()}'.toString(),
                              theme: theme,
                              style: theme.displaySmall?.copyWith(
                                  color: ColorConst.redColor,
                                  fontWeight: FontWeight.w500))
                          : SizedBox()),
                  SizedBox(
                    height: 1.8.h,
                  ),
                  Obx(() => roo(
                      name1: "Final fare cost",
                      name2: 'SAR ${ totalAmount()}'.toString(),
                      theme: theme)),
                ]),
              ),
              if (!paymentLoading)
                CustomButton(
                    height: 6.h,
                    color: ColorConst.kGreenColor,
                    textStyle: theme.displaySmall,
                    name: "Make a Payment",
                    onTap: () async {
                      String paymentType =
                          groupVal.value == 'Full Pay' ? 'full' : 'partial';

                      setState(() {
                        paymentLoading = true;
                      });

                      dev.Tuple2 result =
                          await paymentController.cabPaymentType(
                              cab_type: widget.cabType,
                              cab_package_id: widget.cabId,
                              due_amount: paymentType == 'full'
                                  ? '0'
                                  : dueAmount().toString(),
                              total_amount: totalAmount().toString(),
                              payment_type: paymentType,
                              date_of_travel: widget.date,
                              time_of_travel: widget.time,
                              cab_size: widget.seater,
                              contact_number: widget.contactNumber,
                              pickup_location: cabController.pickup.value,
                              drop_location: cabController.drop.value,
                              payment_method: 'card');
                      setState(() {
                        paymentLoading = false;
                      });
                      if (result.value1) {
                        Helpers.showSnackbar(
                            text: " Cab Booked Successfully",
                            color: ColorConst.greenColor,
                            context: context);

                        Get.offAll(SuccessCabPage(
                          price: totalAmount().toString(),
                          seater: widget.seater,
                        ));
                      } else {
                        Helpers.showSnackbar(
                            text: result.value2,
                            color: ColorConst.redColor,
                            context: context);
                      }
                    }),
              if (paymentLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: ColorConst.kGreenColor,
                  ),
                )
              //
            ])));
  }
}
