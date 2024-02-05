import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/views/screens/cabs/cab_homepage.dart';
import 'package:hexatour/src/views/screens/home/home_page1.dart';
import 'package:hexatour/src/views/screens/home/islamic/islamic_homepage.dart';
import 'package:hexatour/src/views/screens/my_bookings/my_bookings_tab_page.dart';
import 'package:hexatour/src/views/screens/service/all_service.dart';

import '../../../controllers/cab_controller.dart';
import '../../../controllers/home_page_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../../controllers/servie_controller.dart';
import '../../../controllers/tour_controller.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
   final homepageController = Get.find<HomePageController>();
  final tourController = Get.find<TourController>();
  final serviceController = Get.find<ServiceController>();
  final productController = Get.find<ProductController>();
  final cabController = Get.find<CabController>();
  int _selectedIndex = 0; //default index
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Widget> _widgetOptions = [
    HomePage1(),
    CabHomePage(),
   MyBookingsTabPage(),
    IslamicHomePage(),
    AllServices(),
  ];

  
  @override

  void initState() {
  //  tourController.tours();
  //   serviceController.getService();
  //   serviceController.serviceCategories();
  //   productController.products();
  //   productController.category();
  //   homepageController.getOffers();
  //   homepageController.searchall(value: 'service');
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        // key: scaffoldKey,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CustomLineIndicatorBottomNavbar(
        selectedColor: ColorConst.kGreenColor,
        unSelectedColor: Color.fromARGB(137, 146, 141, 141),
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        unselectedIconSize: 18,
        selectedIconSize: 22,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        enableLineIndicator: true,
        lineIndicatorWidth: 3,
        indicatorType: IndicatorType.Top,
        customBottomBarItems: [
          CustomBottomBarItems(
            label: 'Home',
            // ignore: deprecated_member_use
            icon: FontAwesomeIcons.home,
          ),
          CustomBottomBarItems(
            label: 'Cabs',
            icon: FontAwesomeIcons.car,
          ),
          CustomBottomBarItems(label: 'Bookings', icon: Icons.local_mall),
          CustomBottomBarItems(
            label: 'Islamic',
            icon: Icons.mosque,
          ),
          CustomBottomBarItems(label: 'Services', icon: Icons.work),
        ],
      ),
    );
  }
}

Widget DrawerIcon(image) {
  return Container(
    padding: EdgeInsets.all(17),
    child: InkWell(
        onTap: () {},
        child: Image(
          image: AssetImage(image),
        )),
  );
}
