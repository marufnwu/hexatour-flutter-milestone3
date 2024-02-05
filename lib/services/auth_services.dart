import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexatour/core/utils/Helpers.dart';
import 'package:hexatour/core/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:hexatour/core/utils/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final Dio dio;
  AuthServices(this.dio);
  final googleSignin = GoogleSignIn();
  String? googleUserGender;

  Future<Either<Failure, String>> fcmtoken({required String token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.token,
          headers: {'authorization': 'Bearer $resetoken'},
          queryParams: {'fcm_token': token});

      return Right(response.toString());
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> loginService(
      {required String email, required String password}) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.signin,
          queryParams: {'email': email, 'password': password});

      return Right(response!);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  getGender() async {
    final headers = await googleSignin.currentUser!.authHeaders;

    final r = await http.get(
        Uri.parse(
            "https://people.googleapis.com/v1/people/me?personFields=birthdays,genders,phoneNumbers&key="),
        headers: {"Authorization": headers["Authorization"]!});
    final response = json.decode(r.body);
    print(response);
    print('genderrr');

    String gender = response['genders'][0]['value'];

    googleUserGender = gender;

    return googleUserGender;
  }

  Future<Either<Failure, Map<String, dynamic>>> socialLogin(
      {String? email,
      String? displayName,
      required String social_login_type,
      String? social_login_id,
      String? gender,
      String? nationality,
      String? phone}) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.socialLogin,
          queryParams: {
            'email': email,
            'displayName': displayName,
            'social_login_type': social_login_type,
            'social_login_id': social_login_id,
            'gender': gender,
            'nationality': nationality,
            'phone': phone
          });

      print({
        'email': email,
        'displayName': displayName,
        'social_login_type': social_login_type,
        'social_login_id': social_login_id,
        'gender': gender,
        'nationality': nationality,
        'phone': phone
      });
      return Right(response!);
    } on Exception catch (e) {
      print("Social Login errror");
      print(e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> registerService(
      {required String username,
      required String password,
      required String email,
      required String nationality,
      required String gender,
      required String phone}) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.signup,
          queryParams: {
            'email': email,
            'password': password,
            'username': username,
            'phone': phone,
            'nationality': nationality,
            'gender': gender
          });
      return Right(response!);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> forgotService(
      {required String email}) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.forgotPassword,
          queryParams: {'email': email});
      return Right(response!);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> resetpasswordService(
      {required String newpassword,
      required String confirmpassword,
      required String userID}) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.resetPassword,
          queryParams: {
            'user_id': userID,
            'newpassword': newpassword,
            'confirmpassword': confirmpassword
          });

      return Right(response!);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
