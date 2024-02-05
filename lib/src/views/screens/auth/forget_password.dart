
import 'package:dartz/dartz.dart' as dev;
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/views/widgets/textfields/custom_textfield.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/Helpers.dart';
import '../../../controllers/auth_controller.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController EmailController = TextEditingController();
  final authController = Get.find<AuthController>();
  bool isLoading = false;
  bool paymentLoading = false;

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ColorConst.blackColor,
        ),
        title: Text("Forgot Password",
            style: theme.displaySmall?.copyWith(
              color: ColorConst.blackColor,
              fontSize: 15.sp,
            )),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image(image: AssetImage('assets/images/forgot.png')),
              // SvgPicture.asset('assets/images/Car3.svg'),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Forgot Password ?',
                style: theme.displayMedium?.copyWith(
                    color: ColorConst.blackColor,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Please enter email address, so we can send you reset password link',
                style: theme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w500, color: Color(0xff7C7979)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.5.w),
                  child: Text(
                    "Email address",
                    style: theme.displaySmall?.copyWith(
                        color: ColorConst.blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              CustomTextField(
                isRequired: true,
                type: 'email',
                control: EmailController,
                hint: "Enter email address",
                keyboardType: TextInputType.emailAddress,
                // ignore: deprecated_member_use
                toolbarOptions: ToolbarOptions(
                  copy: true,
                  paste: true,
                ),
                isNumber: false,
                textInputAction: TextInputAction.done,
                style: theme.headlineMedium!
                    .copyWith(color: ColorConst.blackColor),
              ),
              SizedBox(
                height: 3.h,
              ),
              if (!paymentLoading)
                ElevatedButton(
                  onPressed: (() async {
                    setState(() {
                      paymentLoading = true;
                    });

                    dev.Tuple2 result = await authController.forgotPassword(
                      email: EmailController.text.trim(),
                    );
                    setState(() {
                      paymentLoading = false;
                    });
                    if (result.value1) {
                      Helpers.showSnackbar(
                          text: "Email send Successfully",
                          color: ColorConst.greenColor,
                          context: context);
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
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorConst.kGreenColor),
                      shadowColor: MaterialStateProperty.all<Color>(
                          ColorConst.kGreenColor),
                      elevation: MaterialStateProperty.all<double>(13.0),
                      padding:
                          MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                        (Set<MaterialState> states) {
                          return const EdgeInsets.fromLTRB(122, 10, 122, 10);
                        },
                      )),
                  child: Text(
                    'Send link',
                    style: theme.displaySmall?.copyWith(fontSize: 14.sp),
                  ),
                ),
              if (paymentLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: ColorConst.kGreenColor,
                  ),
                )
            ],
          )),
    );
  }
}
