import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexatour/src/views/screens/home/islamic/zakaat/zakaat_tab_page.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../controllers/islamic_controller.dart';
import '../../../../widgets/custom_container/custom_container_round.dart';

class ZakaatTypePage extends StatefulWidget {
  const ZakaatTypePage({super.key});

  @override
  State<ZakaatTypePage> createState() => _ZakaatTypePageState();
}

class _ZakaatTypePageState extends State<ZakaatTypePage> {
  IslamicController islamicController = Get.find<IslamicController>();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: DraggableFab(
        child: FloatingActionButton(
          onPressed: (() {}),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: SvgPicture.asset(
            "assets/icons/whatsapp.svg",
            height: 6.h,
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("Zakaat"),
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Column(children: [
          CusCon(
            height: 7.h,
            border: Border.all(
              width: 0.3,
              color: Color(0xffEDEDED),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(223, 217, 217, 0.25),
                offset: Offset(0, 10),
                blurRadius: 15,
              ),
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
            ],
            onTap: () async {
              await islamicController.zakatType('wajiwah');
              print('apiiiiii');
              Get.to(ZakaatTabHomePage());
            },
            name: "Wajibah",
            style:
                textTheme.displaySmall!.copyWith(color: ColorConst.blackColor),
          ),
          SizedBox(
            height: 2.h,
          ),
          CusCon(
            height: 7.h,
            border: Border.all(
              width: 0.3,
              color: Color(0xffEDEDED),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(223, 217, 217, 0.25),
                offset: Offset(0, 10),
                blurRadius: 15,
              ),
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
            ],
            onTap: () async {
               await islamicController.zakatType('nafilah');
            
              print('pppppppp');
              Get.to(ZakaatTabHomePage());
            },
            name: "Nafilah",
            style:
                textTheme.displaySmall!.copyWith(color: ColorConst.blackColor),
          ),
          SizedBox(
            height: 2.h,
          ),
        ]),
      ),
    );
  }
}
