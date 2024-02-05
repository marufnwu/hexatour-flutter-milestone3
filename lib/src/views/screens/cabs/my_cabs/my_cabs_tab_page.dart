import 'package:flutter/material.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/views/screens/cabs/my_cabs/my_cabs_tabbar_view/active_cab.dart';
import 'package:hexatour/src/views/screens/cabs/my_cabs/my_cabs_tabbar_view/cancelled_cab.dart';
import 'package:hexatour/src/views/screens/cabs/my_cabs/my_cabs_tabbar_view/completed_cab.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/tabbar/tabs.dart';

class MyCabTabPage extends StatefulWidget {
  const MyCabTabPage({super.key});

  @override
  State<MyCabTabPage> createState() => _MyCabTabPageState();
}

class _MyCabTabPageState extends State<MyCabTabPage>
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
          title: Text("Cabs"),
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
                      Tab(text: "Active Cab"),
                      Tab(text: "Completed Cab"),
                      Tab(text: "Cancelled Cab")
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
                icon: Icon(Icons.filter_alt_outlined))
          ],
        ),
        body: TabBarView(controller: tabController, children: [
          ActiveCabTabBarView(),
          CompletedCabTabBarView(),
          CancelledCabTabBarView()
        ]),
      ),
    );
  }
}
