import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/models/tour/Tour_model.dart';
import 'package:hexatour/src/views/screens/tours/tour_page.dart';

import '../../../controllers/tour_controller.dart';

class TourPackage extends StatefulWidget {
  TourPackage({
    Key? key,
    required this.id,
    required this.description,
    required this.imagepath,
    required this.tourname,
    required this.duration,
    required this.no_of_person,
    required this.price,
  }) : super(key: key);

  final TourImage imagepath;
  final String tourname;
  final String duration;
  final String description;
  final String no_of_person;
  final int id;
  final String price;

  @override
  State<TourPackage> createState() => _TourPackageState();
}

class _TourPackageState extends State<TourPackage> {
  TourController tourController = Get.find<TourController>();
  List<String> images = [
    "https://t4.ftcdn.net/jpg/02/40/98/49/360_F_240984942_eZXNlIqQ0SRIMyIZMOqVYG3kAmKqpCPJ.jpg",
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
    "https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?cs=srgb&dl=pexels-pixabay-268533.jpg&fm=jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(3),
        margin: EdgeInsets.all(8),
        width: 180,
        child: InkWell(
          onTap: () async {
            bool res = await tourController.tourdetail(id: widget.id);
            print('idofindex');
            print(widget.id);
            if (res)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => TourdetailPage(
                      price: tourController.tourDetails.value.price.toString(),
                      no_of_person: tourController.tourDetails.value.noOfPerson
                          .toString(),
                      description:
                          tourController.tourDetails.value.description!,
                      id: tourController.tourDetails.value.id!,
                     
                      imagepath: tourController.tourDetails.value.images!,
                      tourname: tourController.tourDetails.value.tourname!,
                      minimumBookingAmount: tourController
                          .tourDetails.value.minimumBookingAmount
                          .toString(),
                      duration: tourController.tourDetails.value.duration!)),
                ),
              );
          },
          //
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://nodejs.hackerkernel.com/hexatour/public${widget.imagepath.imagepath}'),
                fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 231, 227, 227),
                  spreadRadius: 2,
                  offset: Offset(1, 3),
                  blurRadius: 3.0)
            ],
            color: ColorConst.whiteColor,
            borderRadius: BorderRadius.circular(9)));
  }
}
