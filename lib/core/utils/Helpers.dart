import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart' as gt;
import 'package:hexatour/src/views/screens/auth/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'failure.dart';

enum RequestType { get, post, delete }

Map<String, dynamic>? userData;

class Helpers {
  static validateEmail(String value) {
    if (value.isEmpty) {
      return "Field Required";
    }
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@'
        r'((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]'
        r'+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(value)) {
      return null;
    }
    return 'invalid email';
  }

  static validateField(String value) {
    if (value.isEmpty || value == 'null') {
      return "Field Required";
    }
    return null;
  }

  static validatePhone(String value) {
    if (value.length < 10 || value.length > 10) {
      return 'Please Enter Valid Mobile Number';
    } else {
      return null;
    }
  }

  static validatePassword(String value) {
    if (value.length < 6) {
      return 'Password should be minimum 6 characters long';
    } else {
      return null;
    }
  }

  static validateDate(DateTime? value) {
    if (value == null) {
      return "Please select date";
    }
    return null;
  }

  static validateTime(DateTime? value) {
    if (value == null) {
      return "Please select time";
    }
    return null;
  }

  static showSnackbar(
      {required String text,
      required Color color,
      required BuildContext context}) {
    final options = SnackBar(
      content: Text(text),
      backgroundColor: color,
      duration: Duration(seconds: 4),
      elevation: 1,
    );
    return ScaffoldMessenger.of(context).showSnackBar(options);
  }

  static Future<Map<String, dynamic>?> sendRequest(
    Dio dio,
    RequestType type,
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    bool encoded = false,
    dynamic data,
  }) async {
    debugPrint("url ${dio.options.baseUrl}  ${path}");
    debugPrint("PayLoad ${queryParams ?? data}");
    try {
      Response response;

      switch (type) {
        case RequestType.get:
          response = await dio.get(path,
              queryParameters: queryParams, options: Options(headers: headers));
          break;
        case RequestType.post:
          response = (await dio.post(
            path,
            options: Options(
                headers: headers,
                contentType:
                    encoded == true ? Headers.formUrlEncodedContentType : null,
                validateStatus: (code) => true),
            data: queryParams ?? FormData.fromMap(data),
          ));
          break;
        case RequestType.delete:
          response = (await dio.delete(path,
              queryParameters: queryParams,
              options: Options(headers: headers)));
          break;
        default:
          return null;
      }

      if (response.statusCode == 200) {
        debugPrint(response.statusCode.toString());
        print(response.data.toString());
        debugPrint(response.data["message"]);
        return response.data as Map<String, dynamic>;
      } else if (response.statusCode == 202) {
        debugPrint(response.statusCode.toString());
        debugPrint('helooooooooo');
        print(response.data.toString());
        debugPrint(response.data["message"]);
        throw Exception(response.data["message"]);
        // return response.data as Map<String, dynamic>;
      } else if (response.statusCode == 400) {
        debugPrint(response.statusCode.toString());
        debugPrint("Inside Else If");
        print(response);
        // debugPrint("Exititng Else If");
        // return response.data as Map<String, dynamic>;
        throw Exception(response.data["message"]);
      } else {
        debugPrint("Severe Error");
        debugPrint(response.statusCode.toString());
      }
    } on DioError catch (e) {
      debugPrint("Dio Error");
      debugPrint(e.toString());
    } on SocketException catch (e) {
      debugPrint("Exception Occured");
      debugPrint(jsonEncode(e));
    }
    return null;
  }

  static String convertFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    }

    return "Unknown error occurred";
  }

  static setString({required String key, required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static deleteString({required key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static getString({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

//    getToken() async {

//   SharedPreferences prefs = await SharedPreferences.getInstance();

//    prefs.getString("fcmToken");
//   debugPrint('FCM Notification Token ${prefs.getString('fcmToken')}');
// }

  static getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var encodedVal = prefs.getString("user_data");
    if (encodedVal != null) {
      userData = json.decode(encodedVal);
    }
  }

  static Future getApiToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('apiToken');
  }

  static Future<bool?> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("user_data");
    gt.Get.offAll(LoginPage());
  }

  static isNull(val) {
    if (val == null || val == 'null' || val == '') {
      return true;
    }

    return false;
  }

  static calculateDiscountAmount(discount, amount) {
    return toInt(amount) * (toInt(discount) / 100);
  }

  static toInt(val) {
    if (val.runtimeType == String) {
      return int.parse(val);
    }

    return val;
  }

  static toDouble(val) {
    if (val.runtimeType == String) {
      return double.parse(val);
    }

    return val;
  }

  static launchCaller(mobile) async {
    var url = Uri.parse("tel:$mobile");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
