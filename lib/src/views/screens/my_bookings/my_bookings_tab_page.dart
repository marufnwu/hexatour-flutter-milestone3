import 'package:flutter/material.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/views/screens/my_bookings/booking_tabbarview/cancelled_package.dart';
import 'package:hexatour/src/views/widgets/tabbar/tabs.dart';
import 'package:sizer/sizer.dart';
import 'booking_tabbarview/active_package.dart';
import 'booking_tabbarview/completed_package.dart';

class MyBookingsTabPage extends StatefulWidget {
  const MyBookingsTabPage({super.key});

  @override
  State<MyBookingsTabPage> createState() => _MyBookingsTabPageState();
}

class _MyBookingsTabPageState extends State<MyBookingsTabPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Booking"),
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
                      Tab(text: "Active Package"),
                      Tab(text: "Completed Package"),
                      Tab(text: "Cancelled Package"),
                    ],
                  ),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(5.h),
          ),
          actions: [
            IconButton(
                splashColor: Colors.transparent,
                onPressed: () {},
                icon: Icon(Icons.filter_alt_outlined, size: 25,),
                ),
          ],
        ),
        body: TabBarView(controller: tabController, children: [
          ActivePackageTabBarView(),
          CompletedPackageTabBarView(),
          CancelledPackageTabBarView(),
        ]),
      ),
    );
  }
}
