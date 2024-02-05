import 'package:carousel_slider/carousel_slider.dart';

import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/controllers/cab_controller.dart';
import 'package:hexatour/src/controllers/home_page_controller.dart';

import 'package:hexatour/src/controllers/servie_controller.dart';

import 'package:hexatour/src/views/screens/auth/login_page.dart';
import 'package:hexatour/src/views/screens/cabs/cab_homepage.dart';
import 'package:hexatour/src/views/screens/drawer_items/wishlist/wish_list.dart';
import 'package:hexatour/src/views/screens/home/drawer.dart';
import 'package:hexatour/src/views/screens/home/search_field.dart';
import 'package:hexatour/src/views/screens/offers/offers_page.dart';
import 'package:hexatour/src/views/screens/products/all_products.dart';
import 'package:hexatour/src/views/screens/products/products_page.dart';
import 'package:hexatour/src/views/screens/service/all_service.dart';
import 'package:hexatour/src/views/screens/service/service_page.dart';
import 'package:hexatour/src/views/screens/tours/all_tours.dart';
import 'package:hexatour/src/views/screens/tours/recent_tour.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../../controllers/tour_controller.dart';
import '../../../models/product/product_model.dart';
import '../drawer_items/cart/my_cart.dart';
import '../products/product_description.dart';
import '../service/view_service_page.dart';
import '../tours/tour_page.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  TextEditingController searchController = TextEditingController();
  final tourController = Get.find<TourController>();
  final productController = Get.find<ProductController>();
  final serviceController = Get.find<ServiceController>();
  final homepageController = Get.find<HomePageController>();
  final cabController = Get.find<CabController>();
  CarouselController controller = CarouselController();

  final authController = Get.find<AuthController>();
  RxInt _activePage = 0.obs;
  final RxBool isLogin = false.obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    isLoggedin();
  }

  Future<void> isLoggedin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin.value = await prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                    "Do you Want to close this App",
                    style: TextStyle(
                        color: ColorConst.blackColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(
                            color: ColorConst.blackColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "No",
                        style: TextStyle(
                            color: ColorConst.blackColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ));
        return false;
      },
      child: Scaffold(
   drawerEnableOpenDragGesture: false,
     
          key: scaffoldKey,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: DraggableFab(
            child: FloatingActionButton(
              onPressed: (() {}),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Image(
                image: AssetImage('assets/images/whatsapp1.png'),
                height: 20.h,
                width: 30.w,
              ),
            ),
          ),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: AppBar(
              centerTitle: true,
              leading: Obx(() {
                return isLogin.isTrue
                    ? IconButton(
                        icon: const Image(
                          image: AssetImage(
                            'assets/images/Group 5.png',
                          ),
                          height: 24,
                        ),
                        onPressed: () async {
                          setState(() {});
                          scaffoldKey.currentState!.openDrawer();
                        },
                      )
                    : InkWell(
                        onTap: () {
                          _logout();
                          // Get.to(LoginPage());
                        },
                        child: Icon(
                          Icons.logout,
                          color: Color.fromARGB(255, 244, 234, 234),
                        ));
              }),
              flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
                  expandedTitleScale: 1.0,
                  centerTitle: true,
                  background: SvgPicture.asset(
                    'assets/images/headerbg.svg',
                    color: Color.fromARGB(255, 234, 230, 230),
                  ),
                  title: SizedBox(
                      width: 360,
                      child: AutoCompleteField(
                          selectedSuggestion: searchController,
                          hint: 'Type to Search',
                          suggestionsCallback: (pattern) async {
                            homepageController.itemList.clear();
                            if (pattern.length >= 1) {
                              await Future.delayed(Duration(milliseconds: 200),
                                  () async {
                                await homepageController.searchall(
                                  value: pattern,
                                );
                              });
                            }
                            List finalList = [];
                            homepageController.itemList.forEach((element) {
                              finalList.add(element.name);
                              print(finalList);
                            });
                            return finalList;
                          },
                          onSuggestionSelected: (value) async {
                            print(value);
                            print('value selected');
                            final object = homepageController.itemList
                                .where((p0) => p0.name == value)
                                .first;

                            print(object.tag);
                            print('tagggsss');
                            switch (object.tag) {
                              case "service":
                                {
                                  await serviceController.serviceDetail(
                                      id: object.id);
                                  final data =
                                      serviceController.servicedata.value;
                                  Get.to(ViewServicePage(
                                    id: data.id!,
                                    name: data.serviceName!,
                                    service_price: data.servicePrice!,
                                    description: data.description!,
                                    imagepath: data.images!,
                                  ));
                                }
                                break;
                              case "tours":
                                {
                                  await tourController.tourdetail(
                                      id: object.id);
                                  final data1 =
                                      tourController.tourDetails.value;
                                  Get.to(
                                    TourdetailPage(
                                      id: data1.id!,
                                      tourname: data1.tourname!,
                                      price: data1.price.toString(),
                                      description: data1.description!,
                                      imagepath: data1.images!,
                                      no_of_person: data1.noOfPerson.toString(),
                                      duration: data1.duration!,
                                      minimumBookingAmount:
                                          data1.minimumBookingAmount.toString(),
                                    ),
                                  );
                                }
                                break;
                              case "products":
                                {
                                  print(object.id);
                                  print(object.tag);
                                  print(object.name);

                                  await productController.productCategories(
                                      id: object.category_id);
                                  var data =
                                      await productController.productsCat;

                                  // await serviceController.serviceDetail(id: object.id);
                                  // final data = await serviceController.servicedata.value;
                                  var abc = 0;
                                  var xyz;
                                  data.forEach((element) {
                                    if (element.id.toString() ==
                                        object.id.toString()) {
                                      xyz = abc;
                                      print(element.id);
                                      print(object.id);
                                    }
                                    abc++;
                                  });
                                  ProductImage? ls;
                                  print(data[xyz].productName);
                                  Get.to(
                                    ViewProductPage(
                                      id: data.value[xyz].id.toString(),
                                      availability: data.value[xyz].availability
                                          .toString(),
                                      description: data.value[xyz].description
                                          .toString(),
                                      price: data.value[xyz].price.toString(),
                                      productName: data.value[xyz].productName
                                          .toString(),
                                      // imagepath: data.value[xyz].images![0],
                                    ),
                                    // ViewServicePage(
                                    //   id: data.id!,
                                    //   name: data.serviceName!,
                                    //   service_price: data.servicePrice!,
                                    //   description: data.description!,
                                    //   imagepath: data.images!,
                                    // ),
                                  );
                                }
                                break;
                              case "cab":
                                {
                                  Get.to(CabHomePage());
                                }
                                break;
                              default:
                                {
                                  null;
                                }
                                break;
                            }
                          }))),
              backgroundColor: ColorConst.kGreenColor,
              title: const Text(
                'Home',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'),
              ),
              actions: <Widget>[
                InkWell(
                    onTap: () async {
                      await productController.allWishlist();
                      Get.to(WishListPage());
                    },
                    child: DrawerIcon('assets/images/fav.png')),
                InkWell(
                  onTap: () async {
                    await productController.getCart();
                    Get.to((CartPage()));
                  },
                  child: DrawerIcon('assets/images/shopping-cart 1.png'),
                ),
              ],
            ),
          ),
          drawer: Drawer(
  
   child: DrawerItems(),
  
  
   ),
 
            // child: DrawerItems(),
          
          body: RefreshIndicator(
            color: ColorConst.kGreenColor,
            onRefresh: (() async {
              setState(() {
                homepageController.getOffers();
                tourController.tours();
                serviceController.getService();
                productController.products();
              });
              // await tourController.tours();
              // await serviceController.getService();
              // await productController.products();
              // await homepageController.getOffers();
            }),
            child: SingleChildScrollView(
                padding: EdgeInsets.all(11),
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(children: [
                  Container(
                    child: CarouselSlider.builder(
                      itemCount: homepageController.offers.length,
                      itemBuilder: ((context, index, realIndex) {
                        return OffersPage(
                            indexx: index,
                            context: context,
                            image: homepageController.offers[index].image);
                      }),
                      options: CarouselOptions(
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            _activePage.value = index;
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Obx(
                    () => Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        homepageController.offers.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: _activePage == index
                                        ? ColorConst.kGreenColor
                                        : Colors.transparent),
                                shape: BoxShape.circle),
                            padding: EdgeInsets.all(3),
                            child: CircleAvatar(
                              radius: 4,
                              backgroundColor: _activePage == index
                                  ? ColorConst.kGreenColor
                                  : ColorConst.greyColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        'Exclusive package',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      )),
                      InkWell(
                        onTap: () {
                          isLogin.isTrue
                              ? Get.to(AllTour())
                              : Get.to(LoginPage());
                        },
                        child: Text(
                          'View all',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: ColorConst.kGreenColor),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    child: CarouselSlider.builder(
                        itemCount: tourController.tourPackage.length,
                        itemBuilder: ((context, index, realIndex) {
                          return TourPackage(
                              price: tourController.tourDetails.value.price
                                  .toString(),
                              id: tourController.tourPackage[index].id,
                              description:
                                  tourController.tourPackage[index].description,
                              no_of_person: tourController
                                  .tourDetails.value.noOfPerson
                                  .toString(),
                              imagepath:
                                  tourController.tourPackage[index].images[0],
                              duration:
                                  tourController.tourPackage[index].duration,
                              tourname:
                                  tourController.tourPackage[index].tourname);
                          //
                        }),
                        options: CarouselOptions(
                          autoPlay: true,
                          viewportFraction: 0.6,
                        )),
                  ),

                  //
                  SizedBox(
                    height: 12,
                  ),
                  CarouselSlider.builder(
                      itemCount: 5,
                      itemBuilder: ((context, index, realIndex) {
                        return Container(
                            margin: EdgeInsets.all(10),
                            width: 370,
                            child: Image(
                              image: AssetImage('assets/images/adds.png'),
                              fit: BoxFit.fill,
                            ),
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 231, 227, 227),
                                      spreadRadius: 2,
                                      offset: Offset(1, 3),
                                      blurRadius: 3.0)
                                ],
                                color: ColorConst.whiteColor,
                                borderRadius: BorderRadius.circular(16)));
                      }),
                      options: CarouselOptions(
                          height: 140,
                          enableInfiniteScroll: false,
                          viewportFraction: 1.0)),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: const Text(
                          'Shop by category',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.5),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          isLogin.isTrue
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => AllProducts())))
                              : Get.to(LoginPage());
                        },
                        child: Text(
                          'View all',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: ColorConst.kBlackColor),
                        ),
                      )
                    ],
                  ),
                  Obx(() {
                    print('productss');

                    print('productssss');
                    return Container(
                      child: CarouselSlider.builder(
                          itemCount: productController.product.length,
                          itemBuilder: ((context, index, realIndex) {
                            return RecentProducts(
                              id: productController.product[index].id
                                  .toString(),
                              indexx: index,
                              context: context,
                              price: productController.product[index].price,
                              productName:
                                  productController.product[index].productName,
                              description:
                                  productController.product[index].description,
                              imagepath:
                                  productController.product[index].images[0],
                              availability:
                                  productController.product[index].availability,
                            );
                          }),
                          options: CarouselOptions(
                              viewportFraction: 0.46,
                              autoPlay: true,
                              // height: 160,
                              enableInfiniteScroll: true)),
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Services',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5),
                      ),
                      InkWell(
                        onTap: () {
                          isLogin.isTrue
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllServices(),
                                  ))
                              : Get.to(LoginPage());
                        },
                        child: Text(
                          'View all',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: ColorConst.kBlackColor),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Obx(() {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: serviceController.service.length,
                        itemBuilder: ((context, index) {
                          return Servicepage(
                            imagepath:
                                serviceController.service[index].images[0],
                            service_name:
                                serviceController.service[index].serviceName,
                            id: serviceController.service[index].id,
                          );
                        }));
                  }),
                ])),
          )),
    );
  }
}

Widget DrawerIcon(image) {
  return Container(
    padding: EdgeInsets.all(17),
    child: Image(
      image: AssetImage(image),
    ),
  );
}

Future<void> _logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();

  Get.offAll(LoginPage());
}
