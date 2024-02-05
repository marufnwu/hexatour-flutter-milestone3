import 'package:flutter/material.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/views/screens/products/my_products/my_product_tabbar_view/active_product.dart';
import 'package:hexatour/src/views/screens/products/my_products/my_product_tabbar_view/cancelled_product.dart';
import 'package:hexatour/src/views/screens/products/my_products/my_product_tabbar_view/completed_product.dart';
import 'package:hexatour/src/views/widgets/tabbar/tabs.dart';
import 'package:sizer/sizer.dart';

class MyProductTabPage extends StatefulWidget {
  const MyProductTabPage({super.key});

  @override
  State<MyProductTabPage> createState() => _MyProductTabPageState();
}

class _MyProductTabPageState extends State<MyProductTabPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Products"),
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
                      Tab(text: "Active Product"),
                      Tab(text: "Completed Product"),
                      Tab(text: "Cancelled Product")
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
              icon: Icon(Icons.filter_alt_outlined),
            )
          ],
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            ActiveProductTabBarView(),
            CompletedProductTabBarView(),
            CancelledProductTabBarView()
          ],
        ),
      ),
    );
  }
}
