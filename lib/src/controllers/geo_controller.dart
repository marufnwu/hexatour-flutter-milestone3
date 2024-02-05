import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hexatour/services/geo_services.dart';
import 'package:hexatour/src/models/location/suggestion.dart';

class GeoController extends GetxController {
  RxList<Suggestion> geoPickUpSuggestions = <Suggestion>[].obs;
  RxList<Suggestion> geoDropSuggestions = <Suggestion>[].obs;
  late GeoService geoService = GeoService();
  RxString errormessage = ''.obs;

  Future<Tuple2<bool, dynamic>> getPickUpSuggestions(
      {required String input, String? types}) async {
    final response = await geoService.fetchSuggestions(input, types: types);

    response.fold((failure) {
      return false;
    }, (success) {
      geoPickUpSuggestions.value = success;
      return true;
    });

    return response.isRight()
        ? Tuple2(true, "Success")
        : Tuple2(false, errormessage.value);
  }

  Future<Tuple2<bool, dynamic>> getDropSuggestions({
    required String input,
  }) async {
    final response = await geoService.fetchSuggestions(input);

    response.fold((failure) {
      return false;
    }, (success) {
      geoDropSuggestions.value = success;
      return true;
    });

    return response.isRight()
        ? Tuple2(true, "Success")
        : Tuple2(false, errormessage.value);
  }

  resetPickUpSuggestions() {
    geoPickUpSuggestions.value = [];
  }

  resetDropSuggestions() {
    geoDropSuggestions.value = [];
  }

}
