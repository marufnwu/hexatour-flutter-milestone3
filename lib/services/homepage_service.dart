import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hexatour/core/utils/Helpers.dart';
import 'package:hexatour/core/utils/constant.dart';
import 'package:hexatour/core/utils/failure.dart';
import 'package:hexatour/src/models/islamic/charity_model.dart';
import 'package:hexatour/src/models/product/category.dart';

import 'package:hexatour/src/models/tour/Tour_model.dart';
import 'package:hexatour/src/models/product/product_model.dart';
import 'package:hexatour/src/models/tour/tour_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../src/models/cab/cab_model.dart';
import '../src/models/cart/cart.dart';
import '../src/models/home/offer_model.dart';
import '../src/models/islamic/qurbani_model.dart';
import '../src/models/islamic/zakaat_model.dart';
import '../src/models/product/product_category_model.dart';
import '../src/models/product/product_detail.dart';
import '../src/models/product/product_search_model.dart';
import '../src/models/product/wishlist_model.dart';
import '../src/models/profile/profile.dart';
import '../src/models/service/service_category_model.dart';

import '../src/models/service/service_detail_model.dart';
import '../src/models/service/service_model.dart';

class HomeServices {
  final Dio dio;
  HomeServices(this.dio);

  Future<Either<Failure, Map<String, dynamic>>> globalSearch(
      {required String value}) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.getSearch,
          queryParams: {'search_query': value});
      return Right(response!);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, SearchProduct>> productSearch(
      {required String value}) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.productSearch,
          queryParams: {'search_query': value});
      return Right(SearchProduct.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Tour>> recentTour({type, page = 1}) async {
    Map<String, dynamic> queryParams = {};
    if (!Helpers.isNull(type)) {
      queryParams['tourtype'] = type;
    }

    // if (!Helpers.isNull(page)) {
    //   queryParams['page'] = page;
    // }

    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.tours,
          queryParams: queryParams);
      return Right(Tour.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, TourData>> tourDetail({required int id}) async {
    print(id);
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.tourDetail,
          queryParams: {'tour_id': id});
      return Right(TourData.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, ServiceModel>> serviceDetail({required int id}) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.serviceDetail,
          queryParams: {'service_id': id});
      return Right(ServiceModel.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Service>> Services() async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.getService,
          queryParams: {});
      return Right(Service.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> serviceCategory() async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.serviceCategory,
          queryParams: {});
      return Right((response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, ServicesSearch>> serviceSearch({
    required String value,
  }) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.searchService,
          queryParams: {
            'search_query': value,
          });
      return Right(ServicesSearch.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Products>> recentProducts() async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.recentProducts,
          queryParams: {});
      return Right(Products.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> productDetail({required String value}) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.productDetail,
          queryParams: {'product_id': value});
      return Right(response!);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, ProductCategory>> Categories() async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.categories,
          queryParams: {});
      return Right(ProductCategory.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, categoriesProduct>> productsCategory(
      {required int id}) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.productCategories,
          queryParams: {"category_id": id});
      return Right(categoriesProduct.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> addtoFavorites({
    required String id,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.addFavorites,
          queryParams: {
            'product_id': id,
          },
          headers: {
            'authorization': 'Bearer $resetoken'
          });

      return Right((response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> deletefromFavorites({
    required String id,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.deleteFavorites,
          queryParams: {
            'product_id': id,
          },
          headers: {
            'authorization': 'Bearer $resetoken'
          });

      return Right((response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Wishlist>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.getFavorites,
          headers: {'authorization': 'Bearer $resetoken'});

      return Right(Wishlist.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Wishlist>> addCart({
    required String product_id,
    required String quantity,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.addCart,
          queryParams: {'product_id': product_id, 'quantity': quantity},
          headers: {'authorization': 'Bearer $resetoken'});

      return Right(Wishlist.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Wishlist>> updateCart({
    required String product_id,
    required String quantity,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.updateCart,
          queryParams: {'product_id': product_id, 'quantity': quantity},
          headers: {'authorization': 'Bearer $resetoken'});
      return Right(Wishlist.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Wishlist>> deleteCart({
    required String product_id,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.deleteCart,
          queryParams: {
            'product_id': product_id,
          },
          headers: {
            'authorization': 'Bearer $resetoken'
          });
      return Right(Wishlist.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Wishlist>> emptyCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.deleteCart,
          // queryParams: {},
          headers: {'authorization': 'Bearer $resetoken'});
      return Right(Wishlist.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Cart>> getCartitem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.getCart,
          headers: {'authorization': 'Bearer $resetoken'});
      print(response);
      print('oooohjjj');

      return Right(Cart.fromMap(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Offer>> recentOffers() async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.offers,
          queryParams: {});
      return Right(Offer.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Offer>> offersTyp({required String value}) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.offerType,
          queryParams: {'offer_category': value});
      return Right(Offer.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, MyBookings>> getProductBookings(
      {required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.myProducts + '/$value',
          headers: {'authorization': 'Bearer $resetoken'});

      print(response.toString());
      return Right(MyBookings.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, MyServiceBookings>> getServiceBookings(
      {required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.myServices + '/$value',
          headers: {'authorization': 'Bearer $resetoken'});

      print(response.toString());
      return Right(MyServiceBookings.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, MyCabBookings>> getCabsBookings(
      {required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.myCabs + '/$value',
          headers: {'authorization': 'Bearer $resetoken'});

      print(response.toString());
      return Right(MyCabBookings.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, MyTourBookings>> getTourBookings(
      {required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.myTours + '/$value',
          headers: {'authorization': 'Bearer $resetoken'});

      print(response.toString());
      return Right(MyTourBookings.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, dynamic>> cabBook({
    required String value,
    required String size,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');

    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.cabBookings,
          queryParams: {'type': value, 'cab_size': size},
          headers: {'authorization': 'Bearer $resetoken'});

      return Right(response!);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, ProfileDetails>> getProfileDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.profile,
          headers: {'authorization': 'Bearer $resetoken'});
      print(response);
      print('oooohjjj');

      return Right(ProfileDetails.fromMap(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, ProfileDetails>> UpdateProfileDetails(
      var params) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.updateprofile,
          queryParams: params, headers: {'authorization': 'Bearer $resetoken'});
      print(response);
      print('oooohjjj');

      return Right(ProfileDetails.fromMap(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, ProfileDetails>> ChangePassword(var params) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.changepassword,
          queryParams: params, headers: {'authorization': 'Bearer $resetoken'});
      print(response);
      print('oooohjjj');

      return Right(ProfileDetails.fromMap(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Qurbani>> getQurbani(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
        dio,
        RequestType.get,
        ApiEndpoints.qurbani,
        headers: {'authorization': 'Bearer $resetoken'},
        queryParams: {'qurbani_type': value},
      );

      return Right(Qurbani.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Charity>> getCharity(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.charity,
          headers: {'authorization': 'Bearer $resetoken'},
          queryParams: {'charity_type': value});

      return Right(Charity.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Zakaat>> getZakaat(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? resetoken = prefs.getString('apiToken');
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.get, ApiEndpoints.zakat,
          headers: {'authorization': 'Bearer $resetoken'},
          queryParams: {'zakaat_type': value});

      return Right(Zakaat.fromJson(response!));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
