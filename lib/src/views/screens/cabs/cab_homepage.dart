import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';
import 'package:country_picker/country_picker.dart';
import 'package:dartz/dartz.dart' as dev;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/controllers/cab_controller.dart';
import 'package:hexatour/src/controllers/geo_controller.dart';
import 'package:hexatour/src/models/cab/cab_model.dart';
import 'package:hexatour/src/views/screens/auth/login_page.dart';
import 'package:hexatour/src/views/widgets/buttons/custom_button.dart';
import 'package:hexatour/src/views/widgets/custom_container/helper_container.dart';
import 'package:hexatour/src/views/widgets/date_time_picker/date_picker.dart';
import 'package:hexatour/src/views/widgets/date_time_picker/time_picker.dart';
import 'package:hexatour/src/views/widgets/dropdown/customdropdown.dart';
import 'package:hexatour/src/views/widgets/textfields/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/Helpers.dart';
import '../home/home_page.dart';
import 'cabtype_page.dart';

String _selectedVal = 'Within';

// ignore: must_be_immutable
class CabHomePage extends StatefulWidget {
  CabHomePage({
    this.cab_name,
    this.imagepath,
    this.cab_size,
    this.price,
    this.price_per_km,
    super.key,
  });
  final String? cab_name;
  final int? cab_size;
  final int? price;
  final int? price_per_km;
  CabImage? imagepath;

  @override
  State<CabHomePage> createState() => _CabHomePageState();
}

class _CabHomePageState extends State<CabHomePage> {
  Timer? _pickUpDebounce;
  Timer? _dropDebounce;
  final cabController = Get.find<CabController>();
  final geoController = Get.find<GeoController>();
  final RxBool isLogin = false.obs;
  List<Map<String, dynamic>> cabs = [
    {"name": "In City", "img": "assets/images/in-city.png", "isSelected": true},
    {
      "name": "Outdoor",
      "img": "assets/images/out-station.png",
      "isSelected": false
    }
  ];
  Future<void> isLoggedin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin.value = await prefs.getBool('isLoggedIn') ?? false;
    print(isLogin.value);
  }

  @override
  void initState() {
    super.initState();
    isLoggedin();
  }

  @override
  void dispose() {
    disposeValues();
    super.dispose();
  }

  disposeValues() {
    cabController.pickup.value = '';
    cabController.drop.value = '';
    cabController.date.value = '';
    cabController.time.value = '';
    geoController.geoPickUpSuggestions = RxList();
    geoController.geoDropSuggestions = RxList();
    _pickUpDebounce?.cancel();
    _dropDebounce?.cancel();
    _selectedVal = 'In City';
  }

  Widget build(BuildContext context) {
    TextEditingController pickup = TextEditingController();
    TextEditingController drop = TextEditingController();
    TextEditingController mobile = TextEditingController();

    double totalKm = 0;

    TextTheme theme = Theme.of(context).textTheme;
    RxString date = ''.obs;
    RxString code = '966'.obs;
    RxString package = "Select Package".obs;

    List<Map<String, dynamic>> images = [
      {"img": "assets/images/car1.png", "size": "4"},
      {"img": "assets/images/Car2.png", "size": "8"},
      {"img": "assets/images/Car3.png", "size": "16"},
      {"img": "assets/images/car4.png", "size": "42"}
    ];
    RxInt _activePage = 0.obs;
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
        title: Text("Cabs"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Homepage()));
          },
        ),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(2.h),
        child: Column(children: [
          Row(
            children: [
              for (int i = 0; i < cabs.length; i++)
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () async {
                      for (int i = 0; i < cabs.length; i++) {
                        cabs[i]["isSelected"] = false;
                      }

                      setState(() {
                        cabs[i]["isSelected"] = true;
                        _selectedVal = cabs[i]["name"];
                      });
                      // await cabController.cabdetail(value: _selectedVal);
                    },
                    child: card(
                        name: cabs[i]["name"],
                        img: cabs[i]["img"],
                        theme: theme,
                        isSelected: cabs[i]["isSelected"]),
                  ),
                )
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          // if (_selectedVal != "Within")
          //   HelperCon(
          //     title: "Package",
          //     widget: CustomDropDown(
          //         // key: Key(math.Random().nextInt(9999).toString()),
          //         hint: package,
          //         items: cabController.cablist.map((item) {
          //           print(item['cab_name']);
          //           print('kkkkk');
          //           return DropdownMenuItem(
          //             value: item,
          //             child: Text(item['cab_name']),
          //           );
          //         }).toList(),
          //         onChanged: (newVal) {
          //           print(newVal);

          //           // value: dropdownvalue,
          //         }),
          //   ),
          // if (_selectedVal == "Within")
          HelperCon(
            title: "",
            widget: Container(
              padding: EdgeInsets.all(1.h),
              decoration: BoxDecoration(
                color: ColorConst.whiteShadow,
                borderRadius: BorderRadius.circular(10),
              ),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset("assets/images/nav.svg",
                            height: 1.5.h),
                        SizedBox(height: 0.8.h),
                        SvgPicture.asset("assets/images/vline.svg",
                            height: 3.2.h),
                        SizedBox(height: 0.8.h),
                        SvgPicture.asset("assets/images/pin.svg", height: 1.5.h)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                Expanded(
                  flex: 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      CustomTextField(
                          control: pickup,
                          hint: "Enter Pickup Destination",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isRequired: false,
                          keyboardType: TextInputType.streetAddress,
                          isNumber: false,
                          textFieldTap: () {
                            print("boy");
                            geoController.resetDropSuggestions();
                          },
                          onChanged: (value) {
                            if (_pickUpDebounce?.isActive ?? false)
                              _pickUpDebounce!.cancel();
                            _pickUpDebounce = Timer(
                                const Duration(microseconds: 500), () async {
                              await geoController.getPickUpSuggestions(
                                  input: value);
                              // cabController.pickup.value = value;
                            });
                          },
                          textInputAction: TextInputAction.next,
                          style: theme.displaySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorConst.blackColor)),
                      Obx(() {
                        if (geoController.geoPickUpSuggestions.length != 0)
                          return Container(
                            constraints: BoxConstraints(
                                minHeight: 5.h,
                                minWidth: 100.w,
                                maxHeight: 20.h),
                            decoration: BoxDecoration(
                              color: ColorConst.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: geoController
                                        .geoPickUpSuggestions.length,
                                    itemBuilder: ((context, index) {
                                      return ListTile(
                                          visualDensity: VisualDensity.compact,
                                          dense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 10),
                                          leading:
                                              const Icon(Icons.location_on),
                                          onTap: () {
                                            pickup.text = geoController
                                                .geoPickUpSuggestions[index]
                                                .descriptions;
                                            var pickUpId = geoController
                                                .geoPickUpSuggestions[index]
                                                .placeId;
                                            cabController.pickup.value =
                                                pickup.text;
                                            geoController
                                                .resetPickUpSuggestions();
                                          },
                                          title: Text(geoController
                                              .geoPickUpSuggestions[index]
                                              .descriptions));
                                    }))),
                          );

                          
                        return SizedBox();
                      }),
                      Divider(
                        height: 0.2,
                        endIndent: 35.w,
                      ),
                      CustomTextField(
                          control: drop,
                          hint: "Enter Drop Destination",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isRequired: false,
                          keyboardType: TextInputType.streetAddress,
                          isNumber: false,
                          textFieldTap: () {
                            geoController.resetPickUpSuggestions();
                          },
                          onChanged: (value) {
                            if (_dropDebounce?.isActive ?? false)
                              _dropDebounce!.cancel();
                            _dropDebounce = Timer(
                                const Duration(microseconds: 500), () async {
                              await geoController.getDropSuggestions(
                                  input: value);
                            });
                          },
                          textInputAction: TextInputAction.done,
                          style: theme.displaySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorConst.blackColor)),
                      Obx(() {
                        if (geoController.geoDropSuggestions.length != 0)
                          return Container(
                            width: 100.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              color: ColorConst.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ListView.builder(
                                    itemCount:
                                        geoController.geoDropSuggestions.length,
                                    itemBuilder: ((context, index) {
                                      return ListTile(
                                          visualDensity: VisualDensity.compact,
                                          dense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 10),
                                          leading:
                                              const Icon(Icons.location_on),
                                          onTap: () {
                                            drop.text = geoController
                                                .geoDropSuggestions[index]
                                                .descriptions;
                                            var dropId = geoController
                                                .geoDropSuggestions[index]
                                                .placeId;
                                            cabController.drop.value =
                                                drop.text;
                                            geoController
                                                .resetDropSuggestions();
                                          },
                                          title: Text(geoController
                                              .geoDropSuggestions[index]
                                              .descriptions));
                                    }))),
                          );
                        return SizedBox();
                      }),
                    ],
                  ),
                )
              ]),
            ),
          ),
          HelperCon(
            title: "Mobile No.",
            widget: CustomTextField(
                maxLength: 10,
                control: mobile,
                hint: "Mobile Number",
                isRequired: true,
                prefIcon: Container(
                  margin: EdgeInsets.all(2.w),
                  width: 28.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorConst.whiteColor,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                          () => Text(
                            ' +${code.value}',
                            style: theme.headlineMedium?.copyWith(
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
                                    searchTextStyle: theme.displaySmall!
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
                keyboardType: TextInputType.number,
                isNumber: true,
                textInputAction: TextInputAction.next,
                style: theme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w500, color: ColorConst.blackColor)),
          ),
          // HelperCon(
          //   title: "Mobile Number",
          //   widget: CustomTextField(
          //       control: mobile,
          //       hint: "Enter Mobile no",
          //       isRequired: true,
          //       keyboardType: TextInputType.number,
          //       isNumber: false,
          //       maxLength: 10,
          //       textInputAction: TextInputAction.next,
          //       style: theme.headlineMedium!.copyWith(
          //           fontWeight: FontWeight.w400, color: ColorConst.blackColor)),
          // ),
          if (_selectedVal != "Within")
            HelperCon(
              title: "Date of Travel",
              widget: DatePicker(
                firstDate: DateTime.now(),
                value: date,
                onSelect: (picked) {
                  cabController.date.value = picked;
                },
              ),
            ),
          if (_selectedVal != "Within")
            HelperCon(
              title: "Time of Travel",
              widget: TimePicker(
                onSelect: (time) {
                  cabController.time.value = time;
                },
              ),
            ),

          HelperCon(
            title: "Select Car Size",
            padding: EdgeInsets.only(bottom: 5, top: 6),
            widget: Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 10),
                  child: CarouselSlider.builder(
                    itemCount: images.length,
                    itemBuilder: ((context, index, realIndex) {
                      return InkWell(
                        onTap: () async {
                          String type;

                          if (_selectedVal == 'Within') {
                            type = 'in city';
                          } else {
                            type = 'outstation';
                          }

                          dev.Tuple2 result = (await cabController.cabdetail(
                              value: type, size: images[index]["size"]));
                          if (result.value1) {
                            if (Helpers.isNull(pickup.text) ||
                                Helpers.isNull(drop.text)) {
                              return Helpers.showSnackbar(
                                  text: "Pickup and Drop is required",
                                  color: ColorConst.redColor,
                                  context: context);
                            }
                            // var pickUpCoordinates = await Geocoder.local
                            //     .findAddressesFromQuery(pickup.text);
                            // var dropCoordinates = await Geocoder.local
                            //     .findAddressesFromQuery(drop.text);

                            // if (_selectedVal == "Within") {
                            //   if (dropCoordinates.first.locality !=
                            //       pickUpCoordinates.first.locality) {
                            //     return Helpers.showSnackbar(
                            //         text:
                            //             "Both destination are of different city please choose outstation",
                            //         color: ColorConst.redColor,
                            //         context: context);
                            //   }
                            // } else {
                            //   List packageSplit = package.split("-");
                            //
                            //   // if (pickUpCoordinates.first.locality
                            //   //             .toLowerCase() !=
                            //   //         packageSplit[0].toLowerCase() ||
                            //   //     dropCoordinates.first.locality
                            //   //             .toLowerCase() !=
                            //   //         packageSplit[1].toLowerCase()) {
                            //   //   return Helpers.showSnackbar(
                            //   //       text:
                            //   //           "Destination is invalid",
                            //   //       color: ColorConst.redColor,
                            //   //       context: context);
                            //   // }
                            //
                            //   Map data = {
                            //     "Package": package,
                            //     "Date": cabController.date.value,
                            //     "Time": cabController.time.value
                            //   };
                            //
                            //   // for (var k in data.keys) {
                            //   //   if (Helpers.isNull(data[k]) ||
                            //   //       data[k] == 'Select Package') {
                            //   //     return Helpers.showSnackbar(
                            //   //         text: "${k} is required",
                            //   //         color: ColorConst.redColor,
                            //   //         context: context);
                            //   //   }
                            //   // }
                            // }
                            //
                            // totalKm = Helpers.toDouble(
                            //     await (Geolocator.distanceBetween(
                            //               dropCoordinates
                            //                   .first.coordinates.latitude,
                            //               dropCoordinates
                            //                   .first.coordinates.longitude,
                            //               pickUpCoordinates
                            //                   .first.coordinates.latitude,
                            //               pickUpCoordinates
                            //                   .first.coordinates.longitude,
                            //             ) /
                            //             1000)
                            //         .toStringAsFixed(1));

                            if (totalKm == 0) {
                              return Helpers.showSnackbar(
                                  text:
                                      "No cabs available for this destination",
                                  color: ColorConst.redColor,
                                  context: context);
                            }
                            isLogin.isTrue
                                ? Get.to(CabType(
                                    totalKm: totalKm,
                                    type: _selectedVal,
                                    mobile: mobile.text,
                                    dateOfTravel: cabController.date.value,
                                    timeOfTravel: cabController.time.value))
                                : Get.to(LoginPage());
                          } else {
                            Helpers.showSnackbar(
                                text: 'Currently no cabs are available',
                                color: ColorConst.redColor,
                                context: context);
                          }
                        },
                        child: Container(
                          height: 35.h,
                          width: 45.w,
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.0, color: ColorConst.greyColor),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage(images[index]["img"]),
                              )),
                        ),
                      );
                    }),
                    options: CarouselOptions(
                        viewportFraction: 0.6,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          _activePage.value = index;
                        }),
                  ),
                ),

                // Obx(
                //   () => Positioned(
                //     top: 19.h,
                //     left: 26.w,
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: List.generate(
                //         images.length,
                //         (index) => Padding(
                //           padding: const EdgeInsets.all( 10),
                //           child: Container(
                //             decoration: BoxDecoration(
                //                 border: Border.all(
                //                     color: _activePage == index
                //                         ? ColorConst.kGreenColor
                //                         : Colors.transparent),
                //                 shape: BoxShape.circle),
                //             padding: EdgeInsets.all(3),
                //             child: CircleAvatar(
                //               radius: 4,
                //               backgroundColor: _activePage == index
                //                   ? ColorConst.kGreenColor
                //                   : ColorConst.greyColor,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          // : SizedBox(
          //     child: CustomButton(
          //       left: 10,
          //       right: 10,
          //       height: 35,
          //       width: 143,
          //       textStyle:
          //           TextStyle(fontSize: 12, color: ColorConst.blackColor),
          //       name: 'login to continue',
          //       color: ColorConst.kGreenColor,
          //       onTap: () {
          //         Get.to(LoginPage());
          //       },
          //     ),
          //   ),
          SizedBox(
            height: 2.h,
          ),
          // if (_selectedVal == "outstation")
          //   CustomButton(
          //       height: 6.h,
          //       color: ColorConst.kGreenColor,
          //       textStyle: theme.displaySmall,
          //       name: "Book Now",
          //       onTap: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (builder) {
          //               return CabFinalising(
          //                 price: widget.price.toString(),
          //                 cabType: _selectedVal,
          //                 package: package.value,
          //                 pickup: pickup.text,
          //                 drop: drop.text,
          //                 date: date.value,
          //                 time: setTime,
          //                 seater: '4',
          //                 type: _selectedVal,
          //                 totalKm: 0,
          //               );
          //             },
          //           ),
          //         );
          //       }),
          SizedBox(height: 3.h)
        ]),
      ),
    );
  }
}

Widget card(
    {required String name,
    required String img,
    required TextTheme theme,
    required bool isSelected}) {
  return Container(
    height: 18.h,
    width: 100.w,
    padding: EdgeInsets.only(left: 2.h, bottom: 1.h),
    margin: EdgeInsets.symmetric(horizontal: 0.8.h),
    decoration: BoxDecoration(
      border: Border.all(
          color:
              isSelected == true ? ColorConst.kGreenColor : Colors.transparent),
      borderRadius: BorderRadius.circular(10),
      color: ColorConst.whiteShadow,
      image: DecorationImage(image: AssetImage(img), fit: BoxFit.scaleDown),
    ),
    child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          name,
          style: theme.displaySmall?.copyWith(color: ColorConst.blackColor),
        )),
  );
}

Widget Contain({CabImage? imagepath}) {
  return Container(
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.all(8),
      width: 230,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://nodejs.hackerkernel.com/hexatour/public${imagepath?.imagepath}'),
              fit: BoxFit.cover),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 231, 227, 227),
                spreadRadius: 2,
                offset: Offset(1, 3),
                blurRadius: 3.0)
          ],
          color: ColorConst.whiteColor,
          borderRadius: BorderRadius.circular(9)));
}


