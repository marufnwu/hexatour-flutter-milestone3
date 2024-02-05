import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hexatour/src/models/home/dropdown_model.dart';
import 'package:hexatour/src/models/home/search_model.dart';
import '../../core/utils/Helpers.dart';
import '../../services/homepage_service.dart';
import '../models/home/offer_model.dart';
import '../models/profile/profile.dart';

class HomePageController extends GetxController {
  final Dio _dio;
  HomePageController(this._dio);
  RxList<SearchModel> searchModel = <SearchModel>[].obs;
  RxList<Datum> offers = <Datum>[].obs;
  Rx<Profiles> profile = Profiles().obs;
  RxList<Datum> offersType = <Datum>[].obs;
  final itemList = <Dropdown>[].obs;
  final selectedTypeid = 0.obs;
  final selectedCategoryid = 0.obs;
  final errorMessage = ''.obs;

  late HomeServices homeService = HomeServices(_dio);

  Future<dynamic> searchall({required String value}) async {
    final response = await homeService.globalSearch(value: value);
    response.fold((failure) {
      return false;
    }, (success) {
      itemList.clear();
      print(success);
      List tour = success["data"]["tour"];
      List product = success["data"]["product"];
      List service = success["data"]["service"];
      List cab = success["data"]["cab"];

      for (var item in tour) {
        print(tour);
        print("toursssss");
        itemList.add(Dropdown.fromJson(item, 'tourname'));
        print("here");
        print(itemList.first.destination?.locationName);
      }

      for (var item in service) {
        itemList.add(Dropdown.fromJson(item, 'service_name'));
      }
      for (var item in product) {
        itemList.add(Dropdown.fromJson(item, 'product_name'));
      }
      for (var item in cab) {
        itemList.add(Dropdown.fromJson(item, 'cab_name'));
      }

      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> getOffers() async {
    final response = await homeService.recentOffers();
    response.fold((failure) {
      return false;
    }, (success) {
      offers.clear();
      offers.addAll(success.data);
      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> getProfileDetails() async {
    final response = await homeService.getProfileDetails();
    response.fold((failure) {
      return false;
    }, (success) {
      profile.value = Profiles();
      print(success.data.toString());
      profile.value = success.data;

      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> updateProfileDetails(var params) async {
    final response = await homeService.UpdateProfileDetails(params);
    response.fold((failure) {
      return false;
    }, (success) {

      print(success.data.toString());
      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> changePassword(var params) async {
    final response = await homeService.ChangePassword(params);
    response.fold((failure) {
      return false;
    }, (success) {

      print(success.data.toString());
      return true;
    });
    return response.isRight() ? true : false;
  }


  Future<Tuple2<bool, String>> getOffertype({
    required String value,
  }) async {
    final response = await homeService.offersTyp(
      value: value,
    );
    response.fold((failure) {
      errorMessage.value = Helpers.convertFailureToMessage(failure);
      errorMessage.value = errorMessage.substring('Exception: '.length);
      debugPrint(errorMessage.value);
      return false;
    }, (success) {
      offersType.clear();
      offersType.addAll(success.data);
      return true;
    });
    return response.isRight()
        ? Tuple2(true, "Success")
        : Tuple2(false, errorMessage.value);
  }



}
