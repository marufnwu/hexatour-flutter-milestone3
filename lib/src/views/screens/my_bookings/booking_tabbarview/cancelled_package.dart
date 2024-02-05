import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/src/views/screens/my_bookings/view_booking.dart';
import 'package:hexatour/src/views/widgets/custom_container/img_container.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/constant.dart';
import '../../../../controllers/tour_controller.dart';

class CancelledPackageTabBarView extends StatefulWidget {
  const CancelledPackageTabBarView({Key? key}) : super(key: key);

  @override
  State<CancelledPackageTabBarView> createState() => _CancelledPackageTabBarViewState();
}

class _CancelledPackageTabBarViewState extends State<CancelledPackageTabBarView> {
  final tourController = Get.find<TourController>();

  RxBool loading = true.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100),(){
      getdata();
    });
  }

  getdata()async{
    var a = await tourController.tourBookings(value: '0');
    if(a == true){
      loading.value = false;
      // loading.refresh();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
          ()=> Stack(
        children: [
          if(tourController.myTours.isEmpty || (tourController.myTours.length == 1 && tourController.myTours[0].id == 0))Center(child: Text('No Cancelled Tours.'),)
          else ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(2.h),
              itemCount: tourController.myTours.length,
              itemBuilder: (context, index) {
                return ImgContainer(
                  img: ApiEndpoints.imageurl+tourController.myTours.value[index].images[0].imagepath,
                  description: tourController.myTours.value[index].description.toString(),
                  name: tourController.myTours.value[index].name.toString(),
                  price: tourController.myTours.value[index].price.toString(),
                  btnName: "Cancel",
                  onTap: () {
                    Get.to(ViewBookingPage(
                      btnName: "Cancel",
                      onTap: () {
                        print("anything");
                      },
                    ));
                  },
                );
              }),
          if(loading.value == true)MyLoader(),
        ],
      ),
    );
  }
}
