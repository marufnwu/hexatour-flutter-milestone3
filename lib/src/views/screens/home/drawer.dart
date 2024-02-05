import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/controllers/islamic_controller.dart';
import 'package:hexatour/src/views/screens/cabs/my_cabs/my_cabs_tab_page.dart';
import 'package:hexatour/src/views/screens/drawer_items/privacy_policy.dart';
import 'package:hexatour/src/views/screens/drawer_items/profile/my_profile.dart';
import 'package:hexatour/src/views/screens/drawer_items/terms_condition.dart';
import 'package:hexatour/src/views/screens/drawer_items/wishlist/wish_list.dart';
import 'package:hexatour/src/views/screens/my_bookings/my_bookings_tab_page.dart';
import 'package:hexatour/src/views/screens/products/my_products/my_product_tabpage.dart';
import 'package:hexatour/src/views/screens/service/all_service.dart';
import 'package:hexatour/src/views/screens/service/my_services/my_services_tab_page.dart';
import 'package:hexatour/src/views/screens/tours/all_tours.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/cab_controller.dart';
import '../../../controllers/home_page_controller.dart';
import '../../../controllers/product_controller.dart';
import '../auth/login_page.dart';
import '../cabs/cab_homepage.dart';
import '../drawer_items/cart/my_cart.dart';
import '../products/all_products.dart';
import 'islamic/islamic_homepage.dart';

class DrawerItems extends StatefulWidget {
  @override
  State<DrawerItems> createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
  List<String> images = [
    "https://t4.ftcdn.net/jpg/02/40/98/49/360_F_240984942_eZXNlIqQ0SRIMyIZMOqVYG3kAmKqpCPJ.jpg",
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
    "https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?cs=srgb&dl=pexels-pixabay-268533.jpg&fm=jpg"
  ];
  HomePageController homeController = Get.find<HomePageController>();

  IslamicController qurbaniController = Get.find<IslamicController>();
  CabController cabController = Get.find<CabController>();
  ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerImage('assets/images/sidemenu_bg.png', context),
          Positioned(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  InkWell(
                    onTap: () {
                      Get.to(MyProfile());
                    },
                    splashColor: Colors.transparent,
                    child: DrawerItemss(
                      'My profile',
                      'assets/images/contact.png',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(AllTour());
                    },
                    child: DrawerItemss(
                      'Book a package',
                      'assets/images/package.png',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(AllServices());
                    },
                    child: DrawerItemss(
                      'Book a service',
                      'assets/images/service.png',
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Get.to(CabHomePage());
                    },
                    child: DrawerItemss(
                      'Book a cab',
                      'assets/images/cab.png',
                    ),
                  ),
                  ExpansionTile(
                    iconColor: ColorConst.whiteColor,
                    collapsedIconColor: ColorConst.whiteColor,
                    tilePadding: EdgeInsets.only(right: 5.w),
                    childrenPadding: EdgeInsets.only(left: 20.w),
                    title: DrawerItemss(
                      'My Booking',
                      'assets/images/booking.png',
                    ),
                    children: [
                      expansionChildren(
                          title: "Tours",
                          onTap: () {
                            Get.to(MyBookingsTabPage());
                          }),
                      expansionChildren(
                          title: "Cabs",
                          onTap: () {
                            Get.to(MyCabTabPage());
                          }),
                      expansionChildren(
                          title: "Services",
                          onTap: () {
                            Get.to(MyServiceTabPage());
                          }),
                      expansionChildren(
                          title: "Products",
                          onTap: () {
                            Get.to(MyProductTabPage());
                          }),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(IslamicHomePage());
                    },
                    child: DrawerItemss(
                      'islamic',
                      'assets/images/islamic.png',
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      // await productController.getCart();
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
                      Get.to((CartPage()));
                    },
                    child: DrawerItemss(
                      'My Cart',
                      'assets/images/shopping-cart 1.png',
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await productController.allWishlist();
                      Get.to(WishListPage());
                    },
                    child: DrawerItemss(
                      'Wishlist',
                      'assets/images/fav.png',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(AllProducts());
                    },
                    child: DrawerItemss(
                      'Shop',
                      'assets/images/shop.png',
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Color.fromARGB(255, 231, 223, 223),
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(TermsCondition());
                      },
                      child: DrawerItem1('Terms and Condition')),
                  InkWell(
                      onTap: () {
                        Get.to(PrivacyPolicy());
                      },
                      child: DrawerItem1('Privacy policy')),
                  DrawerItem1('Contact us'),
                  InkWell(
                      onTap: () {
                        _logout();
                        print('logoutttuser');
                      },
                      child: DrawerItem1('Logout')),   
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Color.fromARGB(255, 210, 202, 202),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      DrawerIcon(FontAwesomeIcons.instagram),
                      DrawerIcon(FontAwesomeIcons.facebook),
                      DrawerIcon(FontAwesomeIcons.twitter),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();

  Get.offAll(LoginPage());
}

Widget expansionChildren({required String title, required Function() onTap}) {
  return ListTile(
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
            color: ColorConst.whiteColor),
      ),
      visualDensity: VisualDensity.compact,
      onTap: onTap,
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: ColorConst.whiteColor,
        size: 15,
      ),
      contentPadding: EdgeInsets.only(right: 10.w));
}

Widget DrawerItemss(String title, image) {
  return Container(
    padding: EdgeInsets.fromLTRB(10, 3, 1, 1),
    child: ListTile(
      leading: Image(
        image: AssetImage(image),
        color: ColorConst.whiteColor,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
            color: ColorConst.whiteColor),
      ),
    ),
  );
}

Widget DrawerItem1(title) {
  return Container(
      padding: EdgeInsets.fromLTRB(10, 3, 1, 1),
      child: ListTile(
        title: Text(title,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6,
                color: ColorConst.whiteColor)),
      ));
}

Widget DrawerIcon(icon) {
  return Container(
    padding: EdgeInsets.all(19),
    child: InkWell(
      onTap: () {},
      child: Icon(
        icon,
        color: ColorConst.whiteColor,
        size: 20,
      ),
    ),
  );
}

Widget DrawerImage(image, context) {
  return Image(
    image: AssetImage(image),
    height: 140.h,
    fit: BoxFit.cover,
  );
}
