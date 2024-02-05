import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/controllers/product_controller.dart';
import 'package:hexatour/src/views/screens/products/product_description.dart';
import 'package:sizer/sizer.dart';

import '../../../models/product/product_category_model.dart';

class ProductCategory extends StatefulWidget {
  final String categoryName;

  ProductCategory({required this.categoryName, super.key});

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  final productController = Get.find<ProductController>();
  int _selectedIndex = -1;
  List a = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () async {
      await productController.allWishlist();
      productController.allfavorites.forEach((element) {
        print('printing' + element.id.toString());
        setState(() {
          a.add(element.id.toString());
        });
      });
      // print(productController.allfavorites);
      // print('all fav');
    });
  }

  String searchValue = '';

  _fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));
    await productController.productSearchs(value: searchValue);
    List finalList = [];
    print(productController.searchProduct);
    print('niceeee');
    productController.itemList.forEach((element) {
      finalList.add(element.productName);
      print(finalList);
      print(element.productName);
      print('ooooo');
    });
    return finalList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
          backgroundColor: Color.fromARGB(255, 158, 234, 160),
          title: Text(
            widget.categoryName,
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          onSearch: (value) => setState(() {
                searchValue = value;
              }),
          asyncSuggestions: (value) async {
            await productController.productSearchs(value: value);
          
            print(productController.searchProduct);
            print('niceeee');
            return productController.finalList;
          }),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
        ),
        itemCount: productController.productsCat.length,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () {
              //     value: productController.productsCat[index].id.toString());

              Get.to(
                ViewProductPage(
                  id: productController.productsCat[index].id.toString(),
                  availability: productController
                      .productsCat[index].availability
                      .toString(),
                  productName: productController.productsCat[index].productName,
                  description: productController.productsCat[index].description,
                  price: productController.productsCat[index].price.toString(),
                  // attribute_name: productController.proval[index]
                  //     ['attribute_name'],
                  // attribute_value: productController.proval[index]['attribute_value'],
                  // imagepath: productController.productsCat[index].images[0]
                ),
              );
            },
            child: products(
              id: productController.productsCat[index].id.toString(),
              name: productController.productsCat[index].productName,
              imagepath: productController.productsCat[index].images![0],
              amount: productController.productsCat[index].price.toString(),
              textTheme: Theme.of(context).textTheme,
              onTap: () async {
                print(_selectedIndex);

                // bool favbutton = false;
                // productController.allfavorites.forEach((element) {
                //   if(element.id.toString() == productController.productsCat[index].id.toString()){
                //     print(element.id);
                //     print('got');
                //     favbutton = true;
                //   }
                // });
                // print(index);
                setState(() {
                  if (_selectedIndex == index) {
                    // _selectedIndex = -1;
                    print('first');
                  } else {
                    _selectedIndex = index;
                    print('second');
                  }
                  print(_selectedIndex);
                  print(index);
                });

                if (a.contains(
                    productController.productsCat[index].id.toString())) {
                  print('contains');
                  await productController.deletefavorites(
                      id: productController.productsCat[index].id.toString());
                } else {
                  print('not contains');
                  await productController.favorites(
                      id: productController.productsCat[index].id.toString());
                }
                await productController.allWishlist();
                setState(() {
                  a.clear();
                });
                productController.allfavorites.forEach((element) {
                  a.add(element.id.toString());
                });
              },
              color: a.contains(productController.productsCat[index].id
                      .toString()) //index == _selectedIndex
                  ? Color.fromARGB(255, 234, 41, 41)
                  : Color.fromARGB(255, 215, 215, 215),
            ),
          );
        }),
      ),
    );
  }
}

Widget products(
    {String? name,
    String? id,
    ProductsCategoryImage? imagepath,
    TextTheme? textTheme,
    Function()? onTap,
    Color? color,
    String? amount}) {
  return Stack(
    children: [
      Container(
        height: 100.h,
        width: 100.w,
        margin: EdgeInsets.only(bottom: 1.h),
        padding: EdgeInsets.only(bottom: 1.2.h, left: 2.w, right: 2.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black,
            ],
            stops: [
              0.0,
              1.0,
            ],
          ),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: NetworkImage(
                  'https://nodejs.hackerkernel.com/hexatour/public${imagepath?.imagepath}'),
              fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name ?? "Default",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme?.displaySmall?.copyWith(fontSize: 12.sp),
            ),
            Text(
              amount ?? "Default",
              overflow: TextOverflow.ellipsis,
              style: textTheme?.displaySmall?.copyWith(fontSize: 12.sp),
            ),
          ],
        ),
      ),
      Positioned(
        height: 50,
        width: 50,
        right: 10,
        top: 10,
        child: CircleAvatar(
          radius: 15,
          backgroundColor: ColorConst.whiteColor,
          // child: IconButton(
          //   splashColor: Colors.transparent,
          //   padding: EdgeInsets.zero,
          //   onPressed: onTap,
          //   icon: Icon(
          //     Icons.favorite_border_outlined,
          //     color: color,
          //   ),
          // ),
          child: GestureDetector(
            onTap: onTap,
            child: IconButton(
              splashColor: Colors.transparent,
              padding: EdgeInsets.zero,
              onPressed: onTap,
              icon: Icon(
                Icons.favorite_border_outlined,
                color: color,
              ),
            ),
          ),
        ),
      )
    ],
  );
}
