import 'package:carousel_slider/carousel_slider.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';

import 'package:hexatour/src/views/screens/service/fill_service_details.dart';
import 'package:hexatour/src/views/widgets/custom_container/custom_container_round.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/home_page_controller.dart';
import '../../../controllers/servie_controller.dart';
import '../../../models/service/service_detail_model.dart';
import '../home/home_page.dart';

class ViewServicePage extends StatefulWidget {
  final id;
  final String name;
  final String description;
  final int service_price;
  final List<ServiceImage> imagepath;
  // final List<String> images;
  ViewServicePage({
    required this.id,
    required this.name,
    required this.service_price,
    required this.description,
    required this.imagepath,
    super.key,
    // required this.images,
  });

  @override
  State<ViewServicePage> createState() => _ViewServicePageState();
}

class _ViewServicePageState extends State<ViewServicePage> {
  CarouselController controller = CarouselController();
  final authController = Get.find<AuthController>();
  final serviceController = Get.find<ServiceController>();
  final homepageController = Get.find<HomePageController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    RxInt _activePage = 0.obs;
    return Scaffold(
      floatingActionButton: DraggableFab(
        initPosition: Offset(90.w, 85.h),
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
        leading: IconButton(
          onPressed: () {
            Get.to(Homepage());
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(widget.name, style: textTheme.displayMedium),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: 40.h,
            width: 100.w,
            child: CarouselSlider.builder(
              itemCount: 3,
              itemBuilder: ((context, index, realIndex) {
                return Services(
                    imagepath: serviceController.servicedata.value.images![0]);
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
          Container(
            margin: EdgeInsets.only(top: 38.h),
            padding: EdgeInsets.all(3.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorConst.whiteColor,
            ),
            child: Container(
              width: 100.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: textTheme.displayMedium?.copyWith(
                        fontSize: 20.sp, color: ColorConst.blackColor),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    widget.description,
                    // widget.description,
                    style: textTheme.displaySmall?.copyWith(
                        color: ColorConst.blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  // CusCon(
                  //   onTap: () async {
                  //     dev.Tuple2 result = (await homepageController
                  //         .getOffertype(value: 'service'));
                  //     if (result.value1) {
                  //       print('hiii');
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: ((context) => OfferDetail())));
                  //     } else {
                  //       print('hellooo');
                  //       Helpers.showSnackbar(
                  //           text: 'Currently no offers are available',
                  //           color: ColorConst.redColor,
                  //           context: context);
                  //     }
                  //   },
                  //   name: "Available Offers",
                  //   style: textTheme.displaySmall!.copyWith(
                  //       color: ColorConst.blackColor,
                  //       fontWeight: FontWeight.w500),
                  // ),
                  // SizedBox(
                  //   height: 1.h,
                  // ),
                  CusCon(
                    onTap: () {},
                    name: "Cancellation policy",
                    style: textTheme.displaySmall!.copyWith(
                        color: ColorConst.blackColor,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 10.h,
              width: 100.w,
              margin: EdgeInsets.only(top: 20.h),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(width: 0.3, color: Color(0xffEDEDED)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -10),
                      blurRadius: 15,
                      color: Color.fromRGBO(221, 221, 221, 0.25),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    )
                  ]),
              child: InkWell(
                onTap: () {
                  Get.to(FillServiceDetails(
                      service_price: widget.service_price,
                      service_id: widget.id));
                  // Get.offAll(FillServiceDetails(
                  //   service_price: widget.service_price,
                  //   )  );
                  // authController.isGuest.value == " "
                  //     ?
                  // Navigator.push(context, MaterialPageRoute(builder: (builder) {
                  //   return FillServiceDetails(
                  //     service_price: widget.service_price,
                  //   );
                  // }));
                  // : SizedBox();
                },
                child: Stack(
                  children: [
                    Container(
                      height: 8.h,
                      width: 100.w,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConst.kGreenColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.all(1.5),
                          padding: EdgeInsets.all(8),
                          width: 39.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorConst.whiteColor,
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Donation amount",
                                    style: textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: ColorConst.blackColor),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '\$' + widget.service_price.toString(),
                                    textAlign: TextAlign.center,
                                    style: textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: ColorConst.kGreenColor),
                                  ),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: Text(
                            "PAY",
                            style: textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorConst.whiteColor),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget Services({ServiceImage? imagepath}) {
  return Container(
      // padding: EdgeInsets.all(6),
      // margin: EdgeInsets.all(8),
      width: 128.w,
      child: InkWell(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://nodejs.hackerkernel.com/hexatour/public${imagepath?.imagepath}'),
              fit: BoxFit.fill),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 231, 227, 227),
                spreadRadius: 2,
                offset: Offset(1, 3),
                blurRadius: 3.0)
          ],
          color: ColorConst.whiteColor,
          borderRadius: BorderRadius.circular(6)));
}
