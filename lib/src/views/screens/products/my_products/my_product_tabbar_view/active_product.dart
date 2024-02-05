import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/utils/constant.dart';
import 'package:hexatour/src/views/widgets/custom_container/my_product.dart';
import 'package:sizer/sizer.dart';

import '../../../../../controllers/product_controller.dart';

class ActiveProductTabBarView extends StatefulWidget {
  const ActiveProductTabBarView({Key? key}) : super(key: key);

  @override
  State<ActiveProductTabBarView> createState() => _ActiveProductTabBarViewState();
}

class _ActiveProductTabBarViewState extends State<ActiveProductTabBarView> {

  final productController = Get.find<ProductController>();

  RxBool loading = true.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100),(){
      getdata();
    });
  }

  getdata()async{
    var a = await productController.productBookings(value: '1');
    if(a == true){
      loading.value = false;
      // loading.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> productData = [
      {
        "name": "Contribute For The Make Somalians Happy",
        "image":
            "https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png",
        "description":
            "We’re focused on providing affordable volunteer travel experiences that are responsible. We’ve been tackling poverty in communities to build better lives",
        "amount": "\$5000"
      },
      {
        "name": "Sulaiman Al Rajhi",
        "image":
            "https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png",
        "description":
            "We’re focused on providing affordable volunteer travel experiences that are responsible. We’ve been tackling poverty in communities to build better lives",
        "amount": "\$6000"
      },
      {
        "name": "Sulaiman Al Rajhi",
        "image": "https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png",
        "description": "We’re focused on providing affordable volunteer travel experiences that are responsible. We’ve been tackling poverty in communities to build better lives",
        "amount": "\$7000"
      },
      {
        "name": "Sulaiman Al Rajhi",
        "image":
            "https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png",
        "description":
            "We’re focused on providing affordable volunteer travel experiences that are responsible. We’ve been tackling poverty in communities to build better lives",
        "amount": "\$5000"
      },
      {
        "name": "Sulaiman Al Rajhi",
        "image":
            "https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png",
        "description":
            "We’re focused on providing affordable volunteer travel experiences that are responsible. We’ve been tackling poverty in communities to build better lives",
        "amount": "\$10000"
      },
      {
        "name": "Sulaiman Al Rajhi",
        "image":
            "https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png",
        "description":
            "We’re focused on providing affordable volunteer travel experiences that are responsible. We’ve been tackling poverty in communities to build better lives",
        "amount": "\$10000"
      },
      {
        "name": "Sulaiman Al Rajhi",
        "image":
            "https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png",
        "description":
            "We’re focused on providing affordable volunteer travel experiences that are responsible. We’ve been tackling poverty in communities to build better lives",
        "amount": "\$10000"
      },
      {
        "name": "Sulaiman Al Rajhi",
        "image":
            "https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png",
        "description":
            "We’re focused on providing affordable volunteer travel experiences that are responsible. We’ve been tackling poverty in communities to build better lives",
        "amount": "\$10000"
      },
      {
        "name": "Sulaiman Al Rajhi",
        "image":
            "https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png",
        "description":
            "We’re focused on providing affordable volunteer travel experiences that are responsible. We’ve been tackling poverty in communities to build better lives",
        "amount": "\$10000"
      },
      {
        "name": "Sulaiman Al Rajhi",
        "image":
            "https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png",
        "description":
            "We’re focused on providing affordable volunteer travel experiences that are responsible. We’ve been tackling poverty in communities to build better lives",
        "amount": "\$10000"
      },
      {
        "name": "Sulaiman Al Rajhi",
        "image":
            "https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png",
        "description":
            "We’re focused on providing affordable volunteer travel experiences that are responsible. We’ve been tackling poverty in communities to build better lives",
        "amount": "\$10000"
      },
    ];

    return Obx(
        ()=> Stack(
        children: [
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(1.5.h),
              itemCount: productController.myProducts.length,
              itemBuilder: (context, index) {
                print(productController.myProducts.value[index].images[0].imagepath);
                print('imageeee');
                return MyProductContainer(
                  quantity: productController.myProducts.value[index].quantity!,
                  name: productController.myProducts.value[index].name!,
                  image: productController.myProducts.value[index].images[0].imagepath,
                  amount: '\u20b9 '+productController.myProducts.value[index].price.toString(),
                  btn1name: "Order on the way",
                  btn1OnTap: () {},
                  btn2name: "Cancel Order",
                  btn2OnTap: () {},
                );
              }),
          if(loading.value == true)MyLoader(),
          if(productController.myProducts.isEmpty)Center(child: Text('0 Active Products.'),)
        ],
      ),
    );
  }
}
