import 'dart:collection';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hexatour/src/models/product/product_model.dart';
import '../../core/utils/Helpers.dart';
import '../../services/homepage_service.dart';
import '../models/cart/cart.dart';
import '../models/product/category.dart';
import '../models/product/product_category_model.dart';
import '../models/product/product_detail.dart';
import '../models/product/product_search_model.dart';
import '../models/product/wishlist_model.dart';

class ProductController extends GetxController {
  final Dio _dio;
  ProductController(this._dio);

  late HomeServices homeService = HomeServices(_dio);
  RxList<Recent> product = <Recent>[].obs;
  Rx<ProductData> productdetails = ProductData().obs;
  List proval = [].obs;
  List novalue = [].obs;
  List idss = [].obs;
  List att = [].obs;
  List sizes = [].obs;
  RxString cartvalue = "".obs;
  RxList<CategoriesProduct> categories = <CategoriesProduct>[].obs;
  RxList<ProductsCategory> productsCat = <ProductsCategory>[].obs;
  RxList<ProductType> searchProduct = <ProductType>[].obs;
  RxList<MyProducts> myProducts = <MyProducts>[].obs;
  RxList<Favorits> allfavorites = <Favorits>[].obs;
  RxList<Cartitem> allcartitem = <Cartitem>[].obs;
  RxList<ProductType> itemList = <ProductType>[].obs;
  List<String> finalList = [];
  RxString add1 = "".obs;
  RxString add = "".obs;

  final errorMessage = ''.obs;

  Future<bool> products() async {
    final response = await homeService.recentProducts();
    response.fold((failure) {
      return false;
    }, (success) {
      product.clear();
      debugPrint(success.toString());
      product.addAll(success.data.recent);
      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> productDetail({required String value}) async {
    final response = await homeService.productDetail(value: value);
    response.fold((failure) {
      return false;
    }, (success) {
      debugPrint(success.toString());
      print('datasssss');
      idss.clear();
      proval =
          success['data']['data']['category']['product_category_attributes'];

      // ids = success['data']['distinctArray'];

      for (int i = 0; i < success['data']['distinctArray'].length; i++) {
        print(success['data']['distinctArray'].length);
        var distict = proval.firstWhere((element) =>
            element['attribute_name'] == success['data']['distinctArray'][i]);

        print(distict);
        idss.add(distict);
      }

      print('whichone');
      print('detailsssss');
      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> category() async {
    final response = await homeService.Categories();
    response.fold((failure) {
      return false;
    }, (success) {
      categories.clear();
      debugPrint(success.toString());
      categories.addAll(success.data);
      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<Tuple2<bool, String>> productCategories({required int id}) async {
    final response = await homeService.productsCategory(id: id);
    response.fold((failure) {
      errorMessage.value = Helpers.convertFailureToMessage(failure);
      errorMessage.value = errorMessage.substring('Exception: '.length);
      debugPrint(errorMessage.value);
      return false;
    }, (success) {
      productsCat.clear();
      debugPrint(success.toString());
      productsCat.addAll(success.data);
      return true;
    });
    return response.isRight()
        ? Tuple2(true, "Success")
        : Tuple2(false, errorMessage.value);
  }

  Future<bool> favorites({required String id}) async {
    final response = await homeService.addtoFavorites(id: id);
    response.fold((failure) {
      return false;
    }, (success) {
      // productsCat.clear();
      debugPrint(success.toString());
      // productsCat.addAll(success.data);
      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> deletefavorites({required String id}) async {
    final response = await homeService.deletefromFavorites(id: id);
    response.fold((failure) {
      return false;
    }, (success) {
      // productsCat.clear();
      debugPrint(success.toString());
      // productsCat.addAll(success.data);
      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> allWishlist() async {
    final response = await homeService.getFavorites();
    response.fold((failure) {
      return false;
    }, (success) {
      // productsCat.clear();
      debugPrint(success.toString());
      allfavorites.clear();

      allfavorites.addAll(success.data);

      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> cartItems({required String id, required String quantity}) async {
    final response =
        await homeService.addCart(product_id: id, quantity: quantity);
    response.fold((failure) {
      return false;
    }, (success) {
      // productsCat.clear();
      debugPrint(success.toString());
      // allcartitem.addAll(item)
      // allfavorites.addAll(success.data);
      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> updatecartItem(
      {required String id, required String quantity}) async {
    final response =
        await homeService.updateCart(product_id: id, quantity: quantity);
    response.fold((failure) {
      return false;
    }, (success) {
      // productsCat.clear();
      debugPrint(success.toString());
      // allcartitem.addAll(item)
      // allfavorites.addAll(success.data);
      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> emptycartItem() async {
    final response = await homeService.emptyCart();
    response.fold((failure) {
      return false;
    }, (success) {
      // productsCat.clear();
      debugPrint(success.toString());
      // allfavorites.addAll(success.data);
      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> deletecartItem({
    required String id,
  }) async {
    final response = await homeService.deleteCart(product_id: id);
    response.fold((failure) {
      return false;
    }, (success) {
      // productsCat.clear();
      debugPrint(success.toString());
      // allfavorites.addAll(success.data);
      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> getCart() async {
    final response = await homeService.getCartitem();

    response.fold((failure) {
      return false;
    }, (success) {
      // productsCat.clear();
      allcartitem.clear();
      debugPrint(success.toString());
      print(success.data);
      print('notttnowww');

      allcartitem.addAll(success.data);

      print(allcartitem);
      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<dynamic> productSearchs({required String value}) async {
    final response = await homeService.productSearch(
      value: value,
    );
    response.fold((failure) {
      return false;
    }, (success) {
      debugPrint(success.toString());
      itemList.addAll(success.data.products);
      print(itemList);
      itemList.forEach(
        (element) {
          finalList.add(element.productName!);
        },
      );
      print('search hereee');

      return true;
    });
    return response.isRight() ? true : false;
  }

  Future<bool> productBookings({required String value}) async {
    final response = await homeService.getProductBookings(value: value);

    response.fold((failure) {
      return false;
    }, (success) {
      // productsCat.clear();
      myProducts.clear();
      debugPrint(success.toString());
      print(success.data);
      print('notttnowww');
      myProducts.addAll(success.data);
      return true;
    });
    return response.isRight() ? true : false;
  }
}
