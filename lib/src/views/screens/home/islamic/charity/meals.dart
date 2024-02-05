import 'package:dartz/dartz.dart' as dev;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/src/controllers/servive_payment_controller.dart';
import 'package:hexatour/src/views/screens/home/home_page.dart';
import 'package:hexatour/src/views/screens/home/islamic/charity/charity_container.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/utils/Helpers.dart';

class MealsPage extends StatefulWidget {
  final String? id;

  final String? description;

  MealsPage({
    Key? key,
    required this.id,

    // required this.imagepath,
    this.description,

    //  this.price,
  }) : super(key: key);
  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameControl = TextEditingController();
    TextEditingController hotelControl = TextEditingController();
    TextEditingController roomControl = TextEditingController();
    TextEditingController mobileControl = TextEditingController();
    String setTime = '';
    TextEditingController unitControl = TextEditingController();
    PaymentController paymentController = Get.find<PaymentController>();

    List<String> images = [
      'https://tse3.mm.bing.net/th?id=OIP.0sJ2U0LDyimPYB5MbQt_KwHaE8&pid=Api&P=0&h=180',
      'https://tse3.mm.bing.net/th?id=OIP.0sJ2U0LDyimPYB5MbQt_KwHaE8&pid=Api&P=0&h=180',
      'https://tse3.mm.bing.net/th?id=OIP.0sJ2U0LDyimPYB5MbQt_KwHaE8&pid=Api&P=0&h=180'
    ];

    return CharityContainer(
      description: widget.description,
      id: widget.id,
      nameControl: nameControl,
      hotelControl: hotelControl,
      roomControl: roomControl,
      mobileControl: mobileControl,
      unitControl: unitControl,
      onSelect: (time) {
        setTime = time;
      },
      images: images,
      onTap: () async {
        dev.Tuple2 result = await paymentController.verifycharityPayment(
            amount_paid: "3333",
            name: nameControl.text,
            room_number: roomControl.text,
            hotel_name: hotelControl.text,
            unit: unitControl.text,
            preferred_time: setTime,
            contact_number: mobileControl.text,
            charity_id: widget.id,
            payment_method: "card");

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

        print(setTime);
        print(unitControl.text);
      },
    );
  }
}
