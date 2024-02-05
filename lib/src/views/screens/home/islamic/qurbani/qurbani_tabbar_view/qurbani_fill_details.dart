import 'dart:math' as math;

import 'package:dartz/dartz.dart' as dev;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/controllers/islamic_controller.dart';
import 'package:hexatour/src/controllers/servive_payment_controller.dart';
import 'package:hexatour/src/views/screens/home/home_page.dart';
import 'package:hexatour/src/views/widgets/buttons/custom_button.dart';
import 'package:hexatour/src/views/widgets/custom_container/disabled_text_container.dart';
import 'package:hexatour/src/views/widgets/custom_container/helper_container.dart';
import 'package:hexatour/src/views/widgets/dropdown/customdropdown.dart';
import 'package:hexatour/src/views/widgets/textfields/custom_textfield.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../core/utils/Helpers.dart';

class FillQurbaniDetails extends StatefulWidget {
  final bool isAnimal;
  final String? kind;
  final String? id;
  final String? qurbaniType;

  const FillQurbaniDetails(
      {this.kind,
      this.isAnimal = false,
      required this.id,
      required this.qurbaniType,
      super.key});

  @override
  State<FillQurbaniDetails> createState() => _FillQurbaniDetailsState();
}

class _FillQurbaniDetailsState extends State<FillQurbaniDetails> {
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    RxInt txtfld = 1.obs;
    RxString reason = "Select Reason".obs;
    RxString lang = "Select Language".obs;
   bool  isLoading = false;
    RxList<TextEditingController> name = [TextEditingController()].obs;
    TextEditingController mobileControl = TextEditingController();
    TextEditingController priceControl = TextEditingController();
    TextEditingController message = TextEditingController();
    PaymentController paymentController = Get.find<PaymentController>();
    IslamicController islamicController = Get.find<IslamicController>();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Book Now"),
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
        body: Obx(
          () => SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
            child: Column(
              children: [
                HelperCon(
                  padding: EdgeInsets.zero,
                  title: "Name",
                  widget: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: txtfld.value,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: CustomTextField(
                              control: name[index],
                              hint: "Enter Name",
                              isRequired: true,
                              keyboardType: TextInputType.name,
                              isNumber: false,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {},
                              style: theme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorConst.blackColor)),
                        );
                      }),
                ),
                if (widget.isAnimal && txtfld.value < 7)
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {
                        if (txtfld.value < 7) {
                          txtfld.value += 1;
                          name.add(TextEditingController());
                        }
                      },
                      child: Text(
                        "+Add More",
                        style: theme.displaySmall
                            ?.copyWith(color: ColorConst.kGreenColor),
                      ),
                    ),
                  ),
                HelperCon(
                  title: "Mobile No.",
                  widget: CustomTextField(
                      control: mobileControl,
                      hint: "Mobile Number",
                      isRequired: true,
                      onChanged: (value) {},
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
                              Image.asset("assets/images/saudi.png"),
                              Text(
                                " +966",
                                style: theme.displaySmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ColorConst.blackColor,
                                    fontSize: 13.sp),
                              ),
                              Icon(Icons.keyboard_arrow_down_outlined)
                            ]),
                      ),
                      keyboardType: TextInputType.number,
                      isNumber: true,
                      textInputAction: TextInputAction.next,
                      style: theme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorConst.blackColor)),
                ),
                if (widget.kind != null)
                  HelperCon(
                    title: "Kind of Goats",
                    widget: DisabledContainer(
                      text: widget.kind ?? "",
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: ColorConst.blackColor,
                      ),
                    ),
                  ),
                HelperCon(
                  title: "Price",
                  widget: CustomTextField(
                    isNumber: true,
                    hint: 'Enter Price',
                    control: priceControl,
                    isRequired: true,
                    keyboardType: TextInputType.number,
                    style: theme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConst.blackColor),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                HelperCon(
                  title: "Reason Sacrifice",
                  widget: CustomDropDown(
                    key: Key(math.Random().nextInt(9999).toString()),
                    hint: reason,
                    items: <String>[
                      "Reason - 1",
                      "Reason - 2",
                      "Reason - 3",
                      "Reason - 4"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    onChanged: (value) {
                      islamicController.reason.value = value;
                      print(islamicController.reason.value);
                    },
                  ),
                ),
                HelperCon(
                  title: "Language",
                  widget: CustomDropDown(
                    key: Key(math.Random().nextInt(9999).toString()),
                    hint: lang,
                    items: <String>["hindi", "english", "urdu", "saudi"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    onChanged: (value) {
                      islamicController.language.value = value;
                      print(islamicController.language.value);
                    },
                  ),
                ),
                HelperCon(
                  title: "Message",
                  widget: CustomTextField(
                      control: message,
                      minLine: 4,
                      maxLine: 6,
                      hint: "Write Message",
                      isRequired: true,
                      keyboardType: TextInputType.name,
                      isNumber: false,
                      textInputAction: TextInputAction.next,
                      style: theme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorConst.blackColor)),
                ),
                SizedBox(height: 4.h),
                // if(!isLoading)
                CustomButton(
                    height: 6.h,
                    color: ColorConst.kGreenColor,
                    textStyle: theme.displayMedium,
                    name: "Make a Payment",
                    onTap: () async {
                      List<String> values =
                          name.map((controller) => controller.text).toList();
                //            setState(() {
                //   isLoading = true;
                // });
                      dev.Tuple2 result =
                          await paymentController.verifyqurbaniPayment(
                              payment_method: "card",
                              qurbani_id: widget.id,
                              qurbani_type: widget.qurbaniType.toString(),
                              name: values,
                              mobile_number: mobileControl.text,
                              goat_type: widget.kind,
                              amount_paid: priceControl.text,
                              language: islamicController.language.value,
                              reason_for_sacrifice:
                                  islamicController.reason.value,
                              message: message.text);
                //                setState(() {
                //   isLoading = false;
                // });

                      print(values);
                      if (result.value1) {
                        Helpers.showSnackbar(
                            text: "booked Successfully",
                            color: ColorConst.greenColor,
                            context: context);
                        Get.to(Homepage());
                      } else {
                        Helpers.showSnackbar(
                            text: result.value2,
                            color: ColorConst.redColor,
                            context: context);
                      }
                    }),
            //           if (isLoading)
            // Center(
            //   child: CircularProgressIndicator(
            //     color: ColorConst.kGreenColor,
            //   ),
            // )
              ],
            ),
          ),
        ));
  }
}
