import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/utils/constant.dart';
import '../../../../../controllers/cab_controller.dart';
import '../../../../widgets/custom_container/cab_container.dart';



class CompletedCabTabBarView extends StatefulWidget {
  const CompletedCabTabBarView({Key? key}) : super(key: key);

  @override
  State<CompletedCabTabBarView> createState() => _CompletedCabTabBarViewState();
}

class _CompletedCabTabBarViewState extends State<CompletedCabTabBarView> {

  final cabController = Get.find<CabController>();

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
    var a = await cabController.cabBookings(value: '2');
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
          if(cabController.myCabs.isEmpty || (cabController.myCabs.length == 1 && cabController.myCabs[0].id == 0))Center(child: Text('No Completed cabs.'),)
          else ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(1.5.h),
              itemCount: cabController.myCabs.length,
              itemBuilder: (context, index) {
                return CabContainer(
                    pickup: cabController.myCabs.value[index].name!.split('-')[0],
                    drop: cabController.myCabs.value[index].name!.split('-')[1],
                    btnName: "Cancel",
                    onTap: () {});
              }),
          if(loading.value == true)MyLoader(),

        ],
      ),
    );
  }

}
