import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hexatour/src/models/islamic/zakaat_model.dart';

import '../../core/utils/Helpers.dart';
import '../../services/homepage_service.dart';
import '../models/islamic/charity_model.dart';
import '../models/islamic/qurbani_model.dart';

class IslamicController extends GetxController {
  final Dio _dio;
  IslamicController(this._dio);
  late HomeServices homeService = HomeServices(_dio);
  RxList<QurbaniRow> qurbani = <QurbaniRow>[].obs;
  RxList<CharityRow> charity = <CharityRow>[].obs;
  RxList<ZakaatRow> zakaat = <ZakaatRow>[].obs;

  RxString qurbaniAmount = ''.obs;
  final language = ''.obs;
  final reason = ''.obs;
  final errorMessage = ''.obs;
  final itemList = [].obs;

  Future<bool> qurbaniType(value) async {
    final response = await homeService.getQurbani(value);
    response.fold((failure) {
      return false;
    }, (success) {
      qurbani.clear();
      qurbani.addAll(success.data.rows);
      ;
      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> charityType(value) async {
    final response = await homeService.getCharity(value);
    response.fold((failure) {
      return false;
    }, (success) {
      charity.clear();
      charity.addAll(success.data.rows);
      ;
      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> zakatType(value) async {
    final response = await homeService.getZakaat(value);
    response.fold((failure) {
      errorMessage.value = Helpers.convertFailureToMessage(failure);
      errorMessage.value = errorMessage.substring('Exception: '.length);
      return false;
    }, (success) {
      // zakaat.clear();

      print(success);
      print('zakaatttttttttt');
      // List wajiwah = success["data"]["rows"];

      print('wajiwahtype');
      zakaat.clear();
      zakaat.addAll(success.data.rows);
      // zakaat.clear();
      zakaat.map((element) {
        itemList.add(element);


      });


     
      return true;
    });
    return response.isRight() ? true : false;
  }
}
