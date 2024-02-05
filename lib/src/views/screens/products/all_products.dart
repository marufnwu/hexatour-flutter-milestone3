import 'package:carousel_slider/carousel_slider.dart';
import 'package:dartz/dartz.dart' as dev;
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/views/screens/products/product_categories.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/Helpers.dart';
import '../../../controllers/product_controller.dart';
import '../../../models/product/product_model.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final productController = Get.find<ProductController>();

  CarouselController controller = CarouselController();
  RxInt _activePage = 0.obs;

  List<Map<String, dynamic>> images = [
    {
      "img": "assets/images/offer.png",
    },
    {
      "img": "assets/images/offer.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: DraggableFab(
          child: FloatingActionButton(
            onPressed: (() {}),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(
              "assets/icons/whatsapp.svg",
              height: 6.h,
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text('Categories'),
          centerTitle: true,
          backgroundColor: ColorConst.kGreenColor,
        ),
        body: SafeArea(
            child: Obx(() => Column(children: [
                  Container(
                      // height: 39.h,
                      padding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                      child: CarouselSlider.builder(
                        itemCount: images.length,
                        itemBuilder: ((context, index, realIndex) {
                          return Container(
                            height: 30.h,
                            width: 85.w,
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                // border: Border.all(
                                //     width: 1.0, color: ColorConst.greyColor),
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: AssetImage(images[index]["img"]),
                                )),
                          );
                        }),
                        options: CarouselOptions(
                            viewportFraction: 1.0,
                            autoPlay: true,
                            onPageChanged: (index, reason) {
                              _activePage.value = index;
                            }),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        images.length,
                        (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: _activePage == index
                                            ? ColorConst.kGreenColor
                                            : Colors.transparent),
                                    shape: BoxShape.circle),
                                padding: EdgeInsets.all(3),
                                child: CircleAvatar(
                                  radius: 5,
                                  backgroundColor: _activePage == index
                                      ? ColorConst.kGreenColor
                                      : ColorConst.greyColor,
                                ),
                              ),
                            )),
                  ),
                  Expanded(
                      child: GridView.builder(
                          padding: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 4.w),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: productController.categories.length,
                          itemBuilder: ((context, index) {
                            return allProducts(
                                id: productController.categories[index].id
                                    .toString(),
                                name: productController
                                    .categories[index].categoryName,
                                // imagepath: productController.product[index].images[0]
                                //     ,
                                textTheme: Theme.of(context).textTheme,
                                onTap: () async {
                                  print(productController.categories[index].id
                                      .toString());
                                  print('yeyeyeye2');
                                  dev.Tuple2 category =
                                      await productController.productCategories(
                                    id: productController.categories[index].id,
                                  );
                                  if (category.value1) {
                                    Get.to(ProductCategory(
                                        categoryName: productController
                                            .categories[index].categoryName));
                                    print(
                                        productController.categories[index].id);
                                  } else {
                                    Helpers.showSnackbar(
                                        text: category.value2,
                                        color: Colors.redAccent,
                                        context: context);
                                  }

                                  //
                                });
                          })))
                ]))));
  }
}

Widget allProducts(
    {String? name,
    String? id,
    ProductImage? imagepath,
    TextTheme? textTheme,
    Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 18.h,
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.only(bottom: 1.2.h, left: 2.w, right: 2.w),
      decoration: BoxDecoration(
        color: ColorConst.blackColor,
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [
        //     Colors.transparent,
        //     Colors.black,
        //   ],
        //   stops: [
        //     0.0,
        //     1.0,
        //   ],
        // ),
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            image: NetworkImage(
                'https://t4.ftcdn.net/jpg/02/40/98/49/360_F_240984942_eZXNlIqQ0SRIMyIZMOqVYG3kAmKqpCPJ.jpg'),
            fit: BoxFit.fill),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          name!,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: textTheme?.displaySmall?.copyWith(
              fontSize: 13.sp, color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
    ),
  );
}
