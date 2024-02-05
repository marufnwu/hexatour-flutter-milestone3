import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/people/v1.dart' as people;
import 'package:hexatour/core/utils/Helpers.dart';
import 'package:hexatour/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
// import 'package:googleapis/people/v1.dart' as people;

class AuthController extends GetxController {
  final Dio _dio;
  AuthController(this._dio);
  final errorMessage = ''.obs;
  RxString countrycode = ''.obs;
  late AuthServices authService = AuthServices(_dio);

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/user.phonenumbers.read',
    'https://www.googleapis.com/auth/userinfo.profile'
  ]);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final isGoogleSignInSuccess = false.obs;
  final isFacebookSignInSuccess = false.obs;

  Future<Tuple2<bool, String>> login(
      {required String email, required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response =
        await authService.loginService(email: email, password: password);

    response.fold((failure) {
      errorMessage.value = Helpers.convertFailureToMessage(failure);
      errorMessage.value = errorMessage.substring('Exception: '.length);
      debugPrint(errorMessage.value);
      return false;
    }, (success) {
      print(success.values);

      Helpers.setString(key: "user_data", value: jsonEncode(success["data"]));

      prefs.setString('apiToken', success['data']['reset_token']);
      prefs.setBool('isLoggedIn', true);

      return true;
    });
    return response.isRight()
        ? Tuple2(true, "Success")
        : Tuple2(false, errorMessage.value);
  }

  Future<Tuple2<bool, String>> register(
      {required String email,
      required String password,
      required String username,
      required String phone,
      required String nationality,
      required String gender}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

// Set
    prefs.getString('userId');

    final response = await authService.registerService(
        email: email,
        password: password,
        username: username,
        phone: phone,
        nationality: nationality,
        gender: gender);
    response.fold((failure) {
      errorMessage.value = Helpers.convertFailureToMessage(failure);
      errorMessage.value = errorMessage.substring('Exception: '.length);
      debugPrint(errorMessage.value);
      return false;
    }, (success) {
      print(success.values);
      prefs.setString('apiToken', success['data']['reset_token']);
      var token = prefs.getString('apiToken');
      print(token);

      return true;
    });
    return response.isRight()
        ? Tuple2(true, "Success")
        : Tuple2(false, errorMessage.value);
  }

  Future<bool> socialLogin(
      {String? email,
      String? displayName,
      required String social_login_type,
      String? social_login_id,
      String? gender,
      String? nationality,
      String? phone}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await authService.socialLogin(
        email: email,
        displayName: displayName,
        social_login_type: social_login_type,
        social_login_id: social_login_id,
        gender: gender,
        nationality: nationality,
        phone: phone);
    response.fold((failure) {
      return false;
    }, (success) {
      print(success);
      print('googleeee');
      prefs.setString('apiToken', success['data']['reset_token']);
      prefs.setBool('isLoggedIn', true);
      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> _handleGetContact() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final headers = await googleUser!.authHeaders;

    print("**************************");
    print(googleUser);

    try {
      final response = await http.get(
          Uri.parse(
              'https://people.googleapis.com/v1/people/me?personFields=phoneNumbers'),
          headers: {"Authorization": headers["Authorization"]!});

      if (response.statusCode == 200) {
        print('sometthing');
        print('People API ${response.statusCode} response: ${response.body}');
        // final response = jsonDecode(r.body);
        print(response);
        // return ;
      }
    } catch (e) {
      print("People Api google signIn");
      print(e);
    }

    return true;
  }

  Future<String> typeGender() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final headers = await googleUser!.authHeaders;
    final r = await http.get(
        Uri.parse(
            "https://people.googleapis.com/v1/people/me?personFields=genders&key="),
        headers: {"Authorization": headers["Authorization"]!});
    final response = jsonDecode(r.body);
    print(response);
    return response["genders"][0]["formattedValue"];
  }

  // }

  Future<bool> googleSignInMethod(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      // final people.PeopleServiceApi _peopleApi = people.PeopleServiceApi();
      // final googleSignin = GoogleSignIn();
     

      debugPrint("id : ${googleUser?.id}");
      debugPrint("name : ${googleUser?.displayName}");

      debugPrint("email : ${googleUser?.email}");
      debugPrint("image : ${googleUser?.photoUrl}");
      debugPrint("phone : ${googleUser}");
      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final users = userCredential.user;

      print('goggleeeeeeeeee');
      await typeGender();
      await _handleGetContact();
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((user) async {
        isGoogleSignInSuccess.value = await socialLogin(
            social_login_id: googleUser.id,
            social_login_type: "google",
            displayName: googleUser.displayName,
            email: googleUser.email,
            gender: await typeGender(),
            nationality: 'indian',
            phone: '6260271589');
        print(users!.phoneNumber);
        print('mobilenumberssss');
        print(users);
      });
      print(isGoogleSignInSuccess.value);
      print('cjnvcvcv');

      return isGoogleSignInSuccess.value;
    } catch (e) {
      return false;
    }
  }

  Future<bool> facebookSignin(BuildContext context) async {
    try {
      final fb = FacebookLogin(debug: true);
      await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      final profile = await fb.getUserProfile();
      final emailaddress = await fb.getUserEmail();

    

      debugPrint("id : ${profile?.userId}");
      debugPrint("name : ${profile?.firstName}");
      debugPrint("email : ${emailaddress.toString()}");

      isFacebookSignInSuccess.value = await socialLogin(
          social_login_id: profile?.userId,
          social_login_type: "facebook",
          displayName: 'sakshi',
          email: emailaddress,
          gender: authService.googleUserGender == 'male' ? "male" : "female",
          nationality: 'indian',
          phone: '6260271589');

      return isFacebookSignInSuccess.value; // return signinvalue;
    } catch (e) {
      return false;
    }
  }

  Future<Tuple2<bool, String>> forgotPassword({required String email}) async {
    final response = await authService.forgotService(email: email);

    response.fold((failure) {
      errorMessage.value = Helpers.convertFailureToMessage(failure);
      errorMessage.value = errorMessage.substring('Exception: '.length);
      debugPrint(errorMessage.value);
      return false;
    }, (success) {
      print(success.toString());
      return true;
    });
    return response.isRight()
        ? Tuple2(true, "Success")
        : Tuple2(false, errorMessage.value);
  }

  Future<Tuple2<bool, String>> resetPassword(
      {required String newpassword,
      required String confirmpassword,
      required String userID}) async {
    final response = await authService.resetpasswordService(
        newpassword: newpassword,
        confirmpassword: confirmpassword,
        userID: userID);

    response.fold((failure) {
      errorMessage.value = Helpers.convertFailureToMessage(failure);
      errorMessage.value = errorMessage.substring('Exception: '.length);
      debugPrint(errorMessage.value);
      return false;
    }, (success) {
      print(success.toString());
      Helpers.setString(key: "user_data", value: jsonEncode(success["data"]));
      return true;
    });
    return response.isRight()
        ? Tuple2(true, "Success")
        : Tuple2(false, errorMessage.value);
  }

  Future<Tuple2<bool, String>> Token({
    required String token,
  }) async {
    final response = await authService.fcmtoken(token: token);

    response.fold((failure) {
      errorMessage.value = Helpers.convertFailureToMessage(failure);
      errorMessage.value = errorMessage.substring('Exception: '.length);
      debugPrint(errorMessage.value);
      return false;
    }, (success) {
      print(success.toString());

      return true;
    });
    return response.isRight()
        ? Tuple2(true, "Success")
        : Tuple2(false, errorMessage.value);
  }
}
