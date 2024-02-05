import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/utils/Helpers.dart';
import '../models/service/service_category_model.dart';
import '../models/service/service_model.dart';
import '../../services/homepage_service.dart';
import '../models/service/service_detail_model.dart';

class ServiceController extends GetxController {
  final Dio _dio;
  ServiceController(this._dio);

  RxList<ServicePackage> service = <ServicePackage>[].obs;
  RxList<SearchService> services = <SearchService>[].obs;
  List serviceCategory = [].obs;
  List servicess = [].obs;
  RxList<MyServices> myServices = <MyServices>[].obs;
  RxString errorMessage = ''.obs;
  Rx<ServiceData> servicedata = ServiceData().obs;
  late HomeServices homeService = HomeServices(_dio);

  Future<bool> getService() async {
    final response = await homeService.Services();
    response.fold((failure) {
      return false;
    }, (success) {
      service.clear();
      debugPrint(success.toString());
      service.addAll(success.data.servicePackages);

      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<dynamic> serviceDetail({required int id}) async {
    final response = await homeService.serviceDetail(id: id);
    response.fold((failure) {
      errorMessage.value = Helpers.convertFailureToMessage(failure);
      errorMessage.value = errorMessage.substring('Exception: '.length);
      debugPrint(errorMessage.value);
      return false;
    }, (success) {
      debugPrint(success.toString());
      servicedata.value = success.data;

      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> serviceCategories() async {
    final response = await homeService.serviceCategory();
    response.fold((failure) {
      return false;
    }, (success) {
      debugPrint(success.toString());
      serviceCategory = success["data"];
      print(serviceCategory);

      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<dynamic> serviceSearchs({required String value}) async {
    final response = await homeService.serviceSearch(
      value: value,
    );
    response.fold((failure) {
      errorMessage.value = Helpers.convertFailureToMessage(failure);
      errorMessage.value = errorMessage.substring('Exception: '.length);
      debugPrint(errorMessage.value);
      return false;
    }, (success) {
      services.clear();
      debugPrint(success.toString());
      services.addAll(success.data);

      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> serviceBookings({required String value}) async {

    final response = await homeService.getServiceBookings(value: value);

    response.fold((failure) {
      return false;
    }, (success) {
      // productsCat.clear();
      myServices.clear();
      debugPrint(success.toString());
      print(success.data);
      print('notttnowww');
      myServices.addAll(success.data);
      return true;
    });
    return response.isRight() ? true : false;
  }
}
