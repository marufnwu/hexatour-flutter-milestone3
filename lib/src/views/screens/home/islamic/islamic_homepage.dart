import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/controllers/islamic_controller.dart';
import 'package:hexatour/src/views/screens/auth/login_page.dart';
import 'package:hexatour/src/views/screens/home/islamic/qurbani/qurbani_type.dart';
import 'package:hexatour/src/views/screens/home/islamic/zakaat/zakaat_type.dart';
import 'package:hexatour/src/views/widgets/custom_container/custom_container_round.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'charity/charity_type.dart';

class IslamicHomePage extends StatefulWidget {
  const IslamicHomePage({super.key});

  @override
  State<IslamicHomePage> createState() => _IslamicHomePageState();
}

class _IslamicHomePageState extends State<IslamicHomePage> {
  IslamicController islamicController = Get.find<IslamicController>();
  final RxBool isLogin = false.obs;
  @override
  void initState() {
    super.initState();
    isLoggedin();
  }

  Future<void> isLoggedin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin.value = await prefs.getBool('isLoggedIn') ?? false;
  }

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
        title: Text("Islamic"),
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
            onTap: () {
              isLogin.isTrue ? Get.to(QurbaniTypePage()) : Get.to(LoginPage());
            },
            name: "Qurbani",
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
              isLogin.isTrue ? Get.to(CharityTypePage()) : Get.to(LoginPage());
            },
            name: "Charity",
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
              isLogin.isTrue ? Get.to(ZakaatTypePage()) : Get.to(LoginPage());
            },
            name: "Zakaat",
            style:
                textTheme.displaySmall!.copyWith(color: ColorConst.blackColor),
          ),
        ]),
      ),
    );
  }
}
