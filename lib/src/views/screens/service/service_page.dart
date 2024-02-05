import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/models/service/service_model.dart';
import 'package:hexatour/src/views/screens/auth/login_page.dart';
import 'package:hexatour/src/views/screens/service/view_service_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/servie_controller.dart';
import '../../widgets/buttons/custom_button.dart';

class Servicepage extends StatefulWidget {
  Servicepage(
      {Key? key,
      required this.id,
      required this.imagepath,
      required this.service_name})
      : super(key: key);

  final String service_name;

  final int id;

  final ServiceImages? imagepath;

  @override
  State<Servicepage> createState() => _ServicepageState();
}

class _ServicepageState extends State<Servicepage> {
  final serviceController = Get.find<ServiceController>();
  final RxBool isLogin = false.obs;
  List<String> images = [
    "https://t4.ftcdn.net/jpg/02/40/98/49/360_F_240984942_eZXNlIqQ0SRIMyIZMOqVYG3kAmKqpCPJ.jpg",
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
    "https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?cs=srgb&dl=pexels-pixabay-268533.jpg&fm=jpg"
  ];
  Future<void> isLoggedin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin.value = await prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoggedin();
  }

//

  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      height: 16.h,
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(104, 98, 98, 0.231),
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.white,
            offset: const Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ),
        ],
        border: Border.all(
          width: 0.4,
          color: const Color(0xffEDEDED),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 110,
              width: 98,
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://nodejs.hackerkernel.com/hexatour/public${widget.imagepath?.imagepath}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.transparent,
                      child: const Icon(Icons.room_service, size: 50),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: EdgeInsets.only(top: 0.8.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.h,
                      child: Text(
                        widget.service_name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.displaySmall?.copyWith(
                            color: ColorConst.blackColor, fontSize: 13.5.sp),
                      ),
                    ),
                    CustomButton(
                      width: 19.w,
                      height: 4.h,
                      radius: 5,
                      color: ColorConst.kGreenColor,
                      name: "View",
                      textStyle: textTheme.displaySmall,
                      onTap: () async {
                        bool ser = await serviceController.serviceDetail(
                            id: widget.id);
                        // print(widget.id);
                        print('serviceiddddd');
                        if (ser)
                          isLogin.isTrue
                              ? Get.to(ViewServicePage(
                                  id: serviceController.servicedata.value.id!,
                                  name: serviceController
                                      .servicedata.value.serviceName!,
                                  service_price: serviceController
                                      .servicedata.value.servicePrice!,
                                  description: serviceController
                                      .servicedata.value.description!,
                                  imagepath: serviceController
                                      .servicedata.value.images!))
                              : Get.to(LoginPage());
                      },
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
