import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart' as dev;
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';

import 'package:hexatour/src/views/screens/auth/widgets/auth_widgets.dart';
import 'package:hexatour/src/views/widgets/buttons/custom_button.dart';
import 'package:hexatour/src/views/widgets/textfields/custom_textfield.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/Helpers.dart';
import '../../../controllers/auth_controller.dart';

import 'login_page.dart';

class ChangePassword extends StatefulWidget {
  final String userID;
  const ChangePassword({required this.userID, super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirm_passwordController = TextEditingController();
  final authcontroller = Get.find<AuthController>();
  bool paymentLoading = false;

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Get.to(LoginPage());
          },
        ),
        title: Text(
          "Reset password",
          style: theme.displayMedium
              ?.copyWith(color: ColorConst.blackColor, fontSize: 16.sp),
        ),
        centerTitle: true,
        backgroundColor: ColorConst.whiteColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: ColorConst.blackColor,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 6.w),
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            const Image(image: AssetImage('assets/images/forgot.png')),
            // SvgPicture.asset('assets/images/forgot.svg'),
            SizedBox(
              height: 10,
            ),
            Text(
              'Create New Password',
              style: theme.displaySmall?.copyWith(color: ColorConst.blackColor),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Your new password must be different from previous password ',
              textAlign: TextAlign.center,
              style: theme.headlineMedium?.copyWith(
                  color: Color(0xff7C7979), fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.5.w),
                child: Text(
                  "New password",
                  style: theme.displaySmall?.copyWith(
                      color: ColorConst.blackColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            CustomTextField(
              control: passwordController,
              hint: "Enter new password",
              type: "password",
              isRequired: true,
              keyboardType: TextInputType.visiblePassword,
              isNumber: false,
              // ignore: deprecated_member_use
              toolbarOptions: ToolbarOptions(
                copy: true,
                paste: true,
              ),
              textInputAction: TextInputAction.next,
              style: theme.headlineMedium!.copyWith(
                  color: ColorConst.blackColor, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.5.w),
                child: Text(
                  "Confirm password",
                  style: theme.displaySmall?.copyWith(
                      color: ColorConst.blackColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            CustomTextField(
              control: confirm_passwordController,
              hint: "Enter confirm password",
              type: "password",
              isRequired: true,
              keyboardType: TextInputType.visiblePassword,
              isNumber: false,
              textInputAction: TextInputAction.next,
              style: theme.headlineMedium!.copyWith(
                  color: ColorConst.blackColor, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 40,
            ),
            if (!paymentLoading)
              CustomButton(
                  height: 6.h,
                  textStyle: theme.displaySmall,
                  width: 100.w,
                  color: ColorConst.kGreenColor,
                  name: "Reset password",
                  onTap: () async {
                    setState(() {
                      paymentLoading = true;
                    });
                    print('notttt');
                    print(widget.userID);

                    dev.Tuple2 result = await authcontroller.resetPassword(
                        userID: widget.userID,
                        newpassword: passwordController.text.trim(),
                        confirmpassword:
                            confirm_passwordController.text.trim());
                    setState(() {
                      paymentLoading = false;
                    });
                    if (result.value1) {
                      buildPasswordDialog(context);
                      Helpers.showSnackbar(
                          text: "Reset Password Successfully",
                          color: ColorConst.greenColor,
                          context: context);
                    } else {
                      Helpers.showSnackbar(
                          text: result.value2,
                          color: ColorConst.redColor,
                          context: context);
                    }
                  }),
            if (paymentLoading)
              Center(
                child: CircularProgressIndicator(
                  color: ColorConst.kGreenColor,
                ),
              )
          ],
        ),
      ),
    );
  }
}
