import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hexatour/src/models/cab/cab_model.dart';

import '../../services/homepage_service.dart';

class CabController extends GetxController {
  final Dio _dio;
  CabController(this._dio);
  RxList<CabModel> cabPackage = <CabModel>[].obs;
  final List cablist = [];
  final List itemlist = [];
  RxList<CabModel> cabnameList = <CabModel>[].obs;
  RxList<MyCabs> myCabs = <MyCabs>[].obs;

  Rx<CabModel> cabDetails = CabModel().obs;
  late HomeServices homeService = HomeServices(_dio);
  RxString errormessage = ''.obs;
  RxString payment = ''.obs;
  RxString paymentType = ''.obs;
  RxString package = ''.obs;
  RxString pickup = ''.obs;
  RxString drop = ''.obs;
  RxString date = ''.obs;
  RxString time = ''.obs;

  Future<Tuple2<bool, String>> cabdetail({
    required String value,
    required String size,
  }) async {
    final response = await homeService.cabBook(value: value, size: size);

    response.fold((failure) {
      return false;
    }, (success) {
      itemlist.clear();
      cablist.addAll(success['data']);
      // cabPackage.value = success;

      itemlist.addAll(cablist);

      print(itemlist);

      print('gvchgnchg');
      return true;
    });
    return response.isRight()
        ? Tuple2(true, "Success")
        : Tuple2(false, errormessage.value);
  }

  Future<bool> cabBookings({required String value}) async {
    final response = await homeService.getCabsBookings(value: value);

    response.fold((failure) {
      return false;
    }, (success) {
      // productsCat.clear();
      myCabs.clear();
      debugPrint(success.toString());
      print(success.data);
      print('notttnowww');
      myCabs.addAll(success.data);
      return true;
    });
    return response.isRight() ? true : false;
  }
}
