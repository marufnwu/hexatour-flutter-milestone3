import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/colors.dart';
import '../../../controllers/tour_controller.dart';
import '../../../models/tour/Tour_model.dart';

class TourActivity extends StatefulWidget {
  TourActivity({Key? key});

  State<TourActivity> createState() => _TourActivityState();
}

class _TourActivityState extends State<TourActivity> {
  final tourController = Get.find<TourController>();
  List<String> images = [
    "https://t4.ftcdn.net/jpg/02/40/98/49/360_F_240984942_eZXNlIqQ0SRIMyIZMOqVYG3kAmKqpCPJ.jpg",
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
    "https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?cs=srgb&dl=pexels-pixabay-268533.jpg&fm=jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConst.kGreenColor,
          title: Text(''),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          // color: ColorConst.blueColor,
          child: ListView.builder(
                  shrinkWrap: true,
              padding: EdgeInsets.all(2.h),
              itemCount: tourController.tourPackage.length,
              itemBuilder: (context, index) {
                return exclusiveactivity( imagepath: tourController.tourPackage[index].images[0], );

                //
              }),
        ));
  }
}


Widget exclusiveactivity(
    {
    required TourImage imagepath,
 
   }) {
  
  return Container(
    height: 30.h,
    width: 30.w,
    margin: EdgeInsets.only(top: 1.5.h),
    padding: EdgeInsets.all(2.w),
    decoration: BoxDecoration(

        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(33, 30, 30, 0.239),
            offset: Offset(0, 10),
            blurRadius: 15,
          ),
          BoxShadow(
              color: Color.fromARGB(255, 245, 245, 245),
              offset: Offset(0.0, 0.0),
              blurRadius: 0,
              spreadRadius: 0)],
       borderRadius: BorderRadius.circular(12),
    image: DecorationImage(image: NetworkImage('https://nodejs.hackerkernel.com/hexatour/public${imagepath.imagepath}'),fit: BoxFit.contain)
    
     
    ),
  );
}