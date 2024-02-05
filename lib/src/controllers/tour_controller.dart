import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/utils/constant.dart';
import 'package:hexatour/src/models/tour/Tour_model.dart';

import '../../services/homepage_service.dart';
import '../models/tour/tour_detail_model.dart';

class TourController extends GetxController {
  final Dio _dio;
  TourController(this._dio);
  RxList<TourItenary> tourIternaries = <TourItenary>[].obs;
  RxList<ToursPackage> tourPackage = <ToursPackage>[].obs;
  RxList<MyTours> myTours = <MyTours>[].obs;
  RxList<ToursPackage> islamicTourPackage = <ToursPackage>[].obs;
  RxList<ToursPackage> adventureTourPackage = <ToursPackage>[].obs;
  RxBool islamicTourLoader = false.obs;
  RxBool adventureTourLoader = false.obs;
  Rx<DataClass> tourDetails = DataClass().obs;
  late HomeServices homeService = HomeServices(_dio);
  RxList<String> allLocations = <String>[].obs;
  RxString payment = ''.obs;
  RxString date = ''.obs;
  RxString time = ''.obs;
  RxString paymentType = ''.obs;

  Future<bool> tours() async {
    final response = await homeService.recentTour();
    response.fold((failure) {
      return false;
    }, (success) {
      tourPackage.clear();
      tourPackage.addAll(success.data.toursPackages);
      ;
      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> filterTours({type, page = 1}) async {
    if (type == TourType.islamic) {
      islamicTourLoader.value = true;
    } else {
      adventureTourLoader.value = true;
    }

    final response = await homeService.recentTour(type: type, page: page);
    if (type == TourType.islamic) {
      islamicTourLoader.value = false;
    } else {
      adventureTourLoader.value = false;
    }

    response.fold((failure) {
      return false;
    }, (success) {
      if (type == TourType.islamic) {
        islamicTourPackage.clear();
        islamicTourPackage.addAll(success.data.toursPackages);
      } else {
        adventureTourPackage.clear();
        adventureTourPackage.addAll(success.data.toursPackages);
      }
      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> tourdetail({required int id}) async {
    final response = await homeService.tourDetail(id: id);
    response.fold((failure) {
      return false;
    }, (success) {
      allLocations.clear();

      tourIternaries.clear();
      tourDetails.value = success.data;

      tourIternaries.addAll(success.data.tourItenaries!);
      allLocations.addAll(
          tourIternaries.map((element) => element.location.locationName));
      allLocations.insert(0, tourDetails.value.source!.locationName.toString());
      allLocations.insert(allLocations.lastIndexOf(allLocations.last) + 1,
          tourDetails.value.destination!.locationName.toString());
      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> tourBookings({required String value}) async {
    final response = await homeService.getTourBookings(value: value);

    response.fold((failure) {
      return false;
    }, (success) {
      // productsCat.clear();
      myTours.clear();
      debugPrint(success.toString());
      print(success.data);
      print('notttnowww');
      myTours.addAll(success.data);
      return true;
    });
    return response.isRight() ? true : false;
  }

  RxList addetail = [].obs;
}
