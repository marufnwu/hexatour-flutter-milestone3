import 'package:carousel_slider/carousel_slider.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/core/utils/Helpers.dart';
import 'package:hexatour/src/controllers/product_controller.dart';
import 'package:hexatour/src/views/screens/drawer_items/cart/my_cart.dart';
import 'package:hexatour/src/views/widgets/buttons/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/constant.dart';
import '../../../models/product/product_category_model.dart';
import '../../../models/product/product_model.dart';
import '../../widgets/custom_container/helper_container.dart';
import '../../widgets/dropdown/customdropdown.dart';

class ViewProductPage extends StatefulWidget {
  final String? productName;

  final String? id;
  final String? description;
  final String price;
  final String availability;
  // final String? attribute_name;
  // final String? attribute_value;
  final ProductImage? imagepath;
  const ViewProductPage(
      {required this.productName,
      required this.id,
      required this.description,
      required this.price,
      this.imagepath,
      required this.availability,
      // this.attribute_name,
      // this.attribute_value,
      super.key});

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  CarouselController controller = CarouselController();
  ProductController productController = Get.find<ProductController>();
  RxInt _activePage = 0.obs;
  RxInt _count = 1.obs;
  RxBool loading = false.obs;
  RxList<String> ids = <String>[].obs;
  RxString type = 'Size guide'.obs;
  RxString type1 = 'Select Colors'.obs;
  List a = [];

  @override
  void initState() {
    super.initState();

    productController.productDetail(value: widget.id!);
    Future.delayed(Duration(milliseconds: 100), () async {
      getdata();
      getdata2();
    });
  }

  getdata2() async {
    await productController.allWishlist();
    productController.allfavorites.forEach((element) {
      print('printing' + element.id.toString());
      setState(() {
        a.add(element.id.toString());
      });
    });
  }

  getdata() async {
    var a = await productController.getCart();
    print(a);
    print('getdata');
    if (a == true) {
      var b = productController.allcartitem;
      List<String> c = [];
      b.forEach((element) {
        c.add(element.products![0].id!.toString());
      });
      ids.addAll(c);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title:
            Text(widget.productName.toString(), style: textTheme.displayMedium),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: 45.h,
            width: 100.w,
            color: ColorConst.blackColor,
            child: CarouselSlider.builder(
              itemCount: productController.productsCat.length,
              itemBuilder: ((context, index, realIndex) {
                return Products(
                    imagepath: productController.productsCat[index].images![0]);
              }),
              options: CarouselOptions(
                  height: 145.h,
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
                  // autoPlay: true,
                  enlargeFactor: 0.1,
                  onPageChanged: (index, reason) {
                    _activePage.value = index;
                  }),
            ),
          ),
          Obx(
            () => Positioned(
              bottom: 59.h,
              left: 35.w,
              right: 0,
              height: 80,
              child: Row(
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: _activePage == index
                                  ? ColorConst.whiteColor
                                  : Colors.transparent),
                          shape: BoxShape.circle),
                      padding: EdgeInsets.all(3),
                      child: CircleAvatar(
                        radius: 3,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 10.h,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: ColorConst.whiteColor,
              child: IconButton(
                splashColor: Colors.transparent,
                padding: EdgeInsets.zero,
                onPressed: () async {
                  if (a.contains(widget.id.toString())) {
                    print('contains');
                    await productController.deletefavorites(
                        id: widget.id.toString());
                  } else {
                    print('not contains');
                    await productController.favorites(id: widget.id.toString());
                  }
                  await productController.allWishlist();
                  setState(() {
                    a.clear();
                  });
                  productController.allfavorites.forEach((element) {
                    a.add(element.id.toString());
                  });
                },
                icon: Icon(
                  Icons.favorite_border_outlined,
                  color:
                      a.contains(widget.id.toString()) //index == _selectedIndex
                          ? Color.fromARGB(255, 234, 41, 41)
                          : Color.fromARGB(255, 215, 215, 215),
                ),
              ),
            ),
          ),
          Obx(
            () => Container(
              margin: EdgeInsets.only(top: 38.h),
              padding: EdgeInsets.all(3.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorConst.whiteColor,
              ),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.all(3),
                  width: 100.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productName.toString(),
                        style: textTheme.displayMedium?.copyWith(
                            fontSize: 15.sp, color: ColorConst.blackColor),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        widget.description.toString(),
                        style: textTheme.displaySmall?.copyWith(
                            color: ColorConst.blackColor,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 2.h),
                      SvgPicture.asset("assets/images/divline.svg"),

                      productController.idss.isNotEmpty
                          ? Container(
                              height: 150,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: productController.idss.length,
                                  itemBuilder: (context, int index) {
                                    print(productController.idss[index]
                                        ['attribute_name']);

                                    return InkWell(
                                      onTap: () {
                                  var cartvalue =
                                            productController.idss[index]
                                                    ['types'][index]
                                                ['attribute_value'];
                                      },
                                      
                                      child: sizeContainer(
                                          size: productController.idss[index]
                                              ['attribute_name'],
                                          attri: productController.idss[index]
                                                  ['types'][index]
                                              ['attribute_value'],
                                          theme: textTheme),
                                    );

                                    // return sizeContainer(
                                    //     size: productController.idss[index]['attribute_name']
                                    //       ,
                                    //       attri: productController.idss[index]['types'][index]['attribute_value'],
                                    //     theme: textTheme);
                                  }),
                            )
                          : SizedBox(),
                      SizedBox(height: 2.h),
                      SvgPicture.asset("assets/images/divline.svg"),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.price.toString(),
                            style: textTheme.displaySmall
                                ?.copyWith(color: ColorConst.blackColor),
                          ),
                          Container(
                            width: 25.w,
                            height: 4.h,
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(
                                color: Color(0xff90EE90),
                              ),
                            ),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: IconButton(
                                      splashColor: Colors.transparent,
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        if (_count > 1) {
                                          _count.value -= 1;
                                        }
                                      },
                                      icon: Icon(
                                        Icons.remove,
                                        color: ColorConst.blackColor,
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      _count.value.toString(),
                                      style: textTheme.headlineMedium?.copyWith(
                                          color: ColorConst.blackColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      splashColor: Colors.transparent,
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        if (_count >= 1) {
                                          _count.value += 1;
                                        }
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: ColorConst.blackColor,
                                      ),
                                    ),
                                  ),
                                ]),
                          )
                        ],
                      ),
                      SizedBox(height: 2.h),
                      SvgPicture.asset("assets/images/divline.svg"),
                      SizedBox(
                        height: 2.h,
                      ),
                      // Row(
                      //   // crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       "size",
                      //       style: textTheme.displaySmall
                      //           ?.copyWith(color: ColorConst.blackColor),
                      //     ),
                      //     // SizedBox(height: 12,),
                      //     SizedBox(
                      //       width: 150,
                      //       child: CustomDropDown(
                      //           hint: type,
                      //           items: productController.proval.map((item) {
                      //             print(item['attribute_value']);
                      //             print('kkkkk');
                      //             return DropdownMenuItem(
                      //               value: item,
                      //               child: Text(item['attribute_value']),
                      //             );
                      //           }).toList(),
                      //           onChanged: (newVal) {
                      //             print(newVal);

                      //             // value: dropdownvalue,
                      //           }),
                      //     ),
                      //   ],
                      // ),

                      SizedBox(
                        height: 4.h,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromARGB(255, 255, 243, 239)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/available.png'),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                'Only ${widget.availability} stock Available',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConst.redColor),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      SvgPicture.asset("assets/images/divline.svg"),
                      // SizedBox(height: 1.h),
                      Container(
                        child: CarouselSlider.builder(
                          itemCount: 1,
                          itemBuilder: ((context, index, realIndex) {
                            return Container(
                              margin: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                  // border: Border.all(
                                  //     width: 1.0, color: ColorConst.greyColor),
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image:
                                        AssetImage('assets/images/offers.png'),
                                  )),
                            );
                          }),
                          options: CarouselOptions(
                              viewportFraction: 1.0,
                              height: 20.h,
                              // autoPlay: true,
                              onPageChanged: (index, reason) {
                                _activePage.value = index;
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        children: [
                          CustomButton(
                            width: 47.w,
                            height: 6.h,
                            name: ids.value.contains(widget.id.toString())
                                ? 'Go to cart'
                                : "Add to cart",
                            onTap: () async {
                              if (ids.value.contains(widget.id.toString())) {
                                Get.to(CartPage());
                              } else {
                                loading.value = true;
                                loading.refresh();
                                var bc =
                                    await productController.emptycartItem();

                                var a = await productController.cartItems(
                                    id: widget.id.toString(),
                                    quantity: _count.value.toString());
                                if (a == false) {
                                  getdata();
                                  Helpers.showSnackbar(
                                      text: 'Added to cart',
                                      color: ColorConst.kGreenColor,
                                      context: context);
                                  loading.value = false;
                                } else {
                                  loading.value = false;
                                }
                              }
                              // loading.refresh();
                            },
                            color: ColorConst.kGreenColor,
                            textStyle: textTheme.displaySmall,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          GestureDetector(
                            onTap: () async {
                              loading.value = true;
                              // loading.refresh();
                              var bc = await productController.emptycartItem();
                              if (bc == false) {
                                var a = await productController.cartItems(
                                    id: widget.id.toString(),
                                    quantity: _count.value.toString());
                                if (a == false) {
                                  getdata();
                                  Get.to(CartPage());

                                  // Helpers.showSnackbar(text: 'Added to cart', color: ColorConst.kGreenColor, context: context);
                                  loading.value = false;
                                } else {
                                  loading.value = false;
                                }
                              } else {
                                loading.value = false;
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorConst.kGreenColor, width: 1),
                                  borderRadius: BorderRadius.circular(15)),
                              width: 33.w,
                              height: 6.h,
                              child: Text(
                                'Buy Now',
                                textAlign: TextAlign.center,
                                style: textTheme.displaySmall
                                    ?.copyWith(color: ColorConst.kGreenColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => loading.value == true ? MyLoader() : Container(),
          ),
        ],
      ),
    );
  }
}

Widget sizeContainer(
    {required String size, required String attri, required TextTheme theme}) {
  return Container(
    // height: 13.h,
    // width: 16.w,
    padding: EdgeInsets.all(5),
    margin: EdgeInsets.only(left: 3.w, top: 1.h),
    decoration: BoxDecoration(
      // color: Color.fromARGB(255, 255, 251, 251),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 5.h,
          width: 36.w,
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(left: 3.w, top: 1.h),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 234, 232, 232), // shadow color
                blurRadius: 8, // shadow radius
                offset: Offset(2, 8), // shadow offset
                spreadRadius: 0.1, //
              ),
            ],
            color: Color.fromARGB(255, 246, 240, 240),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            size,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Row(
          children: [
            Container(
              height: 5.h,
              width: 16.w,
              padding: EdgeInsets.all(7),
              margin: EdgeInsets.only(left: 3.w, top: 1.h),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 160, 205, 161), // shadow color
                    blurRadius: 8, // shadow radius
                    offset: Offset(2, 8), // shadow offset
                    spreadRadius: 0.1, //
                  ),
                ],
                color: Color.fromARGB(255, 166, 230, 192),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                attri,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget Products({ProductsCategoryImage? imagepath}) {
  return Container(
      // padding: EdgeInsets.all(6),
      // margin: EdgeInsets.all(8),
      width: 128.w,
      child: InkWell(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://nodejs.hackerkernel.com/hexatour/public${imagepath?.imagepath}'),
              fit: BoxFit.fill),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 231, 227, 227),
                spreadRadius: 2,
                offset: Offset(1, 3),
                blurRadius: 3.0)
          ],
          color: ColorConst.whiteColor,
          borderRadius: BorderRadius.circular(6)));
}
