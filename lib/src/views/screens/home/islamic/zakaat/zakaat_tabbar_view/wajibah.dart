
import 'package:dartz/dartz.dart' as dev;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/core/utils/Helpers.dart';
import 'package:hexatour/src/controllers/islamic_controller.dart';
import 'package:hexatour/src/controllers/servive_payment_controller.dart';
import 'package:hexatour/src/views/widgets/buttons/custom_button.dart';
import 'package:hexatour/src/views/widgets/custom_container/helper_container.dart';
import 'package:hexatour/src/views/widgets/dropdown/customdropdown.dart';
import 'package:hexatour/src/views/widgets/textfields/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class Wajibah extends StatefulWidget {
  const Wajibah({super.key});

  @override
  State<Wajibah> createState() => _WajibahState();
}

class _WajibahState extends State<Wajibah> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    TextEditingController purpose = TextEditingController();
    TextEditingController amount = TextEditingController();
    IslamicController islamicController = Get.find<IslamicController>();
    PaymentController paymentController = Get.find<PaymentController>();
    RxString type = 'Select Type'.obs;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      child: Column(children: [
        InkWell(
          onTap: () async {
            // await islamicController.zakatType('wajiwah');
          },
          child: HelperCon(
            title: "Type",
            widget: CustomDropDown(
                hint: type,
                items: islamicController.zakaat.map((item) {
                  print(item.categoryName);
                  print('kkkkk');
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item.categoryName),
                  );
                }).toList(),
                onChanged: (newVal) {
                  print(newVal);
              
                  // value: dropdownvalue,
                }),
          ),
        ),
        HelperCon(
          title: "Purpose",
          widget: CustomTextField(
            minLine: 4,
            maxLine: 6,
            hint: "Enter Purpose",
            control: purpose,
            isRequired: true,
            keyboardType: TextInputType.name,
            isNumber: false,
            textInputAction: TextInputAction.next,
            style: theme.displaySmall!.copyWith(
                color: ColorConst.blackColor, fontWeight: FontWeight.w500),
          ),
        ),
        HelperCon(
          title: "Amount",
          widget: CustomTextField(
            hint: "Enter Amount",
            control: amount,
            isRequired: true,
            keyboardType: TextInputType.number,
            isNumber: false,
            textInputAction: TextInputAction.done,
            style: theme.displaySmall!.copyWith(
                color: ColorConst.blackColor, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 4.h),
        CustomButton(
            name: "Book Now",
            height: 6.h,
            color: ColorConst.kGreenColor,
            textStyle: theme.displaySmall,
            onTap: () async {
              dev.Tuple2 result = await paymentController.verifyzakaatPayment(
                  zakaat_category_id: islamicController.zakaat.first.id.toString(),
                      
                  purpose: purpose.text,
                  amount_paid: amount.text,
                  zakaat_type: "wajiwah",
                  payment_method: "card");
              print(type.value);

              if (result.value1) {
                Helpers.showSnackbar(
                    text: 'zakaat booked successfully',
                    color: ColorConst.kGreenColor,
                    context: context);
              } else {
                Helpers.showSnackbar(
                    text: result.value2,
                    color: ColorConst.kRedColor,
                    context: context);
              }
            })
      ]),
    );
  }
}
