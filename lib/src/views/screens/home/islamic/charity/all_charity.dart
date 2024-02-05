import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/src/views/screens/home/islamic/charity/charity_tabpage.dart';
import 'package:hexatour/src/views/screens/home/islamic/qurbani/qurbani_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../controllers/islamic_controller.dart';

class AllCharity extends StatefulWidget {
  AllCharity({Key? key});

  State<AllCharity> createState() => _AllCharityState();
}

class _AllCharityState extends State<AllCharity> {
  final islamicController = Get.find<IslamicController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConst.kGreenColor,
          title: Text('Charity'),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(2.h),
              itemCount: islamicController.charity.length,
              itemBuilder: (context, index) {
                return charitywidget(
                  onTap: () async {
                  var res =  await islamicController.charityType('meal');
                    if (res) {
                    Get.to(CharityTabHomePage(
                      id:islamicController.charity[index].id.toString(),
                        description:  islamicController.charity[index].description,
                  
                    ));
                  }
                  },
                  price: islamicController.charity[index].price.toString(),
                  id: islamicController.charity[index].id.toString(),
                  context: context,
                  name: islamicController.charity[index].charityType,
                  // imagepath: islamicController.charity[index].image.imagepath,
                );

                //
              }),
        ));
  }
}
