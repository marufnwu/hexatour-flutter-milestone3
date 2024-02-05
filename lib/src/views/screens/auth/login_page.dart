import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart' as dev;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/core/utils/Helpers.dart';
import 'package:hexatour/src/controllers/auth_controller.dart';

import 'package:hexatour/src/views/screens/auth/forget_password.dart';
import 'package:hexatour/src/views/screens/auth/register_page.dart';
import 'package:hexatour/src/views/screens/auth/widgets/auth_widgets.dart';

import 'package:hexatour/src/views/widgets/custom_container/helper_container.dart';
import 'package:hexatour/src/views/widgets/textfields/custom_textfield.dart';

import 'package:sizer/sizer.dart';

import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginpasswordController = TextEditingController();
  final authController = Get.find<AuthController>();

  bool paymentLoading = false;
  bool googleLoading = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 1.h,
      ),
      const Image(image: AssetImage('assets/images/Group.png')),
      SizedBox(
        height: 3.h,
      ),
      logtext(context),
      SizedBox(
        height: 3.h,
      ),
      HelperCon(
        padding: EdgeInsets.fromLTRB(12, 2, 12, 6),
        title: "Email address",
        widget: CustomTextField(
          type: "email",
          control: loginEmailController,
          hint: "Enter email address",
          isRequired: true,
          keyboardType: TextInputType.emailAddress,
          isNumber: false,
          textInputAction: TextInputAction.next,

          // ignore: deprecated_member_use
          toolbarOptions: ToolbarOptions(
            copy: true,
            paste: true,
          ),
          style:
              textTheme.headlineMedium!.copyWith(color: ColorConst.blackColor),
        ),
      ),
      SizedBox(
        height: 1.h,
      ),
      HelperCon(
        padding: EdgeInsets.fromLTRB(12, 4, 12, 6),
        title: "Password",
        widget: CustomTextField(
          type: "password",
          control: loginpasswordController,
          hint: "Enter password",
          isRequired: true,
          keyboardType: TextInputType.visiblePassword,
          isNumber: false,

          // ignore: deprecated_member_use
          toolbarOptions: ToolbarOptions(
            paste: true,
          ),
          textInputAction: TextInputAction.done,
          style: textTheme.headlineMedium!
              .copyWith(color: Color.fromARGB(255, 65, 62, 62)),
        ),
      ),
      SizedBox(
        height: 4,
      ),
      Container(
        width: 100.w,
        padding: EdgeInsets.fromLTRB(60, 6, 2, 1),
        margin: EdgeInsets.fromLTRB(90, 2, 1.4.h, 0.5),
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => ForgetPassword())));
          },
          child: Text(
            'Forgot Password ?',
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: ColorConst.blackColor),
          ),
        ),
      ),
      SizedBox(
        height: 13,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!paymentLoading)
            ElevatedButton(
              onPressed: (() async {
                print('chlgyiiii');
                setState(() {
                  paymentLoading = true;
                });
                dev.Tuple2 result = await authController.login(
                    email: loginEmailController.text.trim(),
                    password: loginpasswordController.text.trim());
                setState(() {
                  paymentLoading = false;
                });
                if (result.value1) {
                  Helpers.showSnackbar(
                      text: "Login Successfully",
                      color: ColorConst.greenColor,
                      context: context);
                  Get.offAll(Homepage());
                } else {
                  Helpers.showSnackbar(
                      text: result.value2,
                      color: ColorConst.redColor,
                      context: context);
                }
              }),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder?>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(ColorConst.kGreenColor),
                  shadowColor:
                      MaterialStateProperty.all<Color>(ColorConst.kGreenColor),
                  elevation: MaterialStateProperty.all<double>(13.0),
                  padding:
                      MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                    (Set<MaterialState> states) {
                      return const EdgeInsets.fromLTRB(147, 12, 147, 12);
                    },
                  )),
              child: Text(
                'Login',
                style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: ColorConst.whiteColor),
              ),
            ),
          if (paymentLoading)
            Center(
              child: CircularProgressIndicator(
                color: ColorConst.kGreenColor,
              ),
            )

          //
        ],
      ),
      SizedBox(
        height: 3.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              Get.off(Homepage());
            },
            child: Container(
              padding: EdgeInsets.all(12),
              height: 6.h,
              width: 60.w,
              child: Text(
                'Continue as guest',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    color: ColorConst.kGreenColor),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 2, color: ColorConst.kGreenColor)),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/Line2.png"),
          SizedBox(
            height: 3,
          ),
          Text(
            'or login with',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
                color: ColorConst.blackColor),
          ),
          SizedBox(
            height: 3,
          ),
          Image.asset("assets/images/Line3.png"),
        ],
      ),
      SizedBox(
        height: 1.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 10.w,
          ),
          if (!googleLoading)
            InkWell(
              onTap: () async {
                setState(() {
                  googleLoading = true;
                });
                final isSuccess =
                    await authController.googleSignInMethod(context);
                setState(() {
                  googleLoading = false;
                });
                if (isSuccess) {
                  Get.offAll(Homepage());
                } else if (isSuccess == false) {
                  Get.offAll(Homepage());
                } else {
                  Helpers.showSnackbar(
                      text: 'something went wrong',
                      color: ColorConst.kRedColor,
                      context: context);
                }
              },
              child: Image.asset(
                'assets/images/Google_logo.png',
                height: 45,
                width: 45,
              ),
            ),
          if (googleLoading)
            Center(
              child: CircularProgressIndicator(
                color: ColorConst.kGreenColor,
              ),
            ),
          InkWell(
            onTap: () async {
              final isSuccess = await authController.facebookSignin(context);
              if (isSuccess) {
                print(isSuccess);
                print('hghjvu');
                Get.offAll(Homepage());
              } else {
                Helpers.showSnackbar(
                    text: 'nooo', color: ColorConst.redColor, context: context);
              }
            },
            child: Image.asset(
              'assets/images/fb.png',
              height: 58,
              width: 58,
            ),
          ),
          InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/icons/apple.svg',
                height: 42,
                width: 42,
              )),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Not a member ? ',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins'),
          ),
          TextButton(
            onPressed: () {
              Get.to(RegisterPage());
            },
            child: Text(
              '  Register Now',
              style: TextStyle(
                  color: ColorConst.kGreenColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins'),
            ),
          ),
        ],
      ),
    ])));
  }
}
