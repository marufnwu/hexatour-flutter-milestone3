



import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/theme/colors.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../login_page.dart';



 buildLanguageDialog(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return showDialog(
        context: context,
        useRootNavigator: false,
        builder: (builder) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Color(0xffA9ABAC),
                        )),
                  ),
                  // SvgPicture.asset('assets/images/right.svg'),
                  Image(
                    image: AssetImage('assets/images/4_0.png'),
                  ),
                     SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Thank for Register',
                    style: theme.displaySmall?.copyWith(
                        color: ColorConst.blackColor,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    width: 60.w,
                    child: Text(
                      "Thank you for register with us please click on login button to access home page",
                      
                      textAlign: TextAlign.center,
                      style: theme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      
                        color: Color(0xff7C7979),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomButton(
                      name: "Login Now",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      width: 45.w,
                      color: ColorConst.kGreenColor,
                      textStyle: theme.displaySmall?.copyWith(fontSize: 14.sp)),
                  SizedBox(
                    height: 6.h,
                  )
                ],
              ),
            ),
          );
        });
  }




Widget gender({required String image, required String name, required isSelected}) {
  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color.fromARGB(255, 234, 230, 230),
         border: Border.all(
          color:
              isSelected == true ? ColorConst.kGreenColor : Colors.transparent),
      ),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.fromLTRB(71, 3, 2, 7),
      height: 40,
      width: 40,
   
      child: SvgPicture.asset(image));
}


logtext(context) {
  final textTheme = Theme.of(context).textTheme;
  return Container(
    padding: EdgeInsets.fromLTRB(12, 4, 5, 1),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, Welcome Back  👋  ',
          style: textTheme.displaySmall?.copyWith(
              color: ColorConst.kBlackColor, fontWeight: FontWeight.w700),
        ),
        Text(
          'Please enter below details ',
          style: textTheme.headlineSmall?.copyWith(
            color: ColorConst.greyColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}


buildPasswordDialog(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return showDialog(
        context: context,
        useRootNavigator: false,
        builder: (builder) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Color(0xffA9ABAC),
                        )),
                  ),
                   Image(
                    image: AssetImage('assets/images/4_0.png'),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Password changed',
                    style: theme.displaySmall?.copyWith(
                        color: ColorConst.blackColor,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
                    width: 50.w,
                    child: Text(
                      "Your password change successfully",
                      textAlign: TextAlign.center,
                      style: theme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff7C7979),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  CustomButton(
                      name: "Login Now",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      height: 5.h,
                      width: 44.w,
                      color: ColorConst.kGreenColor,
                      textStyle: theme.displaySmall?.copyWith(fontSize: 14.sp)),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          );
        });
  }