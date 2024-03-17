import 'package:get/get.dart';
import 'package:hexatour/services/routing/routes.dart';
import 'package:hexatour/src/views/screens/auth/login_page.dart';
import 'package:hexatour/src/views/screens/auth/register_page.dart';

import 'package:hexatour/src/views/screens/home/home_page1.dart';
import 'package:hexatour/src/views/screens/service/all_service.dart';
import 'package:hexatour/src/views/screens/splash_screen.dart';
import 'package:hexatour/src/views/screens/tours/package_payment.dart';

import '../../src/views/screens/home/home_page.dart';

class CustomRouter {
  static List<GetPage> routes = [
    // GetPage(name: splashscreen, page: () => PackagePayment(price: "100", minimumBookingAmount: "100", tourName: "asas", dateOfTravel: '2023-01-03', mobile: "01778473031", timeOfTravel: "10122")),

    GetPage(name: homepage, page: () => HomePage1()),
    GetPage(name: signinpage, page: () => LoginPage()),
    GetPage(name: register, page: () => RegisterPage()),
    GetPage(name: navigate, page: () => Homepage()),
    GetPage(name: splashscreen, page: () => AllServices()),
  ];
}
