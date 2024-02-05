import 'package:flutter/material.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/views/screens/home/islamic/charity/fruits_dates.dart';
import 'package:hexatour/src/views/screens/home/islamic/charity/meals.dart';
import 'package:hexatour/src/views/widgets/tabbar/tabs.dart';
import 'package:sizer/sizer.dart';

class CharityTabHomePage extends StatefulWidget {
  final String? id;

  final String? description;

  CharityTabHomePage({
    Key? key,
    required this.id,

    // required this.imagepath,
    this.description,

    //  this.price,
  }) : super(key: key);
  @override
  State<CharityTabHomePage> createState() => _CharityTabHomePageState();
}

class _CharityTabHomePageState extends State<CharityTabHomePage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Charity"),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: ColorConst.kGreenColor,
              image: DecorationImage(
                image: AssetImage("assets/images/appbar.png"),
              ),
            ),
          ),
          bottom: PreferredSize(
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                  child: CustomTabs(
                    tabController: tabController,
                    tabs: [
                      Tab(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text("Meals"),
                        ),
                      ),
                      Tab(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text("Fruits Dates And Juices"),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(5.h),
          ),
        ),
        body: TabBarView(controller: tabController, children: [
          MealsPage(
            id: widget.id,
            description: widget.description,
          ),
          FruitDatesPage(
            id: widget.id,
            description: widget.description,
          )
        ]),
      ),
    );
  }
}
