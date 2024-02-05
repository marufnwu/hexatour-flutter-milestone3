import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/utils/constant.dart';
import 'package:hexatour/services/dynamic_links.dart';
import 'package:hexatour/src/controllers/auth_controller.dart';
import 'package:hexatour/src/controllers/geo_controller.dart';
import 'package:hexatour/src/controllers/home_page_controller.dart';
import 'package:hexatour/src/controllers/product_controller.dart';
import 'package:hexatour/src/controllers/servie_controller.dart';

import '../../src/controllers/cab_controller.dart';
import '../../src/controllers/islamic_controller.dart';
import '../../src/controllers/servive_payment_controller.dart';
import '../../src/controllers/tour_controller.dart';

class DependencyInjuctor {
  static void inject() {
    _injectDio();
    initializeController();
  }

  static void _injectDio() {
    final dio = Dio(BaseOptions(baseUrl: ApiEndpoints.apiBaseUrl));
    debugPrint("dio depend url");
    debugPrint(dio.options.baseUrl);
    Get.lazyPut<Dio>(() => dio);
  }

  static void initializeController() {
    final dio = Get.find<Dio>();
    Get.put(AuthController(dio));
    Get.put(CabController(dio));
    Get.put(PaymentController(dio));
    Get.put(DynamicLinkService());
    Get.put(TourController(dio));
    Get.put(ProductController(dio));
    Get.put(ServiceController(dio));
    Get.put(HomePageController(dio));
    Get.put(GeoController());
    Get.put(IslamicController(dio));
  }
}
