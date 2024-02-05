import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/utils/constant.dart';
import '../../../../../controllers/servie_controller.dart';
import '../../../../widgets/custom_container/img_container.dart';
import '../../../my_bookings/view_booking.dart';

class CompletedServiceTabBarView extends StatefulWidget {
  const CompletedServiceTabBarView({Key? key}) : super(key: key);

  @override
  State<CompletedServiceTabBarView> createState() => _CompletedServiceTabBarViewState();
}

class _CompletedServiceTabBarViewState extends State<CompletedServiceTabBarView> {

  final serviceController = Get.find<ServiceController>();

  RxBool loading = true.obs;

  @override
  void initState() {
    
    super.initState();
    Future.delayed(Duration(milliseconds: 100),(){
      getdata();
    });
  }

  getdata()async{
    var a = await serviceController.serviceBookings(value: '2');
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
