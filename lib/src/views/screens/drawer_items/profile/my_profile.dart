import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/core/utils/constant.dart';
import 'package:hexatour/src/views/widgets/textfields/custom_textfield.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/Helpers.dart';
import '../../../../controllers/home_page_controller.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../../../widgets/custom_container/helper_container.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  final profileController = Get.find<HomePageController>();

  TextEditingController name = TextEditingController(text: "John");
  TextEditingController email = TextEditingController(text: "xyz@gmail.com");
  TextEditingController phone = TextEditingController(text: "1234 56789");
  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController conNewPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RxBool _isReadOnly = true.obs;
  RxBool loading = true.obs;
  RxString code = "966".obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100),(){
      getdata();
    });
  }

  getdata()async{
    var a = await profileController.getProfileDetails();
    if(a == true){
      name.text = profileController.profile.value.username.toString();
      email.text = profileController.profile.value.email.toString();
      phone.text = profileController.profile.value.phone.toString();
      loading.value = false;
    }
  }

  update()async{
    loading.value = true;
    var a = await profileController.updateProfileDetails({'username': name.text,'email':email.text,'phone':phone.text});
    if(a == false){
      loading.value = false;
      Helpers.showSnackbar(text: 'User Profile Updated', color: ColorConst.kGreenColor, context: context);
    }
  }

  changepassword()async{
    loading.value = true;
    var a = await profileController.changePassword({'oldPassword': oldPass.text,'newPassword':newPass.text});
    if(a == false){
      loading.value = false;
      Navigator.pop(context);
      Helpers.showSnackbar(text: 'Password Changed Successfully', color: ColorConst.kGreenColor, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Obx(
      () {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              centerTitle: true,
              backgroundColor: ColorConst.kGreenColor,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  color: ColorConst.kGreenColor,
                  image: DecorationImage(
                    image: AssetImage("assets/images/appbar.png"),
                  ),
                ),
              ),
              // actions: [
              //   IconButton(
              //     splashColor: Colors.transparent,
              //     onPressed: () {
              //       _isReadOnly.value = !_isReadOnly.value;
              //     },
              //     icon: Icon(Icons.mode_edit_outlined),
              //   )
              // ],
            ),
            body: loading.value
                ? MyLoader()
                : SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
              child: Column(children: [
                HelperCon(
                  title: "Name",
                  widget: CustomTextField(
                    isReadOnly: false,
                    control: name,
                    isRequired: false,
                    keyboardType: TextInputType.text,
                    isNumber: false,
                    textInputAction: TextInputAction.none,
                    style: textTheme.displaySmall!.copyWith(
                      color: ColorConst.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                HelperCon(
                  title: "Email address",
                  widget: CustomTextField(
                      isReadOnly: false,
                      control: email,
                      // hint: email.text,
                      isRequired: false,
                      keyboardType: TextInputType.emailAddress,
                      isNumber: false,
                      textInputAction: TextInputAction.none,
                      style: textTheme.displaySmall!
                          .copyWith(color: ColorConst.blackColor,
                        fontWeight: FontWeight.w500,)),
                ),
                HelperCon(
                  title: "Mobile Number",
                  widget: CustomTextField(
                    type: "phone",
                    control: phone,
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
                // Obx(
                //       () => HelperCon(
                //     title: "Mobile No.",
                //     widget: CustomTextField(
                //       isReadOnly: _isReadOnly.value,
                //       control: phone,
                //       hint: "Mobile Number",
                //       isRequired: true,
                //       prefIcon: Container(
                //         margin: EdgeInsets.all(2.w),
                //         width: 29.w,
                //         height: 5.h,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(8),
                //           color: ColorConst.whiteColor,
                //         ),
                //         child: Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               Image.asset("assets/images/saudi.png"),
                //               Text(
                //                 " +966",
                //                 style: textTheme.displaySmall?.copyWith(
                //                     fontWeight: FontWeight.w500,
                //                     color: ColorConst.blackColor,
                //                     fontSize: 14.sp),
                //               ),
                //               Icon(Icons.keyboard_arrow_down_outlined)
                //             ]),
                //       ),
                //       keyboardType: TextInputType.number,
                //       isNumber: true,
                //       textInputAction: TextInputAction.next,
                //       style: textTheme.displaySmall!.copyWith(
                //           fontWeight: FontWeight.w500,
                //           color: ColorConst.blackColor),
                //     ),
                //   ),
                // ),
                CustomButton(
                  height: 7.h,
                  name: "Change Password",
                  onTap: () {
                    showDialog(
                        useRootNavigator: false,
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            iconPadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 2.h),
                            icon: Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                splashColor: Colors.transparent,
                                icon: Icon(
                                  Icons.close,
                                  color: ColorConst.blackColor,
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: SizedBox(
                                width: 100.w,
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                      children: [
                                        HelperCon(
                                          title: "Old Password",
                                          widget: CustomTextField(
                                            type: 'password',
                                            isRequired: true,
                                            control: oldPass,
                                            hint: "Enter Old Password",
                                            keyboardType: TextInputType.visiblePassword,
                                            isNumber: false,
                                            textInputAction: TextInputAction.next,
                                            style: textTheme.displaySmall!.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: ColorConst.blackColor,
                                            ),
                                          ),
                                        ),
                                        HelperCon(
                                          title: "New Password",
                                          widget: CustomTextField(
                                            type: 'password',
                                            isRequired: true,
                                            control: newPass,
                                            hint: "Enter New Password",
                                            keyboardType: TextInputType.visiblePassword,
                                            isNumber: false,
                                            textInputAction: TextInputAction.next,
                                            style: textTheme.displaySmall!.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: ColorConst.blackColor,
                                            ),
                                          ),
                                        ),
                                        HelperCon(
                                          title: "Confirm Password",
                                          widget: CustomTextField(
                                            type: 'password',
                                            isRequired: true,
                                            control: conNewPass,
                                            hint: "Confirm Password",
                                            keyboardType: TextInputType.visiblePassword,
                                            isNumber: false,
                                            textInputAction: TextInputAction.next,
                                            style: textTheme.displaySmall!.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: ColorConst.blackColor),
                                          ),
                                        ),
                                        CustomButton(
                                          height: 6.h,
                                          radius: 10,
                                          name: "Update Password",
                                          onTap: () {
                                            if (_formKey.currentState!.validate()) {
                                              if(conNewPass.text == newPass.text){
                                                changepassword();
                                              }else{
                                                Navigator.pop(context);
                                                Helpers.showSnackbar(text: 'Password Does not match please try again..', color: ColorConst.kGreenColor, context: context);
                                              }

                                            }
                                          },
                                          color: Color.fromARGB(255, 123, 222, 124),
                                          textStyle: textTheme.displaySmall,
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  // outlineBtn: true,
                  borderColor: ColorConst.kGreenColor,
                  textStyle:
                  textTheme.displaySmall?.copyWith(color: ColorConst.kGreenColor),
                ),
                SizedBox(
                  height: 2.h,
                ),
                CustomButton(
                  height: 7.h,
                  name: "Update Profile",
                  onTap: () {
                    update();
                  },
                  color: ColorConst.kGreenColor,
                  textStyle: textTheme.displaySmall,
                )
              ]),
            ));
      }
      ,
    );
  }
}
