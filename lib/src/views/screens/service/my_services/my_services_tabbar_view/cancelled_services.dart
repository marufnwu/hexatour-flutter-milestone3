import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/src/views/screens/my_bookings/view_booking.dart';
import 'package:hexatour/src/views/widgets/custom_container/img_container.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/utils/constant.dart';
import '../../../../../controllers/servie_controller.dart';



class CancelledServiceTabBarView extends StatefulWidget {
  const CancelledServiceTabBarView({Key? key}) : super(key: key);

  @override
  State<CancelledServiceTabBarView> createState() => _CancelledServiceTabBarViewState();
}

class _CancelledServiceTabBarViewState extends State<CancelledServiceTabBarView> {

  final serviceController = Get.find<ServiceController>();

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
    var a = await serviceController.serviceBookings(value: '0');
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
          if(serviceController.myServices.isEmpty || (serviceController.myServices.length == 1 && serviceController.myServices[0].id == 0))Center(child: Text('No cancelled Service.'),)
          else ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(1.5.h),
                itemCount: serviceController.myServices.length,
                itemBuilder: (context, index) {
                  return ImgContainer(
                    img: ApiEndpoints.imageurl+serviceController.myServices.value[index].images[0].imagepath,
                    description: serviceController.myServices.value[index].description.toString(),
                    name: serviceController.myServices.value[index].name.toString(),
                    price: serviceController.myServices.value[index].price.toString(),
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
