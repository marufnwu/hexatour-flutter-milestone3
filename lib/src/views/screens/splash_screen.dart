import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/core/utils/Helpers.dart';
import 'package:hexatour/src/controllers/tour_controller.dart';
import 'package:hexatour/src/views/screens/auth/login_page.dart';

import 'package:hexatour/src/views/screens/language_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/cab_controller.dart';
import '../../controllers/home_page_controller.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/servie_controller.dart';
import 'home/home_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final homepageController = Get.find<HomePageController>();
  final tourController = Get.find<TourController>();
  final serviceController = Get.find<ServiceController>();
  final productController = Get.find<ProductController>();
  final cabController = Get.find<CabController>();
  final authController = Get.find<AuthController>();
 StreamSubscription? internetconnection;
   bool isoffline = false;

  @override
  void initState() {
     internetconnection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        // whenevery connection status is changed.
        if(result == ConnectivityResult.none){
             //there is no any connection
             setState(() {
                 isoffline = true;
             }); 
        }else if(result == ConnectivityResult.mobile){
             //connection is mobile data network
             setState(() {
                isoffline = false;
                 Timer(const Duration(seconds: 2), () {
      navigateUser();
    });
             });
        }else if(result == ConnectivityResult.wifi){
            //connection is from wifi
            setState(() {
               isoffline = false;
                Timer(const Duration(seconds: 2), () {
      navigateUser();
    });
            });
        }
    }); 
    // Timer(const Duration(seconds: 2), () {
    //   navigateUser();
    // });

    Helpers.getUserData();
    // authController.Token(token: '');
    tourController.tours();
    serviceController.getService();
    serviceController.serviceCategories();
    productController.products();
    productController.category();
    homepageController.getOffers();
    // homepageController.searchall(value: 'service');

    super.initState();
  }

  @override
  void dispose() {
     internetconnection!.cancel();
    super.dispose();
  }

  navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    String? token = await FirebaseMessaging.instance.getToken();
    // String? tokenn = prefs.getString("fcmToken");
    print(token);
    print('fcm');
    authController.Token(token: token!);
    if (status) {
      Get.offAll(Homepage());
    } else if (status) {
      Get.offAll(LoginPage());
    } else {
      Get.to(MyWidget());
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: isoffline == true ?
      Container(
          height: double.infinity,
          width: double.infinity,
          child: Center(child: Text('Connection Status:  No Internet ', style: TextStyle(color: ColorConst.kRedColor),))):

       Container(
          height: double.infinity,
          width: double.infinity,
          child: SvgPicture.asset(
            "assets/images/splash.svg",
            fit: BoxFit.cover,
          ),
        )
    );
  }
}
