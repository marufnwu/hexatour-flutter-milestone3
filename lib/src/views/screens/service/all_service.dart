import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/controllers/servie_controller.dart';
import 'package:hexatour/src/models/service/service_model.dart';
import 'package:hexatour/src/views/screens/auth/login_page.dart';
import 'package:hexatour/src/views/screens/service/service_search.dart';
import 'package:hexatour/src/views/widgets/buttons/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../home/home_page.dart';
import 'view_service_page.dart';

class AllServices extends StatefulWidget {
  const AllServices({super.key});

  @override
  State<AllServices> createState() => _AllServicesState();
}

class _AllServicesState extends State<AllServices> {
  final serviceController = Get.find<ServiceController>();
  TextEditingController searchservicecontroller = TextEditingController();
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
    serviceController.getService();
    super.initState();
    isLoggedin();
  }

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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Homepage()));
          },
        ),
        title: const Text('Services'),
        centerTitle: true,
        backgroundColor: ColorConst.kGreenColor,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: ColorConst.kGreenColor,
            image: DecorationImage(
              image: AssetImage("assets/images/appbar.png"),
            ),
          ),
        ),
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            onPressed: () {
              Get.to(ServiceSearchPage());
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Obx(
        () {
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: serviceController.service.length,
            itemBuilder: ((context, index) {
              return allServices(
                  name: serviceController.service[index].serviceName,
                  imagepath: serviceController.service[index].images[0],
                  textTheme: Theme.of(context).textTheme,
                  onTap: () async {
                    bool res = await serviceController.serviceDetail(
                        id: serviceController.service[index].id);
                    if (res)
                      isLogin.isTrue
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => ViewServicePage(
                                        id: serviceController
                                            .servicedata.value.id!,
                                        name: serviceController
                                            .servicedata.value.serviceName!,
                                        imagepath: serviceController
                                            .servicedata.value.images!,
                                        service_price: serviceController
                                            .servicedata.value.servicePrice!,
                                        description: serviceController
                                            .servicedata.value.description!,
                                      )))
                          : Get.to(LoginPage());
                  });
            }),
          );
        },
      ),
    );
  }
}

Widget allServices(
    {String? name,
    ServiceImages? imagepath,
    TextTheme? textTheme,
    Function()? onTap}) {
  return Container(
    height: 16.h,
    margin: EdgeInsets.only(bottom: 2.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(179, 175, 175, 0.243),
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
            // color: Colors.amber,
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://nodejs.hackerkernel.com/hexatour/public${imagepath?.imagepath}',
                // color: Colors.amber,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Color.fromARGB(0, 136, 24, 24),
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 8.h,
                child: Text(
                  name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme!.displaySmall?.copyWith(
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
                  onTap: onTap!),
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
