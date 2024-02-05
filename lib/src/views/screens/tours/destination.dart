import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/tour_controller.dart';



class ViewDestination extends StatefulWidget {
  final String duration;
  const ViewDestination({
    required this.duration,
    Key? key,
  });

  @override
  State<ViewDestination> createState() => _ViewDestinationState();
}

class _ViewDestinationState extends State<ViewDestination> {
  TourController tourController = Get.find<TourController>();
  @override
  Widget build(BuildContext context) {
   
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          centerTitle: true,
          title: Text('View Destination'),
          backgroundColor: Color.fromARGB(255, 147, 228, 150),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: ColorConst.kGreenColor,
              image: DecorationImage(
                image: AssetImage("assets/images/appbar.png"),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          // height: 120.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Cont(widget.duration, context),
              SizedBox(
                height: 3.h,
              ),
              for (int i = 0; i < tourController.allLocations.length; i++) ...{
                cont1(tourController.allLocations[i], context,
                    curIndex: i,
                    lastIndex: tourController.allLocations.length - 1)
              },
              //
              SizedBox(
                height: 5.h,
              ),
              Cont1('Open on google map', context)
            ],
          ),
        ),
      ),
    );
  }
}

Widget Cont(times, context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return Container(
    margin: EdgeInsets.fromLTRB(39, 17, 26, 8),
    height: 6.h,
    width: 79.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color.fromARGB(31, 141, 126, 126), width: 1),
      color: ColorConst.whiteColor,
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: Color.fromARGB(135, 216, 212, 212),
            blurRadius: 10.0,
            offset: Offset(0.0, 0.75))
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image(
          image: AssetImage('assets/images/timer.png'),
          height: 30,
          width: 30,
        ),
        Text(
          'duration: ${times}',
          style: textTheme.headlineMedium!.copyWith(
              color: ColorConst.blackColor, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 0.5.w,
        ),
        // 
      ],
    ),
  );
}

Widget Cont1(name, context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return InkWell(
    //
    child: Container(
      margin: EdgeInsets.all(15),
      height: 7.h,
      width: 100.w,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorConst.kGreenColor,
        borderRadius: BorderRadius.circular(10),
        
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name,
              style: textTheme.displaySmall!.copyWith(
                  color: ColorConst.whiteColor, fontWeight: FontWeight.w400)),
          Icon(
            Icons.keyboard_arrow_right_sharp,
            color: ColorConst.whiteColor,
          ),
        ],
      ),
    ),
  );
}

Widget cont1(name, context, {int? curIndex, int? lastIndex}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 3, 4, 2),
        child: Image(
          image: AssetImage('assets/images/11.png'),
        ),
      ),
      Row(
       
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(33.0, 0, 6, 0),
            child: Text(name,
                textAlign: TextAlign.start,
                style: textTheme.headlineMedium!.copyWith(
                    color: ColorConst.blackColor, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
      if(curIndex!=lastIndex)
      Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 0.5, 9, 0),
        child: Image(
          image: AssetImage('assets/images/line1.png'),
          height: 7.h,
        ),
      ),
      //
  ]);
}

Widget help1(name, context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return Container(
    margin: EdgeInsets.fromLTRB(80, 0, 6, 0),
    child: Text(name,
        style: textTheme.headlineSmall!.copyWith(
            color: ColorConst.kGreenColor, fontWeight: FontWeight.w700)),
  );
}

Widget cont2(name, name1, context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return Row(
    children: [
      Container(
        margin: EdgeInsets.fromLTRB(15, 1, 7, 1),
        height: 7.h,
        width: 7.h,
        child: Image(
          image: AssetImage('assets/images/11.png'),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style: textTheme.headlineMedium!.copyWith(
                  color: ColorConst.blackColor, fontWeight: FontWeight.w700)),
          Text(name1,
              style: textTheme.headlineSmall!.copyWith(
                  color: ColorConst.greyColor, fontWeight: FontWeight.w700)),
          Text('Starting point',
              style: textTheme.headlineSmall!.copyWith(
                  color: ColorConst.kGreenColor, fontWeight: FontWeight.w700)),
        ],
      )
    ],
  );
}
