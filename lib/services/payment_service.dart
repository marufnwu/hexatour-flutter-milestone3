import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/utils/Helpers.dart';
import '../core/utils/constant.dart';
import '../core/utils/exceptions.dart';
import '../core/utils/failure.dart';

class PaymentServices {
  final Dio dio;
  PaymentServices(this.dio);

  Future<Either<Failure, Map<String, dynamic>>> servicePayment(
      {required String service_id,
      required String unit,
      required String service_avail_date,
      required String payment_type,
      required String total_amount,
      required String due_amount,
      required String contact_number,
      required String currency,
      required String payment_method,
      required String hotel_name,
      required String room_number}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    debugPrint(resetoken);
    debugPrint('whynottiken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.serviceOrder,
          queryParams: {
            'service_id': service_id,
            'unit': unit,
            'service_avail_date': service_avail_date,
            'contact_number': contact_number,
            'payment_type': payment_type,
            'currency': currency,
            'payment_method': payment_method,
            'total_amount': total_amount,
            'due_amount': due_amount,
            'hotel_name': hotel_name,
            'room_number': room_number,
          },
          headers: {
            'authorization': 'Bearer $resetoken'
          });

      return Right(response!);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> tourPayment(
      {required String tour_id,
      required String source_id,
      required String destination_id,
      required String travel_date,
      required String contact_number,
      required String payment_type,
      required String due_amount,
      required String total_amount,
      required String currency,
      required String payment_method}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    debugPrint(resetoken);
    debugPrint('whynottiken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.tourOrder,
          queryParams: {
            'tour_id': tour_id,
            'source_id': source_id,
            'destination_id': destination_id,
            'travel_date': travel_date,
            'contact_number': contact_number,
            'payment_type': payment_type,
            'due_amount': due_amount,
            'total_amount': total_amount,
            'currency': currency,
            'payment_method': payment_method
          },
          headers: {
            'authorization': 'Bearer $resetoken'
          });

      return Right(response!);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> cabPayment(
      {required String cab_type,
      required String cab_package_id,
      String? date_of_travel,
      String? time_of_travel,
      required String contact_number,
      required String payment_type,
      required String cab_size,
      required String total_amount,
      required String due_amount,
      required String pickup_location,
      required String drop_location,
      required String payment_method}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    debugPrint(resetoken);
    debugPrint('whynottiken');

    var queryParams = {
      "cab_type": cab_type,
      "cab_package_id": cab_package_id,
      "payment_type": payment_type,
      "date_of_travel": date_of_travel,
      "time_of_travel": time_of_travel,
      "cab_size": cab_size,
      "total_amount": total_amount,
      "due_amount": due_amount,
      "contact_number": contact_number,
      "pickup_location": pickup_location,
      "drop_location": drop_location,
      "payment_method": payment_method
    };
    var removeParams = [];

    for (var k in queryParams.keys) {
      if (Helpers.isNull(queryParams[k])) {
        removeParams.add(k);
      }
    }
    queryParams.removeWhere((key, value) => removeParams.contains(key));

    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.cabOrders,
          queryParams: queryParams,
          headers: {'authorization': 'Bearer $resetoken'});

      return Right(response!);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> verifyPayment(
      {String? feature_type,
      String? razorpay_payment_id,
      String? payment_type,
      String? razorpay_order_id,
      String? amount,
      String? payment_method}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.Payment,
          queryParams: {
            'feature_type': "qurbani",
            'razorpay_payment_id': razorpay_payment_id,
            'payment_type': payment_type,
            'razorpay_order_id': razorpay_order_id,
            'amount': amount,
            'payment_method': payment_method
          },
          headers: {
            'authorization': 'Bearer $resetoken'
          });

      return Right(response!);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> qurbaniOrder(
      {String? qurbani_id,
      String? qurbani_type,
      List? name,
      String? mobile_number,
      String? goat_type,
      String? amount_paid,
      String? language,
      String? reason_for_sacrifice,
      String? message,
      String? payment_method}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.qurbaniOrder,
          queryParams: {
            "qurbani_id": qurbani_id,
            "qurbani_type": qurbani_type,
            "name": name,
            "mobile_number": mobile_number,
            "goat_type": goat_type,
            "amount_paid": amount_paid,
            "language": language,
            "reason_for_sacrifice": reason_for_sacrifice,
            "message": message,
            "payment_method": payment_method
          },
          headers: {
            'authorization': 'Bearer $resetoken'
          });

      return Right(response!);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> charityOrder(
      {String? charity_id,
      String? name,
      String? contact_number,
      String? hotel_name,
      String? room_number,
      String? amount_paid,
      String? preferred_time,
      String? unit,
      String? payment_method}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.charityOrder,
          queryParams: {
            "charity_id": charity_id,
            "amount_paid": amount_paid,
            "name": name,
            "hotel_name": hotel_name,
            "room_number": room_number,
            "contact_number": contact_number,
            "preferred_time": preferred_time,
            "unit": unit,
            "payment_method": payment_method
          },
          headers: {
            'authorization': 'Bearer $resetoken'
          });

      return Right(response!);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> zakaatOrder(
      {String? zakaat_category_id,
      String? purpose,
      String? amount_paid,
      String? zakaat_type,
      String? payment_method}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.zakatOrder,
          queryParams: {
            "zakaat_category_id": zakaat_category_id,
            "purpose": purpose,
            "amount_paid": amount_paid,
            "zakaat_type": zakaat_type,
            "payment_method": payment_method
          },
          headers: {
            'authorization': 'Bearer $resetoken'
          });

      return Right(response!);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> cartPayment(
      {
      String? total_cart_amount,
      List?productDetails,
      String? address1,
      String? address2,
      String? location_type,
      String? amount_paid,
      String? name,
      String? currency,
      String?city,
      String?state,
      String? country,
      String? pincode,
      String?payment_method,
   
      String? payment_type}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.cartPayment,
          queryParams: {
           "payment_method" : payment_method,
            "productDetails":productDetails,
    "total_cart_amount": total_cart_amount,
    "payment_type": payment_type,
    "amount_paid": amount_paid,
    "currency": currency,
    "location_type": location_type,
    "name": name,
    "address1": address1,
    "address2":address2,
    "city": city,
    "state": state,
    "country": country,
    "pincode":pincode
          },
          headers: {
            'authorization': 'Bearer $resetoken'
          });

      return Right(response!);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
