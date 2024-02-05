import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/core/utils/environment.dart';
import 'package:flutter/material.dart';

class ApiEndpoints {
// Base Url
  static String apiBaseUrl = Environment.apiBaseUrl;

  /// Auth APIs ///
  static const String signin = "/login";
  static const String signup = "/register";
  static const String forgotPassword = "/forgot-password";
  static const String resetPassword = "/set-new-password";
  static const String socialLogin = "/social-login";
  static const String token = "/add-user-fcm-token";

  /// Search APIs ///
  static const String getSearch = "/search";

  /// Product APIs ///
  static const String recentProducts = "/get-recent-and-top-selling-products";
  static const String categories = "/product-categories";
  static const String productCategories = "/products-by-category";
  static const String addFavorites = "/add-favourite-products";
  static const String deleteFavorites = "/delete-from-favourites";
  static const String getFavorites = "/get-favourite-products";
  static const String myProducts = "/my-product-bookings";
  static const String productSearch = "/search-products";
  static const String productDetail = "/product-details";

  /// Image Path Url ///

  static const String imageurl =
      'https://nodejs.hackerkernel.com/hexatour/public';

  /// Tour APIs ///
  static const String tours = "/recent-tours";
  static const String tourDetail = "/tour-details";
  static const String tourOrder = "/tour-order";
  static const String myTours = "/my-package-bookings";

  /// Offers APIs ///
  static const String offers = "/recent-offers";
  static const String offerType = "/offer-by-category";

  /// Service APIs ///
  static const String getService = "/all-service";
  static const String serviceDetail = "/service-details";
  static const String serviceOrder = "/service-order";
  static const String serviceCategory = "/all-service-categories";
  static const String searchService = "/search-service";
  static const String myServices = "/my-service-bookings";

  /// Cab APIs ///
  static const String cabBookings = "/user-cab-booking";
  static const String cabOrders = "/cab-order";
  static const String myCabs = "/my-cab-bookings";

  /// Payment APIs ///
  static const String Payment = "/verify-payment";

  ///Profile Api///
  static const String profile = "/user-profile";
  static const String updateprofile = "/update-user-profile";
  static const String changepassword = "/change-password";

  /// Cart APIs ///
  static const String addCart = "/add-to-cart";
  static const String deleteCart = "/delete-from-cart";
  static const String getCart = "/get-cart-items";
  static const String updateCart = "/update-cart";
  static const String cartPayment = "/products-cart-order";

  /// Qurbani API////
  static const String qurbani = "/get-qurbani-info";
  static const String qurbaniOrder = "/qurbani-order";

  /// Charity API////
  static const String charity = "/get-charity-info";
  static const String charityOrder = "/charity-order";

  /// Zakaat API////
  static const String zakat = "/get-zakaat-info";
  static const String zakatOrder = "/zakaat-order";
}

class GeoLocation {
  static const String getSuggestions =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json";
  static const String apiKey = "AIzaSyA3Ok71UDYBbMGaJWtONM_qhvWcpsgMItg";
  // static const double lat = 23.8859;
  // static const double lng = 45.0792;
  static const int radius = 100000;
  static const String countryCode = 'SA';
}

class Payment {
  static const String PaymentCurrency = "SAR";
}

class MyLoader extends StatelessWidget {
  const MyLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Container(
            color: Colors.white70,
            child: Center(
              child: CircularProgressIndicator(
                color: ColorConst.kGreenColor,
              ),
            )));
  }
}

class TourType {
  static const String islamic = "islamic";
  static const String adventure = "adventure";
}
