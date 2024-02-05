
import 'package:country_picker/country_picker.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexatour/src/controllers/servive_payment_controller.dart';
import 'package:hexatour/src/views/screens/drawer_items/cart/widgets.dart/add_widget.dart';
import 'package:hexatour/src/views/widgets/buttons/custom_button.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../controllers/home_page_controller.dart';
import '../../../../controllers/product_controller.dart';
import '../../../../models/cart/cart.dart';
import '../../../widgets/date_time_picker/date_picker.dart';
import '../../../widgets/radio/radio_listtile.dart';
import '../../../widgets/textfields/custom_textfield.dart';
import '../../products/all_products.dart';
import '../../tours/widgets/tour_detail_widget.dart';

RxString groupVal = "International".obs;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

ProductController productController = Get.find<ProductController>();

HomePageController homeController = Get.find<HomePageController>();
PaymentController paymentController = Get.find<PaymentController>();

class _CartPageState extends State<CartPage> {
  RxList<TextEditingController> quantity_list = <TextEditingController>[].obs;
  RxList<TextEditingController> amount_list = <TextEditingController>[].obs;

  RxInt totalamount = 0.obs;
  RxBool loading = true.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      getdata();
      getoffers();
    });
  }

  getoffers() async {
    var res = await homeController.getOffertype(value: 'product');

    var a = homeController.offersType;
    a.forEach((element) {
      print(element.offerName);
    });
    print('offerssss');
  }

  getdata() async {
    var res = await productController.getCart();
    if (res == true) {
      var a = productController.allcartitem;
      int am = 0;
      if (a.isNotEmpty) {
        List<TextEditingController> k = [];
        List<TextEditingController> j = [];
        print('a');
        a.forEach((element) {
          print(element);
          k.add(TextEditingController(text: element.quantity.toString()));
          j.add(TextEditingController(
              text: element.products![0].price.toString()));
          am += element.quantity! * element.products![0].price!;
        });
        quantity_list.addAll(k);
        amount_list.addAll(j);
        totalamount.value = am;
        loading.value = false;
        loading.refresh();
      }
      print('checking');
    }
  }

  TextEditingController addControl = TextEditingController();
  TextEditingController add1Control = TextEditingController();
  TextEditingController hotelControl = TextEditingController();
  TextEditingController roomControl = TextEditingController();
  TextEditingController nameControl = TextEditingController();
  TextEditingController pinControl = TextEditingController();
  TextEditingController cityControl = TextEditingController();
  TextEditingController phoneControl = TextEditingController();
  TextEditingController timeControl = TextEditingController();
  bool _validate = false;

  RxString nation = "Select nationality".obs;
  RxString addressss = "International".obs;
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
          title: Text("My Cart"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: ColorConst.kGreenColor,
              image: DecorationImage(
                image: AssetImage("assets/images/appbar.png"),
              ),
            ),
          ),
        ),
        body: loading.value
            ? Center(
                child: Text(
                'No Items Added Yet.',
                style: TextStyle(
                    color: ColorConst.blackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ))
            : productController.allcartitem.length == 0
                //  &&
                //         productController.allcartitem[0].id == 0
                ? Center(
                    child: Text('No Items Added Yet.'),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 2.h),
                          itemCount: productController.allcartitem.length,
                          itemBuilder: (context, index) {
                            print(productController.allcartitem.length);
                            ProductCart? a = productController
                                .allcartitem[index].products![0];
                            // int b = productController.allcartitem[index].quantity!;
                            int b = int.parse(quantity_list[index].text);
                            return wishListContainer(
                              context: context,
                              index: index,
                              id: a.id.toString(),
                              description: a.description.toString(),
                              name: a.productName.toString(),
                              image: a.images![0],
                              amount: a.price.toString(),
                              textTheme: textTheme,
                              quantity: b,
                              quantity_list: quantity_list,
                              amount_list: amount_list,
                              loading: loading,
                              totalamount: totalamount,
                            );
                          },
                        ),
                        promo(context),
                        paybill(context, totalamount.value.toString()),
                        SizedBox(
                          child: Text(
                            'Add address',
                            style: textTheme.displaySmall?.copyWith(
                                color: Color.fromARGB(255, 25, 24, 24),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: CustomRadio(
                                  title: "International",
                                  groupVal: groupVal,
                                  onChanged: (value) {
                                    addressss.value = 'International';
                                    productController.add1 = value;
                                  },
                                ),
                              ),
                              Flexible(
                                  child: CustomRadio(
                                      title: "Local",
                                      groupVal: groupVal,
                                      onChanged: (value) {
                                        addressss.value = 'Local';
                                        productController.add = value;
                                        print(groupVal);
                                      })),
                            ]),
                        // if (productController.add1 == 'International')
                        if (addressss.value == 'International')
                          Container(
                              child: Column(children: [
                            help(
                                title: " Name",
                                widget: CustomTextField(
                                    control: nameControl,
                                    hint: "Enter name",
                                    isRequired: true,
                                    errortext: _validate
                                        ? 'Value Can\'t Be Empty'
                                        : null,
                                    keyboardType: TextInputType.name,
                                    isNumber: false,
                                    textInputAction: TextInputAction.next,
                                    style: textTheme.headlineMedium!.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: ColorConst.blackColor)),
                                theme: textTheme),
                            help(
                                title: "Address",
                                widget: CustomTextField(
                                    control: addControl,
                                    hint: "Enter Address",
                                    isRequired: true,
                                    errortext: _validate
                                        ? 'Value Can\'t Be Empty'
                                        : null,
                                    keyboardType: TextInputType.name,
                                    isNumber: false,
                                    textInputAction: TextInputAction.next,
                                    style: textTheme.headlineMedium!.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: ColorConst.blackColor)),
                                theme: textTheme),
                            help(
                                title: "Address1",
                                widget: CustomTextField(
                                    control: add1Control,
                                    hint: "Enter Address1",
                                    isRequired: true,
                                    errortext: _validate
                                        ? 'Value Can\'t Be Empty'
                                        : null,
                                    keyboardType: TextInputType.name,
                                    isNumber: false,
                                    textInputAction: TextInputAction.next,
                                    style: textTheme.headlineMedium!.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: ColorConst.blackColor)),
                                theme: textTheme),
                            help(
                                title: "City",
                                widget: CustomTextField(
                                    control: cityControl,
                                    hint: "Enter City",
                                    isRequired: true,
                                    errortext: _validate
                                        ? 'Value Can\'t Be Empty'
                                        : null,
                                    keyboardType: TextInputType.name,
                                    isNumber: false,
                                    textInputAction: TextInputAction.next,
                                    style: textTheme.headlineMedium!.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: ColorConst.blackColor)),
                                theme: textTheme),
                            help(
                              theme: textTheme,
                              title: "Country",
                              widget: InkWell(
                                onTap: () {
                                  showCountryPicker(
                                    context: context,
                                    showPhoneCode: true,
                                    countryListTheme: CountryListThemeData(
                                        inputDecoration: InputDecoration(
                                            hintText: 'Select nationality',
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .displaySmall
                                                ?.copyWith(
                                                    color: Color.fromARGB(
                                                        255, 70, 65, 65),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                        searchTextStyle: textTheme.displaySmall!
                                            .copyWith(
                                                color: ColorConst.blackColor)),
                                    onSelect: (Country value) {
                                      nation.value = value.name;
                                    },
                                  );
                                },
                                child: Container(
                                  width: 100.w,
                                  height: 6.h,
                                  padding:
                                      EdgeInsets.only(left: 4.w, top: 1.5.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffF4F6F8),
                                  ),
                                  child: Obx(() => Text(
                                        nation.value,
                                        style: textTheme.displaySmall?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color:
                                                nation.value == "Select Country"
                                                    ? Color(0xffC6C5C5)
                                                    : Color.fromARGB(
                                                        255, 64, 63, 63)),
                                      )),
                                ),
                              ),
                            ),

                            help(
                              title: "Pincode",
                              widget: CustomTextField(
                                  control: pinControl,
                                  hint: "Enter pin code",
                                  isRequired: true,
                                  errortext: _validate
                                      ? 'Value Can\'t Be Empty'
                                      : null,
                                  keyboardType: TextInputType.name,
                                  isNumber: false,
                                  textInputAction: TextInputAction.next,
                                  style: textTheme.headlineMedium!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: ColorConst.blackColor)),
                              theme: textTheme,
                            ),

                            //  if (_selectedVal != "Intercity")
                            // ],
                          ])),
                        if (addressss.value == 'Local')
                          // if (productController.add == 'Local')
                          Container(
                            child: Column(
                              children: [
                                help(
                                  title: " Hotel Name",
                                  widget: CustomTextField(
                                    control: hotelControl,
                                    hint: "Enter hotel name",
                                    isRequired: true,
                                    errortext: _validate
                                        ? 'Value Can\'t Be Empty'
                                        : null,
                                    keyboardType: TextInputType.name,
                                    isNumber: false,
                                    textInputAction: TextInputAction.next,
                                    style: textTheme.headlineMedium!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: ColorConst.blackColor,
                                    ),
                                  ),
                                  theme: textTheme,
                                ),
                                help(
                                  title: " Room Number",
                                  widget: CustomTextField(
                                    control: roomControl,
                                    hint: "Enter room number",
                                    isRequired: true,
                                    errortext: _validate
                                        ? 'Value Can\'t Be Empty'
                                        : null,
                                    keyboardType: TextInputType.name,
                                    isNumber: false,
                                    textInputAction: TextInputAction.next,
                                    style: textTheme.headlineMedium!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: ColorConst.blackColor,
                                    ),
                                  ),
                                  theme: textTheme,
                                ),
                                help(
                                  title: "Mobile Number",
                                  widget: CustomTextField(
                                    control: phoneControl,
                                    hint: "Enter mobile number",
                                    isRequired: true,
                                    errortext: _validate
                                        ? 'Value Can\'t Be Empty'
                                        : null,
                                    keyboardType: TextInputType.name,
                                    isNumber: false,
                                    textInputAction: TextInputAction.next,
                                    style: textTheme.headlineMedium!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: ColorConst.blackColor,
                                    ),
                                  ),
                                  theme: textTheme,
                                ),
                                help(
                                  title: "Preffred time",
                                  widget: DatePicker(
                                    isTimePicker: true,
                                    onSelect: (picked) {
                                      print(picked);
                                      var timeOfTravel = picked;
                                    },
                                    value: null,
                                  ),
                                  theme: textTheme,
                                ),
                              ],
                            ),
                          ),

                        CustomButton(
                            left: 10,
                            right: 10,
                            textStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: ColorConst.whiteColor),
                            color: ColorConst.kGreenColor,
                            name: 'Payment',
                            onTap: (() async {
                              await paymentController.verifycartPayment(
                                  productDetails: [],
                                  total_cart_amount: totalamount.toString(),
                                  address1: addControl.text,
                                  address2: add1Control.text,
                                  amount_paid: totalamount.toString(),
                                  state: cityControl.text,
                                  country: nation.value,
                                  pincode: pinControl.text,
                                  currency: "INR",
                                  city: cityControl.text,
                                  location_type: addressss.value,
                                  name: nameControl.text,
                                  payment_method: "card",
                                  payment_type: "partial");
                            })),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
      ),
    );
  }
}

Widget wishListContainer({
  required BuildContext context,
  required int index,
  required String id,
  required String name,
  CartImage? image,
  required String description,
  required String amount,
  required TextTheme textTheme,
  required int quantity,
  required RxList<TextEditingController> quantity_list,
  required RxList<TextEditingController> amount_list,
  required RxBool loading,
  required RxInt totalamount,
}) {
  return Container(
    // height: 25.h,
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(118, 106, 106, 0.247),
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
    child: Obx(
      () => Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Container(
                      height: 10.h,
                      width: 55.w,
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
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(top: 0.8.h),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3.h,
                          width: 33.w,
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.displaySmall?.copyWith(
                                color: ColorConst.blackColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                          width: 40.w,
                          child: Text(
                            description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.displaySmall?.copyWith(
                                color: Color.fromARGB(255, 49, 47, 47),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        // SizedBox(
                        //   height: 0.5.h,
                        // ),
                        // Text(
                        //   'color: red',
                        //   style: textTheme.displaySmall?.copyWith(
                        //       color: ColorConst.blackColor, fontSize: 12.5.sp),
                        // ),
                      ]),
                ),
              )
            ],
          ),
          SizedBox(
            height: 1.h,
            width: 2.w,
          ),
          // Divider(),
          SvgPicture.asset("assets/images/divline.svg"),
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 28.w,
                height: 4.h,
                // margin: EdgeInsets.only(right: 60.w),
                // padding: EdgeInsets.only(left: 3.w),
                decoration: BoxDecoration(
                  // color: ColorConst.blackColor,
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(
                    color: Color(0xff90EE90),
                  ),
                ),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: IconButton(
                        splashColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          int a = int.parse(quantity_list.value[index].text);
                          if (a > 1) {
                            loading.value = true;
                            a -= 1;
                            // quantity -= 1;
                            var res = await productController.updatecartItem(
                                id: id, quantity: a.toString());
                            if (res == true) {
                              quantity_list.value[index].text = a.toString();
                              quantity_list.refresh();
                              loading.value = false;
                              int am = 0;
                              for (var o = 0; o < quantity_list.length; o++) {
                                am += int.parse(quantity_list.value[o].text) *
                                    int.parse(amount_list.value[o].text);
                              }
                              totalamount.value = am;
                            } else {
                              loading.value = false;
                            }
                          }
                          print(quantity_list.value[index].text);
                        },
                        icon: Icon(
                          Icons.remove,
                          color: ColorConst.blackColor,
                        ),
                      ),
                    ),
                    Text(
                      // _count.value.toString(),
                      quantity_list.value[index].text,
                      style: textTheme.headlineMedium?.copyWith(
                          color: ColorConst.blackColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: IconButton(
                        splashColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          int a = int.parse(quantity_list.value[index].text);
                          if (a >= 1) {
                            loading.value = true;
                            a += 1;
                            var res = await productController.updatecartItem(
                                id: id, quantity: a.toString());
                            if (res == false) {
                              quantity_list.value[index].text = a.toString();
                              quantity_list.refresh();
                              loading.value = false;
                              int am = 0;
                              for (var o = 0; o < quantity_list.length; o++) {
                                am += int.parse(quantity_list.value[o].text) *
                                    int.parse(amount_list.value[o].text);
                              }
                              totalamount.value = am;
                            } else {
                              loading.value = false;
                            }
                            // quantity -= 1;
                          }
                          print(quantity_list.value[index].text);
                        },
                        icon: Icon(
                          Icons.add,
                          color: ColorConst.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.3,
              ),
              InkWell(
                onTap: () async {
                  var a = await productController.deletecartItem(id: id);
                  if (a == false) {
                    quantity_list.value.removeAt(index);
                    amount_list.value.removeAt(index);
                    await productController.getCart();
                    int am = 0;
                    for (var o = 0; o < quantity_list.length; o++) {
                      am += int.parse(quantity_list.value[o].text) *
                          int.parse(amount_list.value[o].text);
                    }
                    totalamount.value = am;
                  }
                },
                child: Text(
                  'Remove',
                  style: TextStyle(
                    color: ColorConst.kRedColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                amount,
                style: textTheme.displaySmall
                    ?.copyWith(color: ColorConst.blackColor, fontSize: 13.5.sp),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async {
                  var a = await productController.favorites(id: id);
                  if (a == false) {
                    var b = await productController.deletecartItem(id: id);
                    if (b == false) {
                      quantity_list.value.removeAt(index);
                      amount_list.value.removeAt(index);
                      await productController.getCart();
                      int am = 0;
                      for (var o = 0; o < quantity_list.length; o++) {
                        am += int.parse(quantity_list.value[o].text) *
                            int.parse(amount_list.value[o].text);
                      }
                      totalamount.value = am;
                    }
                  }
                },
                child: Text('save for later',
                    style: TextStyle(
                        color: Color.fromARGB(255, 6, 6, 6),
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
              ),
              InkWell(
                onTap: () async {
                  Navigator.pop(context);
                  Get.to(AllProducts());
                },
                child: Text(
                  '+ add more items',
                  style: TextStyle(
                      color: Color.fromARGB(255, 16, 15, 15),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

Widget promo(context) {
  return Stack(
    children: [
      Container(
        padding: EdgeInsets.all(26),
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage('assets/images/rect.png'))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Promo Code Here',
              style: TextStyle(
                  color: Color.fromARGB(255, 187, 246, 188),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              // margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: ColorConst.kGreenColor,
                  // border: Border.all(
                  //     color: ColorConst.kGreenColor, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              width: 27.w,
              height: 5.h,
              child: Text('Apply',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: ColorConst.whiteColor)),
            ),
          ],
        ),
      )
    ],
  );
}

Widget Add() {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Flexible(
        child: CustomRadio(
            title: "Full Pay", groupVal: groupVal, onChanged: (value) {})),
    Flexible(
        child: CustomRadio(
            title: "Full Pay", groupVal: groupVal, onChanged: (value) {})),
  ]);
}
