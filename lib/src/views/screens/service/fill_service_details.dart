import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/core/utils/constant.dart';
import 'package:hexatour/src/controllers/geo_controller.dart';
import 'package:hexatour/src/views/screens/offers/offer_detail.dart';
import 'package:hexatour/src/views/screens/service/success_service_page.dart';
import 'package:hexatour/src/views/screens/service/widgets/service_widgets.dart';
import 'package:hexatour/src/views/widgets/buttons/custom_button.dart';
import 'package:hexatour/src/views/widgets/custom_container/custom_container_round.dart';
import 'package:hexatour/src/views/widgets/custom_container/helper_container.dart';
import 'package:hexatour/src/views/widgets/date_time_picker/date_picker.dart';
import 'package:hexatour/src/views/widgets/date_time_picker/time_picker.dart';
import 'package:hexatour/src/views/widgets/textfields/custom_textfield.dart';
import 'package:sizer/sizer.dart';
import 'package:dartz/dartz.dart' as dev;
import '../../../../core/utils/Helpers.dart';
import '../../../controllers/home_page_controller.dart';
import '../../../controllers/servive_payment_controller.dart';

class FillServiceDetails extends StatefulWidget {
  FillServiceDetails({
    required this.service_price,
    required this.service_id,
    super.key,
  });
  final int service_price;
  final service_id;

  @override
  State<FillServiceDetails> createState() => _FillServiceDetailsState();
}

class _FillServiceDetailsState extends State<FillServiceDetails> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController hotelControl = TextEditingController();
  TextEditingController roomControl = TextEditingController();
  RxString date = ''.obs;
  RxString code = '966'.obs;
  String setTime = '';
  TextEditingController mobileControl = TextEditingController();
  TextEditingController unitControl = TextEditingController();
  final paymentController = Get.find<PaymentController>();
  final homepageController = Get.find<HomePageController>();
  final geoController = Get.find<GeoController>();
  Timer? _hotelNameDebounce;
  bool paymentLoading = false;
  Map<String, dynamic> offerApplied = {
    "discount_percent": 0,
    "flat_off": 0,
    "name": null
  };

  @override
  void dispose() {
    geoController.geoPickUpSuggestions = RxList();
    _hotelNameDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("rebuilding");
    TextTheme theme = Theme.of(context).textTheme;

    discountAmount() {
      int price = Helpers.toInt(widget.service_price);

      return Helpers.calculateDiscountAmount(
          offerApplied['discount_percent'], price);
    }

    totalAmount() {
      int price = Helpers.toInt(widget.service_price);
      return (price - discountAmount()).toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Service"),
        centerTitle: true,
        backgroundColor: ColorConst.kGreenColor,
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // HelperCon(
              //   title: "Enter Name",
              //   widget: CustomTextField(
              //       control: nameControl,
              //       hint: "Enter Your Name",
              //       isRequired: true,
              //       keyboardType: TextInputType.name,
              //       isNumber: false,
              //       textInputAction: TextInputAction.next,
              //       style: theme.displaySmall!.copyWith(
              //           fontWeight: FontWeight.w500,
              //           color: ColorConst.blackColor)),
              // ),
              HelperCon(
                title: "Enter Email Address",
                widget: CustomTextField(
                    control: emailControl,
                    hint: "Enter Email Address",
                    isRequired: true,
                    keyboardType: TextInputType.emailAddress,
                    isNumber: false,
                    textInputAction: TextInputAction.next,
                    style: theme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConst.blackColor)),
              ),
              HelperCon(
                title: "Hotel Name",
                widget: CustomTextField(
                    control: hotelControl,
                    hint: "Enter Hotel Name",
                    isRequired: true,
                    keyboardType: TextInputType.name,
                    isNumber: false,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      if (_hotelNameDebounce?.isActive ?? false)
                        _hotelNameDebounce!.cancel();
                      _hotelNameDebounce =
                          Timer(const Duration(microseconds: 500), () async {
                        await geoController.getPickUpSuggestions(
                            input: value, types: 'establishment');
                      });
                    },
                    style: theme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConst.blackColor)),
              ),
              Obx(() {
                if (geoController.geoPickUpSuggestions.length != 0)
                  return Container(
                    constraints: BoxConstraints(
                        minHeight: 5.h, minWidth: 100.w, maxHeight: 20.h),
                    decoration: BoxDecoration(
                      color: ColorConst.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                geoController.geoPickUpSuggestions.length,
                            itemBuilder: ((context, index) {
                              return ListTile(
                                  visualDensity: VisualDensity.compact,
                                  dense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  leading: const Icon(Icons.location_on),
                                  onTap: () {
                                    hotelControl.text = geoController
                                        .geoPickUpSuggestions[index]
                                        .descriptions;
                                    geoController.resetPickUpSuggestions();
                                  },
                                  title: Text(geoController
                                      .geoPickUpSuggestions[index]
                                      .descriptions));
                            }))),
                  );
                return SizedBox();
              }),
              SizedBox(
                height: 10,
              ),
              HelperCon(
                title: "Room No.",
                widget: CustomTextField(
                  control: roomControl,
                  hint: "Enter Room No.",
                  isRequired: true,
                  keyboardType: TextInputType.name,
                  isNumber: false,
                  textInputAction: TextInputAction.next,
                  style: theme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorConst.blackColor),
                ),
              ),
              HelperCon(
                title: "Date ",
                widget: DatePicker(
                  firstDate: DateTime.now(),
                  value: date,
                  onSelect: (picked) {
                    date.value = picked;
                  },
                ),
              ),
              HelperCon(
                title: "Time",
                widget: TimePicker(
                  onSelect: (time) {
                    setTime = time;
                    print(setTime);
                  },
                ),
              ),
              HelperCon(
                title: "Mobile No.",
                widget: CustomTextField(
                    maxLength: 10,
                    control: mobileControl,
                    hint: "Mobile Number",
                    isRequired: true,
                    prefIcon: Container(
                      margin: EdgeInsets.all(2.w),
                      width: 28.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ColorConst.whiteColor,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => Text(
                                ' +${code.value}',
                                style: theme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ColorConst.blackColor,
                                    fontSize: 13.sp),
                              ),
                            ),

                            InkWell(
                                child: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: ColorConst.blackColor,
                                ),
                                onTap: () {
                                  showCountryPicker(
                                    context: context,
                                    showPhoneCode: true,
                                    countryListTheme: CountryListThemeData(
                                        inputDecoration: InputDecoration(
                                            hintText: 'Select country code',
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .displaySmall
                                                ?.copyWith(
                                                    color: Color.fromARGB(
                                                        255, 70, 65, 65),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                        searchTextStyle: theme.displaySmall!
                                            .copyWith(
                                                color: ColorConst.blackColor)),
                                    onSelect: (Country value) {
                                      code.value = value.phoneCode;
                                      print(code.value);
                                    },
                                  );
                                }),
                            // Image.asset("assets/images/saudi.png"),
                            // SizedBox(
                            //   height: 3.h,
                            // ),
                            // Text(
                            //   " +966",
                            //   style: theme.displaySmall?.copyWith(
                            //       fontWeight: FontWeight.w500,
                            //       color: ColorConst.blackColor,
                            //       fontSize: 13.sp),
                            // ),
                            // Icon(Icons.keyboard_arrow_down_outlined)
                          ]),
                    ),
                    keyboardType: TextInputType.number,
                    isNumber: true,
                    textInputAction: TextInputAction.next,
                    style: theme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConst.blackColor)),
              ),
              HelperCon(
                  title: "Unit",
                  widget: CustomTextField(
                    control: unitControl,
                    hint: "Enter Number",
                    isRequired: true,
                    keyboardType: TextInputType.number,
                    isNumber: false,
                    textInputAction: TextInputAction.done,
                    style: theme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConst.blackColor),
                  )),
              SizedBox(height: 2.h),
              CusCon(
                onTap: () async {
                  print('which offerrr');
                  dev.Tuple2 result =
                      await homepageController.getOffertype(value: 'service');
                  // Get.to(OfferDetail());

                  if (result.value1) {
                    print('hiii');
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
                    print('hellooo');
                    Helpers.showSnackbar(
                        text: 'Currently no offers are available',
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
              SizedBox(height: 1.5.h),
              // CusCon(
              //   onTap: () {},
              //   name: "Cancellation Policy",
              //   style: theme.displaySmall!.copyWith(
              //       color: ColorConst.blackColor, fontWeight: FontWeight.w500),
              // ),
              // SizedBox(
              //   height: 2.h,
              // ),
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
                      name1: "Total fare cost",
                      name2: 'SAR ${(Helpers.toDouble(widget.service_price))}'
                          .toString(),
                      theme: theme),
                  if (!Helpers.isNull(offerApplied['name']))
                    roo(
                        name1: "Discount",
                        name2: '-SAR ${(discountAmount().toStringAsFixed(1))}',
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
                  roo(
                      name1: "Final fare cost",
                      name2: 'SAR ${totalAmount()}'.toString(),
                      theme: theme),
                ]),
              ),
              if (paymentLoading)
                CircularProgressIndicator(
                  color: ColorConst.greenColor,
                ),
              if (!paymentLoading)
                CustomButton(
                    height: 6.h,
                    color: ColorConst.kGreenColor,
                    textStyle: theme.displaySmall,
                    name: "Make a Payment",
                    onTap: () async {
                      setState(() {
                        paymentLoading = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        if (Helpers.isNull(date.value)) {
                          return Helpers.showSnackbar(
                              text: 'Date is required',
                              color: ColorConst.redColor,
                              context: context);
                        }
                        //   setState(() {
                        //   paymentLoading = true;
                        // });
                        if (Helpers.isNull(setTime)) {
                          return Helpers.showSnackbar(
                              text: 'Time is required',
                              color: ColorConst.redColor,
                              context: context);
                        }
                      }

                      dev.Tuple2 result =
                          await paymentController.servicePaymentType(
                        service_id: widget.service_id.toString(),
                        unit: unitControl.text.trim(),
                        service_avail_date:
                            '${date.value} ${setTime.split(" ")[0]}',
                        payment_type: "full",
                        contact_number: mobileControl.text.trim(),
                        total_amount: totalAmount(),
                        due_amount: '0',
                        currency: Payment.PaymentCurrency,
                        payment_method: "card",
                        hotel_name: hotelControl.text,
                        room_number: roomControl.text,
                      );
                      setState(() {
                        paymentLoading = false;
                      });

                      if (result.value1) {
                        var response =
                            paymentController.addPaymentResponse.value['data'];
                            print(response);
                            print('uuuuuuuuuuuuuuuuuuuu');
                        Helpers.showSnackbar(
                            text: "Service booked Successfully",
                            color: ColorConst.greenColor,
                            context: context);

                        Get.off(SuccessServicePage(
                          date: response['created_at'] ,
                          transactionId: response['id'],
                        ));
                        // Get.offAll(MyExample());
                      } else {
                        Helpers.showSnackbar(
                            text: result.value2,
                            color: ColorConst.redColor,
                            context: context);
                      }
                    }),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }
}
