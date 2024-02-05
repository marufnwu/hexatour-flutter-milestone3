import 'package:flutter/material.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

import '../../../models/product/product_model.dart';

// ignore: must_be_immutable
class RecentProducts extends StatefulWidget {
  List<String> images = [
    "https://t4.ftcdn.net/jpg/02/40/98/49/360_F_240984942_eZXNlIqQ0SRIMyIZMOqVYG3kAmKqpCPJ.jpg",
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
    "https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?cs=srgb&dl=pexels-pixabay-268533.jpg&fm=jpg"
  ];
  RecentProducts({
    Key? key,
    required this.indexx,
    required this.context,
    required this.imagepath,
    required this.productName,
    required this.description,
    required this.price,
    required this.id,
    required this.availability,
  }) : super(key: key);

  final BuildContext context;
  final ProductImage imagepath;
  final String description;
  final String productName;
  final int price;
  final String id;
  final String availability;
  final indexx;
  @override
  State<RecentProducts> createState() => _RecentProductsState();
}

class _RecentProductsState extends State<RecentProducts> {
  @override
//

  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: (() {
            // Get.to(ViewProductPage(
            //   id:widget.id,
            //     productName: widget.productName,
            //     availability:  widget.availability,
            //     description: widget.description,
            //     price: widget.price.toString(),
            //     imagepath:  widget.imagepath,
            //    ));
          }),
          child: Container(
            height: 15.h,
            width: 37.w,
            margin: EdgeInsets.only( top: 2.h, ),
            // padding: EdgeInsets.only(bottom: 1.2.h, left: 1.w, right: 1.w),
            decoration: BoxDecoration(
              color: ColorConst.blueColor,
                boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 231, 227, 227),
                  spreadRadius: 2,
                  offset: Offset(1, 3),
                  blurRadius: 3.0)
            ],
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                  image: NetworkImage(
                      'https://nodejs.hackerkernel.com/hexatour/public${widget.imagepath.imagepath}'),
                  fit: BoxFit.fill),
            ),
           
          ),
        ),
        SizedBox(height: 2.h,),

Align(
              alignment: Alignment.center,
              child: Text(
                widget.productName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.displaySmall?.copyWith(fontSize: 11.sp, color: ColorConst.blackColor),
              ),
            ),
          
        
      ],
    );
  }
}
