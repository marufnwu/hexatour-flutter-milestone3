import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_picker/country_picker.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/controllers/geo_controller.dart';
import 'package:hexatour/src/views/screens/auth/login_page.dart';
import 'package:hexatour/src/views/screens/tours/destination.dart';
import 'package:hexatour/src/views/screens/tours/package_payment.dart';
import 'package:hexatour/src/views/screens/tours/tour_activity.dart';
import 'package:hexatour/src/views/screens/tours/widgets/tour_detail_widget.dart';
import 'package:hexatour/src/views/widgets/buttons/custom_button.dart';
import 'package:hexatour/src/views/widgets/date_time_picker/date_picker.dart';
import 'package:hexatour/src/views/widgets/textfields/custom_textfield.dart';
import 'package:intl/intl.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/languages.dart';
import 'package:language_picker/languages.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/utils/Helpers.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/tour_controller.dart';
import '../../../models/tour/tour_detail_model.dart';
import '../../widgets/custom_container/helper_container.dart';
import '../../widgets/date_time_picker/time_picker.dart';
import '../../widgets/dropdown/customdropdown.dart';

// ignore: must_be_immutable
class TourdetailPage extends StatefulWidget {
  List<String> images = [
    "https://t4.ftcdn.net/jpg/02/40/98/49/360_F_240984942_eZXNlIqQ0SRIMyIZMOqVYG3kAmKqpCPJ.jpg",
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
    "https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?cs=srgb&dl=pexels-pixabay-268533.jpg&fm=jpg"
  ];

  TourdetailPage({
    Key? key,
    required this.id,
    required this.no_of_person,
    required this.imagepath,
    required this.description,
    required this.tourname,
    required this.duration,
    required this.price,
    required this.minimumBookingAmount,
    this.firstDate,
  }) : super(key: key);

  final List<TourImages> imagepath;
  final String tourname;
  final String description;
  final int id;
  final String price;
  final String no_of_person;
  final String duration;
  final String minimumBookingAmount;
  final firstDate;

  @override
  State<TourdetailPage> createState() => _TourdetailPageState();
}

class _TourdetailPageState extends State<TourdetailPage> {
  final _formKey = GlobalKey<FormState>();
  CarouselController controller = CarouselController();
  final tourController = Get.find<TourController>();
  final geoController = Get.find<GeoController>();
  TextEditingController phoneControl = TextEditingController();
  TextEditingController languageControl = TextEditingController();
  TextEditingController hotelControl = TextEditingController();
  TextEditingController roomControl = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  String dateOfTravel = '';
  String timeOfTravel = '';
  final authController = Get.find<AuthController>();
  RxString dates = ''.obs;
  RxString code = '966'.obs;
  RxString nation = "Select Nationality".obs;
  RxString package = "Select Language".obs;
  bool _validate = false;
  Timer? _hotelNameDebounce;
  final RxBool isLogin = false.obs;
  // List of items in our dropdown menu
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  String setTime = '';
  late String _hour, _minute, _time;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  Future<void> isLoggedin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin.value = await prefs.getBool('isLoggedIn') ?? false;
  }

  void showSnackbar() {
    print('fbgjhvbjdm');
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text('This is a Snackbar'),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime.utc(2099));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
      //   _timeController.text = format(
      //       DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
      //       [hh, ':', nn, " ", am]).toString();
      });
  }

  void buildLanguageDialog(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    showDialog(
        context: context,
        useRootNavigator: false,
        builder: (builder) {
          return Dialog(
            key: scaffoldMessengerKey,
            insetPadding: EdgeInsets.all(2.h),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(1, 5, 1, 7),
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
                  Text('Please enter your detail, for pickup',
                      textAlign: TextAlign.center,
                      style: theme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorConst.blackColor)),
                  SizedBox(height: 3.h),
                  Form(
                      key: _formKey,
                      child: Column(children: [
                        help(
                            padding: EdgeInsets.only(left: 3.w, right: 3.w),
                            title: "Hotel name",
                            widget: CustomTextField(
                                control: hotelControl,
                                hint: "Enter Hotel name",
                                isRequired: true,
                                errortext:
                                    _validate ? 'Value Can\'t Be Empty' : null,
                                keyboardType: TextInputType.name,
                                isNumber: false,
                                onChanged: (value) {
                                  if (_hotelNameDebounce?.isActive ?? false)
                                    _hotelNameDebounce!.cancel();
                                  _hotelNameDebounce =
                                      Timer(const Duration(microseconds: 500),
                                          () async {
                                    await geoController.getPickUpSuggestions(
                                        input: value, types: 'establishment');
                                  });
                                },
                                textInputAction: TextInputAction.next,
                                style: theme.headlineMedium!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: ColorConst.blackColor)),
                            theme: theme),
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
                                  padding: const EdgeInsets.all(0.0),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: geoController
                                          .geoPickUpSuggestions.length,
                                      itemBuilder: ((context, index) {
                                        return ListTile(
                                            visualDensity:
                                                VisualDensity.compact,
                                            dense: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 10),
                                            leading:
                                                const Icon(Icons.location_on),
                                            onTap: () {
                                              hotelControl.text = geoController
                                                  .geoPickUpSuggestions[index]
                                                  .descriptions;
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
                        SizedBox(
                          height: 2.h,
                        ),
                        help(
                            title: "Room no",
                            widget: CustomTextField(
                                control: roomControl,
                                hint: "Enter Room no",
                                isRequired: true,
                                errortext:
                                    _validate ? 'Value Can\'t Be Empty' : null,
                                keyboardType: TextInputType.name,
                                isNumber: false,
                                textInputAction: TextInputAction.next,
                                style: theme.headlineMedium!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: ColorConst.blackColor)),
                            theme: theme),
                        // help(
                        //     title: "Mobile Number",
                        //     widget: CustomTextField(
                        //         control: phoneControl,
                        //         hint: "Enter Mobile no",
                        //         isRequired: true,
                        //         keyboardType: TextInputType.number,
                        //         isNumber: false,
                        //         maxLength: 10,
                        //         textInputAction: TextInputAction.next,
                        //         style: theme.headlineMedium!.copyWith(
                        //             fontWeight: FontWeight.w400,
                        //             color: ColorConst.blackColor)),
                        //     theme: theme),
                        HelperCon(
                          padding: EdgeInsets.only(
                              bottom: 2.h, left: 3.w, right: 3.w),
                          title: "Mobile No.",
                          style: theme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorConst.blackColor),
                          widget: CustomTextField(
                            maxLength: 10,
                            errortext:
                                _validate ? 'Value Can\'t Be Empty' : null,
                            control: phoneControl,
                            hint: "Mobile Number",
                            isRequired: true,
                            style: theme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.w400,
                                color: ColorConst.blackColor),
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
                                                    hintText:
                                                        'Select country code',
                                                    hintStyle: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall
                                                        ?.copyWith(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    70,
                                                                    65,
                                                                    65),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                searchTextStyle: theme
                                                    .displaySmall!
                                                    .copyWith(
                                                        color: ColorConst
                                                            .blackColor)),
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
                          ),
                        ),

                         
                        help(
                          title: "Time of Travel",
                          widget: Container(
                            height: 7.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xffF4F6F8),
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.only(left: 4.w),
                            child: InkWell(
                              onTap: () {
                                _selectTime(context);
                              },
                              child: TextFormField(
                                style: TextStyle(
                                    fontSize: 16, color: ColorConst.blackColor),
                                decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.access_time_outlined,
                                        color:
                                            Color.fromARGB(255, 135, 135, 135)),
                                    hintText: 'Select Time',
                                    hintStyle: TextStyle(
                                        color: Colors.black45, fontSize: 16)),
                                // textAlign: TextAlign.center,
                                enabled: false,
                                keyboardType: TextInputType.text,
                                controller : _timeController,
                                onSaved: (String ?vale) {
                                  tourController.time.value = vale!;
                                  print(tourController.time.value);
                                },
                              ),
                            ),
                          ),
                          theme: theme,
                        ),
                        help(
                          title: "Date of Travel",
                          widget: Container(
                            height: 7.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xffF4F6F8),
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.only(left: 4.w),
                            child: InkWell(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: TextFormField(
                                style: TextStyle(
                                    fontSize: 16, color: ColorConst.blackColor),
                                decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.calendar_month_rounded,
                                      color: Color.fromARGB(255, 95, 94, 94),
                                    ),
                                    hintText: 'Select Date',
                                    hintStyle: TextStyle(
                                        color: Colors.black45, fontSize: 16)),
                                // textAlign: TextAlign.center,
                                enabled: false,
                                keyboardType: TextInputType.text,
                                controller: _dateController,
                                onSaved: (String? vali) {
                                  tourController.date.value = vali!;
                                  print( tourController.date.value);
                                },
                              ),
                            ),
                          ),
                          theme: theme,
                        ),
                      ])),

                  help(
                      title: "Preferred language",
                      widget: LanguagePickerDropdown(
                          initialValue: Languages.arabic,
                          onValuePicked: (Language language) {
                            print(language.name);
                          }),
                      theme: theme),

                  //
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ColorConst.kGreenColor),
                          shape: MaterialStateProperty.all<OutlinedBorder?>(
                              RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                          shadowColor: MaterialStateProperty.all<Color>(
                              ColorConst.kGreenColor),
                          elevation: MaterialStateProperty.all<double>(13.0),
                          padding: MaterialStateProperty.resolveWith<
                              EdgeInsetsGeometry>((Set<MaterialState> states) {
                            return const EdgeInsets.fromLTRB(60, 14, 60, 14);
                          })),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // if (Helpers.isNull(timeOfTravel)) {
                          //   print('not intresteddd');
                          //   return showSnackbar();
                          // } else if (Helpers.isNull(dateOfTravel)) {
                          //   return showSnackbar();
                          // }
                          isLogin.isTrue
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => PackagePayment(
                                          tourName: widget.tourname,
                                          price: widget.price,
                                          mobile: phoneControl.text,
                                          
                                          dateOfTravel: _dateController.text,
                                          timeOfTravel: _timeController.text,
                                          minimumBookingAmount:
                                              widget.minimumBookingAmount))))
                              : Get.to(LoginPage());
                        }
                      },
                      child: Text(
                        "Pay now",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      )),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          );
          //
        });
  }

  @override
  void initState() {
    // _timeController.text = formatDate(
    //   DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
    //   [hh, ':', nn, " ", am]).toString();
    super.initState();
    isLoggedin();
  }

  @override
  void dispose() {
    geoController.geoPickUpSuggestions = RxList();
    _hotelNameDebounce?.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    RxInt _activePage = 0.obs;
    return Scaffold(
        // key: scaffoldMessengerKey,
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(widget.tourname, style: textTheme.displaySmall),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              height: 45.h,
              width: 100.w,
              color: ColorConst.blackColor,
              child: CarouselSlider.builder(
                itemCount: 3,
                itemBuilder: ((context, index, realIndex) {
                  return Tours(
                      imagepath: tourController.tourDetails.value.images![0]);
                }),
                options: CarouselOptions(
                    height: 145.h,
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                    // autoPlay: true,
                    enlargeFactor: 0.1,
                    onPageChanged: (index, reason) {
                      _activePage.value = index;
                    }),
              ),
            ),
            Obx(
              () => Positioned(
                bottom: 59.h,
                left: 38.w,
                right: 0,
                height: 80,
                child: Row(
                  children: List.generate(
                      3,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: _activePage == index
                                          ? ColorConst.whiteColor
                                          : Colors.transparent),
                                  shape: BoxShape.circle),
                              padding: EdgeInsets.all(3),
                              child: CircleAvatar(
                                radius: 3,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          )),
                ),
              ),
            ),
            // //
            Container(
              margin: EdgeInsets.only(top: 38.h),
              padding: EdgeInsets.all(3.h),
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // height: 158.h,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.tourname,
                          style: textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConst.blackColor),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.description,
                          textAlign: TextAlign.start,
                          style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConst.blackColor,
                              decoration: TextDecoration.none),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Color.fromARGB(255, 235, 229, 229),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'What include',
                          textAlign: TextAlign.center,
                          style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConst.blackColor,
                              decoration: TextDecoration.none),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            colorContainer('assets/images/ticket.png',
                                ColorConst.kGreenColor, 'tickets'),
                            colorContainer('assets/images/meals.png',
                                ColorConst.greyColor, 'meals'),
                            colorContainer('assets/images/transport.png',
                                ColorConst.lightYellow, 'transport'),
                            InkWell(
                              onTap: () {
                                Get.to(TourActivity());
                              },
                              child: colorContainer(
                                  'assets/images/activity.png',
                                  ColorConst.blueColor,
                                  'activity'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Color.fromARGB(255, 235, 229, 229),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: time(
                                'assets/images/timer.png',
                                'Duration',
                                widget.duration,
                                context,
                              ),
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            Expanded(
                                child: Row(
                              children: [
                                InkWell(
                                  child: Image(
                                      image: AssetImage(
                                          'assets/images/destination.png')),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'View',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: ColorConst.kBlackColor,
                                          decoration: TextDecoration.none),
                                    ),
                                    Text(
                                      'Destination',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: ColorConst.kBlackColor,
                                          decoration: TextDecoration.none),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(ViewDestination(
                                      duration: widget.duration,
                                    ));
                                  },
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: ColorConst.blackColor,
                                    size: 17,
                                  ),
                                )
                              ],
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Color.fromARGB(255, 235, 229, 229),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Maximum number of persons',
                          style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConst.blackColor),
                        ),
                        Text(
                          widget.no_of_person.toString(),
                          style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorConst.blackColor),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Color.fromARGB(255, 235, 229, 229),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Things you will love',
                          style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConst.blackColor),
                        ),
                        points('Perform Ziyarat ', Icons.arrow_right, context),
                        points(' Explore historical sites', Icons.arrow_right,
                            context),
                        points('Try the local cuisine', Icons.arrow_right,
                            context),
                        points(
                            'Shopping in Madinah', Icons.arrow_right, context),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Color.fromARGB(255, 235, 229, 229),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Container(
                          padding: EdgeInsets.all(15),
                          height: 169,
                          width: 336,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: ColorConst.kGrayColor,
                              width: 1,
                            ),
                            color: Color.fromARGB(255, 246, 252, 255),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Package Details',
                                style: textTheme.displaySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: ColorConst.blackColor),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pay',
                                    style: textTheme.displaySmall?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: ColorConst.blackColor),
                                  ),
                                  Text(
                                    '\SAR ${widget.price}',
                                    style: textTheme.displaySmall?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: ColorConst.blackColor),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tax',
                                    style: textTheme.displaySmall?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: ColorConst.blackColor),
                                  ),
                                  Text(
                                    '\SAR 0.00',
                                    style: textTheme.displaySmall?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: ColorConst.blackColor),
                                  ),
                                ],
                              ),
                              Image(
                                  image: AssetImage('assets/images/Line.png')),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: textTheme.displaySmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: ColorConst.blackColor),
                                  ),
                                  Text(
                                    '\SAR ${widget.price}',
                                    style: textTheme.displaySmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: ColorConst.blackColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Payment(context),
                        SizedBox(
                          height: 16,
                        ),
                        CustomButton(
                          radius: 10,
                          color: ColorConst.kGreenColor,
                          width: 100.w,
                          name: "Next",
                          textStyle: textTheme.displaySmall,
                          suficon: Icon(Icons.arrow_right_alt),
                          onTap: () {
                            // authController.isGuest.value == " "
                            //     ?
                            buildLanguageDialog(context);
                            // : SizedBox(
                            //   child: Text('Login to Continue',
                            // style: TextStyle(color: ColorConst.blackColor),),
                            // );
                          },
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        Text(
                          'Related Package',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none,
                              color: ColorConst.kBlackColor),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 22.h,
                          width: 100.w,
                          child: CarouselSlider.builder(
                            itemCount: tourController.tourPackage.length,
                            itemBuilder: ((context, index, realIndex) {
                              return buildImage(
                                  imagepath: tourController
                                      .tourPackage[index].images[0]);
                            }),
                            options: CarouselOptions(
                                height: 140.h,
                                enlargeCenterPage: true,
                                viewportFraction: 0.8,
                                // autoPlay: true,
                                enlargeFactor: 0.1,
                                onPageChanged: (index, reason) {
                                  _activePage.value = index;
                                }),
                          ),
                        ),
                      ]),
                ),
              ),
            )
          ],

          //
        ));
  }
}

Widget _buildDropdownItem(Language language) {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 8.0,
      ),
      Text("${language.name} (${language.isoCode})"),
    ],
  );
}
