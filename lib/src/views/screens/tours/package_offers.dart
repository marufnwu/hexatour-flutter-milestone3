import 'package:flutter/material.dart';
import 'package:hexatour/core/theme/colors.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConst.kGreenColor,
        title: Text('Available Offers'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: ColorConst.kGreenColor,
            image: DecorationImage(
              image: AssetImage("assets/images/appbar.png"),
            ),
          ),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: ((
            context,
            index,
          ) {
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
        ),
      ),
    );
  }
}
