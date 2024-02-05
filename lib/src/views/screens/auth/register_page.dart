import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:dartz/dartz.dart' as dev;
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/controllers/auth_controller.dart';
import 'package:hexatour/src/views/screens/auth/login_page.dart';
import 'package:hexatour/src/views/screens/auth/widgets/auth_widgets.dart';

import 'package:hexatour/src/views/widgets/custom_container/helper_container.dart';
import 'package:hexatour/src/views/widgets/textfields/custom_textfield.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/Helpers.dart';
import '../drawer_items/terms_condition.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController mobilenumberController = TextEditingController();
  final authcontroller = Get.find<AuthController>();
  RxString nation = "".obs;
  RxString code = "966".obs;
  String _selectedVal = '';
  bool paymentLoading = false;

  List<Map<String, dynamic>> genders = [
    {"name": "male", "img": "assets/images/male.svg", "isSelected": false},
    {"name": "female", "img": "assets/images/female.svg", "isSelected": false}
  ];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: ColorConst.blackColor),
          title: Text(
            "Register",
            style:
                textTheme.displayMedium?.copyWith(color: ColorConst.blackColor),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.to(LoginPage());
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          physics: AlwaysScrollableScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 3.h,
            ),
            HelperCon(
              title: "Full name",
              widget: CustomTextField(
                control: usernameController,
                hint: "Enter full name",
                isRequired: true,
                keyboardType: TextInputType.name,
                isNumber: false,
                // ignore: deprecated_member_use
                toolbarOptions: ToolbarOptions(
                  copy: true,
                  paste: true,
                ),
                textInputAction: TextInputAction.next,
                style: textTheme.headlineMedium!
                    .copyWith(color: ColorConst.blackColor),
              ),
            ),

            HelperCon(
              title: "Email address",
              widget: CustomTextField(
                control: emailController,
                hint: "Enter email address",
                isRequired: true,
                keyboardType: TextInputType.emailAddress,
                isNumber: false,
                // ignore: deprecated_member_use
                toolbarOptions: ToolbarOptions(
                  copy: true,
                  paste: true,
                ),
                textInputAction: TextInputAction.next,
                style: textTheme.headlineMedium!
                    .copyWith(color: ColorConst.blackColor),
              ),
            ),
            HelperCon(
              title: "Password",
              widget: CustomTextField(
                type: "password",
                control: passwordController,
                hint: "Enter password",
                isRequired: true,
                keyboardType: TextInputType.visiblePassword,
                isNumber: false,
                // ignore: deprecated_member_use
                toolbarOptions: ToolbarOptions(
                  copy: true,
                  paste: true,
                ),
                textInputAction: TextInputAction.next,
                style: textTheme.headlineMedium!
                    .copyWith(color: ColorConst.blackColor),
              ),
            ),

            HelperCon(
              title: "Nationality",
              widget: InkWell(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    countryListTheme: CountryListThemeData(
                        inputDecoration: InputDecoration(
                            hintText: 'Select nationality',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                    color: Color.fromARGB(255, 70, 65, 65),
                                    fontWeight: FontWeight.w500)),
                        searchTextStyle: textTheme.displaySmall!
                            .copyWith(color: ColorConst.blackColor)),
                    onSelect: (Country value) {
                      nation.value = value.name;
                    },
                  );
                },
                child: Container(
                  width: 100.w,
                  height: 6.h,
                  padding: EdgeInsets.only(left: 4.w, top: 1.5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffF4F6F8),
                  ),
                  child: Obx(() => Text(
                        nation.value,
                        style: textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: nation.value == "Select Nationality"
                                ? Color(0xffC6C5C5)
                                : Color.fromARGB(255, 57, 55, 55)),
                      )),
                ),
              ),
            ),
            HelperCon(
              title: "Mobile Number",
              widget: CustomTextField(
                type: "phone",
                control: mobilenumberController,
                hint: "Enter Mobile Number",
                isRequired: true,
                keyboardType: TextInputType.number,
                isNumber: true,
                // ignore: deprecated_member_use
                toolbarOptions: ToolbarOptions(
                  copy: true,
                  paste: true,
                ),
                prefIcon: Container(
                  margin: EdgeInsets.all(2.w),
                  width: 26.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorConst.whiteColor,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //
                        Obx(
                          () => Text(
                            ' +${code.value}',
                            style: textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: ColorConst.blackColor,
                                fontSize: 13.sp),
                          ),
                        ),

                        InkWell(
                            child: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: ColorConst.blackColor,
                            ),
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                countryListTheme: CountryListThemeData(
                                    inputDecoration: InputDecoration(
                                        hintText: 'Select country code',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.copyWith(
                                                color: Color.fromARGB(
                                                    255, 70, 65, 65),
                                                fontWeight: FontWeight.w500)),
                                    searchTextStyle: textTheme.displaySmall!
                                        .copyWith(
                                            color: ColorConst.blackColor)),
                                onSelect: (Country value) {
                                  code.value = value.phoneCode;
                                  print(code.value);
                                },
                              );
                            }),
                      ]),
                ),
                textInputAction: TextInputAction.done,
                style: textTheme.headlineMedium!
                    .copyWith(color: ColorConst.blackColor),
              ),
            ),

            SizedBox(
              height: 1.h,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Select gender',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                for (int i = 0; i < genders.length; i++)
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        for (int i = 0; i < genders.length; i++) {
                          genders[i]["isSelected"] = false;
                        }
                        setState(() {
                          genders[i]["isSelected"] = true;
                          _selectedVal = genders[i]["name"];
                        });
                      },
                      child: gender(
                          name: genders[i]["name"],
                          image: genders[i]["img"],
                          isSelected: genders[i]["isSelected"]),
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'By continue you are agree',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'),
                ),
                TextButton(
                    onPressed: (() {
                      Get.to(TermsCondition());
                    }),
                    child: const Text(
                      'Terms & condition',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!paymentLoading)
                  ElevatedButton(
                      onPressed: (() async {
                        setState(() {
                          paymentLoading = true;
                        });
                        dev.Tuple2 result = await authcontroller.register(
                          nationality: nation.value,
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          username: usernameController.text.trim(),
                          phone: mobilenumberController.text.trim(),
                          gender: _selectedVal,
                        );
                        setState(() {
                          paymentLoading = false;
                        });

                        if (result.value1) {
                          buildLanguageDialog(context);
                          Helpers.showSnackbar(
                              text: "Registered Successfully",
                              color: ColorConst.greenColor,
                              context: context);
                        } else {
                          Helpers.showSnackbar(
                              text: result.value2,
                              color: ColorConst.redColor,
                              context: context);
                        }
                        print(result.value2);
                        print('jhbjhgvjh');
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
                          padding: MaterialStateProperty.resolveWith<
                              EdgeInsetsGeometry>(
                            (Set<MaterialState> states) {
                              return const EdgeInsets.fromLTRB(
                                  139, 13, 139, 10);
                            },
                          )),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins'),
                      )),
                if (paymentLoading)
                  Center(
                    child: CircularProgressIndicator(
                      color: ColorConst.kGreenColor,
                    ),
                  )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have register ?',
                  style: TextStyle(
                      color: ColorConst.kBlackColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins'),
                ),
                TextButton(
                    onPressed: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => LoginPage())));
                    }),
                    child: Text(
                      '  Login Now',
                      style: TextStyle(
                          color: ColorConst.kGreenColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins'),
                    )),
              ],
            ),

            //
          ]),
        ));
  }
}
