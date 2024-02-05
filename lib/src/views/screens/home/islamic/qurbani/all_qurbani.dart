import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/src/views/screens/home/islamic/qurbani/qurbani_tab_page.dart';
import 'package:hexatour/src/views/screens/home/islamic/qurbani/qurbani_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../controllers/islamic_controller.dart';

class AllQurbani extends StatefulWidget {
  AllQurbani({Key? key});

  State<AllQurbani> createState() => _AllQurbaniState();
}

class _AllQurbaniState extends State<AllQurbani> {
  final islamicController = Get.find<IslamicController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConst.kGreenColor,
          title: Text('Qurbani'),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(2.h),
              itemCount: islamicController.qurbani.length,
              itemBuilder: (context, index) {
                print(index);
                print('whosse index');
                return qurbaniwidget(
                  onTap: () async {
                    // await islamicController.qurbaniType('cow');
                    // if (res) {
                     
                    Get.to(QurbaniTabPage(
                      index: index,
                      id: islamicController.qurbani[index].id.toString(),
                      qurbaniType: islamicController.qurbani[index].qurbaniType,
                      description: islamicController.qurbani[index].description,
                    ));

                    print(islamicController.qurbani[index]);
                    print(index);

                  },
                  id: islamicController.qurbani[index].id.toString(),
                  context: context,
                  index: index,
                  name: islamicController.qurbani[index].qurbaniType,
                  // imagepath: islamicController.qurbani[index].images[0],
                );

                //
              }),
        ));
  }
}
