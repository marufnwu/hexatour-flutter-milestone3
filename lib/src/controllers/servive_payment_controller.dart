import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/utils/Helpers.dart';
import '../../services/payment_service.dart';

class PaymentController extends GetxController {
  final Dio _dio;
  PaymentController(this._dio);

  late PaymentServices paymentService = PaymentServices(_dio);
  final errorMessage = ''.obs;
  final addPaymentResponse = {}.obs;

  Future<Tuple2<bool, String>> servicePaymentType({
    required String service_id,
    required String unit,
    required String service_avail_date,
    required String payment_type,
    required String contact_number,
    required String currency,
    required String total_amount,
    required String due_amount,
    required String payment_method,
    required String hotel_name,
    required String room_number,
  }) async {
    final response = await paymentService.servicePayment(
      service_id: service_id,
      unit: unit,
      service_avail_date: service_avail_date,
      payment_type: payment_type,
      contact_number: contact_number,
      currency: currency,
      payment_method: payment_method,
      total_amount: total_amount,
      due_amount: due_amount,
      hotel_name: hotel_name,
      room_number: room_number,
    );

    response.fold((failure) {
      errorMessage.value = Helpers.convertFailureToMessage(failure);
      errorMessage.value = errorMessage.substring('Exception: '.length);
      debugPrint(errorMessage.value);
      return false;
    }, (success) {
      debugPrint(success.toString());
      addPaymentResponse.value = success;

      debugPrint('serviceorderr');
      Helpers.setString(key: "service_order", value: jsonEncode(success));

      print('order_id');

      return true;
    });
    return response.isRight()
        ? Tuple2(true, "Success")
        : Tuple2(false, errorMessage.value);
  }

  Future<Tuple2<bool, String>> tourPaymentType(
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
    final response = await paymentService.tourPayment(
        tour_id: tour_id,
        source_id: source_id,
        destination_id: destination_id,
        travel_date: travel_date,
        contact_number: contact_number,
        payment_type: payment_type,
        due_amount: due_amount,
        total_amount: total_amount,
        currency: currency,
        payment_method: payment_method);

    response.fold((failure) {
      errorMessage.value = Helpers.convertFailureToMessage(failure);
      errorMessage.value = errorMessage.substring('Exception: '.length);
      debugPrint(errorMessage.value);
      return false;
    }, (success) {
      debugPrint(success.toString());
      debugPrint('serviceorderr');
      debugPrint(success.toString());
      Helpers.setString(key: "tour_order", value: jsonEncode(success));

      return true;
    });
    return response.isRight()
        ? Tuple2(true, "Success")
        : Tuple2(false, errorMessage.value);
  }

  Future<Tuple2<bool, String>> cabPaymentType(
      {required String cab_type,
      required String cab_package_id,
      String? date_of_travel,
      String? time_of_travel,
      required String contact_number,
      required String payment_type,
      required String cab_size,
      required String due_amount,
      required String total_amount,
      required String pickup_location,
      required String drop_location,
      required String payment_method}) async {
    final response = await paymentService.cabPayment(
        cab_type: cab_type,
        cab_package_id: cab_package_id,
        payment_type: payment_type,
        date_of_travel: date_of_travel,
        time_of_travel: time_of_travel!.split(" ")[0],
        cab_size: cab_size,
        total_amount: total_amount,
        due_amount: due_amount,
        contact_number: contact_number,
        pickup_location: pickup_location,
        drop_location: drop_location,
        payment_method: payment_method);

    response.fold((failure) {
      errorMessage.value = Helpers.convertFailureToMessage(failure);
      errorMessage.value = errorMessage.substring('Exception: '.length);
      debugPrint(errorMessage.value);
      return false;
    }, (success) {
      debugPrint(success.toString());
      debugPrint('serviceorderr');
      debugPrint(success.toString());

      return true;
    });
    return response.isRight()
        ? Tuple2(true, "Success")
        : Tuple2(false, errorMessage.value);
  }

  Future<Tuple2<bool, String>> verifyPayment(
      {String? feature_type,
      String? razorpay_payment_id,
      String? payment_type,
      String? razorpay_order_id,
      String? amount,
      String? payment_method}) async {
    final response = await paymentService.verifyPayment(
        feature_type: "qurbani",
        razorpay_payment_id: razorpay_payment_id,
        payment_type: payment_type,
        razorpay_order_id: razorpay_order_id,
        amount: amount,
        payment_method: payment_method);

    response.fold((failure) {
       errorMessage.value = Helpers.convertFailureToMessage(failure);
      errorMessage.value = errorMessage.substring('Exception: '.length);
      return false;
    }, (success) {
      debugPrint(success.toString());

      print(id);
      print('orderid');

      return true;
    });
    return response.isRight()
        ? Tuple2(true, "Success")
        : Tuple2(false, errorMessage.value);
  }

  Future<Tuple2<bool, String>> verifyqurbaniPayment(
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
    final response = await paymentService.qurbaniOrder(
        qurbani_id: qurbani_id,
        qurbani_type: qurbani_type,
        name: name,
        mobile_number: mobile_number,
        goat_type: goat_type,
        amount_paid: amount_paid,
        language: language,
        reason_for_sacrifice: reason_for_sacrifice,
        message: message,
        payment_method: payment_method);

    response.fold((failure) {
     errorMessage.value = Helpers.convertFailureToMessage(failure);
      errorMessage.value = errorMessage.substring('Exception: '.length);

      return false;
    }, (success) {
      debugPrint(success.toString());

      print(id);
      print('orderid');

      return true;
    });
    return response.isRight()
        ? Tuple2(true, "Success")
        : Tuple2(false, errorMessage.value);
  }

  Future<Tuple2<bool, String>> verifycharityPayment(
      {String? charity_id,
      String? name,
      String? contact_number,
      String? hotel_name,
      String? room_number,
      String? amount_paid,
      String? preferred_time,
      String? unit,
      String? payment_method}) async {
    final response = await paymentService.charityOrder(
        charity_id: charity_id,
        name: name,
        contact_number: contact_number,
        amount_paid: amount_paid,
        hotel_name: hotel_name,
        room_number: room_number,
        unit: unit,
        preferred_time: preferred_time,
        payment_method: payment_method);

    response.fold((failure) {
       errorMessage.value = Helpers.convertFailureToMessage(failure);
      errorMessage.value = errorMessage.substring('Exception: '.length);
      return false;
    }, (success) {
      debugPrint(success.toString());

      print(id);
      print('orderid');

      return true;
    });
    return response.isRight()
        ? Tuple2(true, "Success")
        : Tuple2(false, errorMessage.value);
  }


   Future<Tuple2<bool, String>> verifyzakaatPayment(
      {String?zakaat_category_id ,
     
      String ? purpose,
      String? amount_paid,
      String ? zakaat_type,
      String? payment_method
      }) async {
    final response = await paymentService.zakaatOrder(
       zakaat_category_id: zakaat_category_id,
    purpose: purpose,
    amount_paid: amount_paid,
    zakaat_type: zakaat_type,
    payment_method: payment_method
      
      
      );

    response.fold((failure) {
       errorMessage.value = Helpers.convertFailureToMessage(failure);
      errorMessage.value = errorMessage.substring('Exception: '.length);
      return false;
    }, (success) {
      debugPrint(success.toString());

      print(id);
      print('orderid');

      return true;
    });
    return response.isRight()
        ? Tuple2(true, "Success")
        : Tuple2(false, errorMessage.value);
  }


   Future<Tuple2<bool, String>> verifycartPayment(
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
      String? payment_method,
   
      String? payment_type
      }) async {
    final response = await paymentService.cartPayment(
       productDetails:productDetails,
    total_cart_amount: total_cart_amount,
    payment_type: payment_type,
    amount_paid: amount_paid,
    currency: currency,
    location_type: location_type,
    name: name,
    address1: address1,
    address2:address2,
    city: city,
    state: state,
    country: country,
    pincode:pincode,
    payment_method: payment_method
      
      
      );

    response.fold((failure) {
       errorMessage.value = Helpers.convertFailureToMessage(failure);
      errorMessage.value = errorMessage.substring('Exception: '.length);
      return false;
    }, (success) {
      debugPrint(success.toString());

      print(id);
      print('orderid');

      return true;
    });
    return response.isRight()
        ? Tuple2(true, "Success")
        : Tuple2(false, errorMessage.value);
  }
}
