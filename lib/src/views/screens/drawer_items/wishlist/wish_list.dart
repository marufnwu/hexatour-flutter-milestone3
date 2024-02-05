import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:sizer/sizer.dart';
import '../../../../controllers/product_controller.dart';
import '../../../../models/product/product_category_model.dart';
import '../../../../models/product/wishlist_model.dart';
import '../../products/product_description.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

ProductController productController = Get.find<ProductController>();

class _WishListPageState extends State<WishListPage> {


   RxBool loading = true.obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      getdata();
    });
  }

  getdata() async {
    var res = await productController.allWishlist();
    if (res == true) {
      var a = productController.allcartitem;
      if (a.isNotEmpty) {
        // loading.value = false;
      }
      print('checking');
    }
  }

  getagain(context) {
    // print('ooookkk');
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WishListPage()));
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Obx(
      () => Scaffold(
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
          centerTitle: true,
          title: Text("My Wishlist"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: ColorConst.kGreenColor,
              image: DecorationImage(
                image: AssetImage("assets/images/appbar.png"),
              ),
            ),
          ),
        ),
        body:
         productController.allfavorites[0].id == 0 &&
                productController.allfavorites.length == 0
            ? Center(
                child: Text('No Items Added Yet.'),
              )
            : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                itemCount: productController.allfavorites.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(ViewProductPage(
                        // imagepath:  productController.allfavorites[index].images[0],
                        id:productController.allfavorites[index].id.toString(),
                       availability:productController.allfavorites[index].availability , description: productController.allfavorites[index].description,
                        price: productController.allfavorites[index].price
                          .toString(),
                         productName: productController.allfavorites[index].productName,));
                    },
                    child: wishListContainer(
                      id: productController.allfavorites[index].id.toString(),
                      description:
                          productController.allfavorites[index].description,
                      name: productController.allfavorites[index].productName,
                      image: productController.allfavorites[index].images[0],
                      amount: productController.allfavorites[index].price
                          .toString(),
                      textTheme: textTheme,
                      // productController: productController,
                    ),
                  );
                }),
      ),
    );
  }
}

class wishListContainer extends StatelessWidget {
  String name, description, amount, id;
  FavoriteImage? image;
  ProductsCategoryImage ? imagepath;
  TextTheme textTheme;

  // ProductController productController;

  wishListContainer({
    Key? key,
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.amount,
    required this.textTheme,

   this.imagepath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 16.h,
        margin: EdgeInsets.only(bottom: 2.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(223, 217, 217, 0.25),
              offset: Offset(0, 10),
              blurRadius: 15,
            ),
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ],
          border: Border.all(
            width: 0.4,
            color: const Color(0xffEDEDED),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Container(
                    height: 15.h,
                    width: 100.w,
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://nodejs.hackerkernel.com/hexatour/public${image?.imagepath}',
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.transparent,
                            child: const Icon(Icons.room_service, size: 50),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: ColorConst.whiteColor,
                      child: IconButton(
                        splashColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          await productController.deletefavorites(id: id);
                          // function(context);
                          await productController.allWishlist();
                        },
                        icon: Icon(
                          Icons.favorite_border_outlined,
                          color: Color(0xffFE8900),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 0.8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4.h,
                      child: Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.displaySmall?.copyWith(
                            color: ColorConst.blackColor, fontSize: 13.5.sp),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                      child: Text(
                        description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.displaySmall?.copyWith(
                          color: Color.fromARGB(255, 49, 47, 47),
                          fontSize: 13.5.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      '${amount}',
                      style: textTheme.displaySmall?.copyWith(
                          color: ColorConst.blackColor, fontSize: 13.5.sp),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


// Widget wishListContainer({
//     required id,
//     required String name,
//     FavoriteImage ? image,
//     required String description,
//     required String amount,
//     required TextTheme textTheme,
//     required ProductController productController,
//   required Function function,
// })
//     {
//       return Container(
//     height: 16.h,
//     margin: EdgeInsets.only(bottom: 2.h),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       boxShadow: [
//         BoxShadow(
//           color: Color.fromRGBO(223, 217, 217, 0.25),
//           offset: Offset(0, 10),
//           blurRadius: 15,
//         ),
//         BoxShadow(
//           color: Colors.white,
//           offset: const Offset(0.0, 0.0),
//           blurRadius: 0.0,
//           spreadRadius: 0.0,
//         ),
//       ],
//       border: Border.all(
//         width: 0.4,
//         color: const Color(0xffEDEDED),
//       ),
//     ),
//     child: Row(
//       children: [
//         Expanded(
//           flex: 2,
//           child: Stack(
//             children: [
//               Container(
//                 height: 15.h,
//                 width: 100.w,
//                 padding: const EdgeInsets.all(4.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.network(
//                    'https://nodejs.hackerkernel.com/hexatour/public${image?.imagepath}',
//                     fit: BoxFit.fill,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         color: Colors.transparent,
//                         child: const Icon(Icons.room_service, size: 50),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 10,
//                 top: 10,
//                 child: CircleAvatar(
//                   radius: 15,
//                   backgroundColor: ColorConst.whiteColor,
//                   child: IconButton(
//                     splashColor: Colors.transparent,
//                     padding: EdgeInsets.zero,
//                     onPressed: () async{
//                       await productController.deletefavorites(id: id.toString()).whenComplete(() => function);
//                       // function();
//                     },
//                     icon: Icon(
//                       Icons.favorite_border_outlined,
//                       color: Color(0xffFE8900),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         Expanded(
//           flex: 4,
//           child: Container(
//             padding: const EdgeInsets.all(5),
//             margin: EdgeInsets.only(top: 0.8.h),
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               SizedBox(
//                 height: 4.h,
//                 child: Text(
//                   name,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: textTheme.displaySmall?.copyWith(
//                       color: ColorConst.blackColor, fontSize: 13.5.sp),
//                 ),
//               ),
//
//                SizedBox(
//                 height: 5.h,
//                 child: Text(
//                   description,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: textTheme.displaySmall?.copyWith(
//                       color: Color.fromARGB(255, 49, 47, 47), fontSize: 13.5.sp),
//                 ),
//               ),
//               SizedBox(
//                 height: 0.5.h,
//               ),
//               Text('${amount}'
//               ,
//                 style: textTheme.displaySmall
//                     ?.copyWith(color: ColorConst.blackColor, fontSize: 13.5.sp),
//               ),
//             ]),
//           ),
//         )
//       ],
//     ),
//   );
//     }
