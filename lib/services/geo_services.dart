import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geocoder/geocoder.dart';


import 'package:hexatour/core/utils/Helpers.dart';
import 'package:hexatour/core/utils/constant.dart';
import 'package:hexatour/core/utils/exceptions.dart';
import 'package:hexatour/core/utils/failure.dart';
import 'package:hexatour/src/models/location/suggestion.dart';

class GeoService {
  var dio = Dio();
  Future<Either<Failure, List<Suggestion>>> fetchSuggestions(String input,
      {String lang = 'en', types}) async {
    if (Helpers.isNull(types)) {
      types = 'address';
    }
    final request = GeoLocation.getSuggestions +
        // '?input=$input&types=${types}&language=$lang&key=${GeoLocation.apiKey}&components=country:${GeoLocation.countryCode}';
        '?input=$input&key=${GeoLocation.apiKey}&components=country:${GeoLocation.countryCode}';
    try {

      final response = await Helpers.sendRequest(dio, RequestType.get, request,
          queryParams: {});
      print("Success geo");
      print(response);
      print(response!['predictions']);
     print('howww rrrr uuuuuu');
      

      return Right(response['predictions']
          .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
          .toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
