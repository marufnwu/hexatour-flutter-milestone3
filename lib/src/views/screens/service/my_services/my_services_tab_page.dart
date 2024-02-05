import 'package:flutter/material.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/views/screens/service/my_services/my_services_tabbar_view/active_services.dart';
import 'package:hexatour/src/views/widgets/tabbar/tabs.dart';
import 'package:sizer/sizer.dart';

import 'my_services_tabbar_view/cancelled_services.dart';
import 'my_services_tabbar_view/completed_services.dart';

class MyServiceTabPage extends StatefulWidget {
  const MyServiceTabPage({super.key});

  @override
  State<MyServiceTabPage> createState() => _MyServiceTabPageState();
}

class _MyServiceTabPageState extends State<MyServiceTabPage>
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
          title: Text("My Services"),
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
                      Tab(text: "Active Service"),
                      Tab(text: "Completed Service"),
                      Tab(text: "Cancelled Service")
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
          ActiveServiceTabBarView(),
          CompletedServiceTabBarView(),
          CancelledServiceTabBarView()
        ]),
      ),
    );
  }
}
