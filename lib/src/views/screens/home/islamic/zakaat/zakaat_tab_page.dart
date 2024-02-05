import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/views/screens/home/islamic/zakaat/zakaat_tabbar_view/nafilah.dart';
import 'package:hexatour/src/views/screens/home/islamic/zakaat/zakaat_tabbar_view/wajibah.dart';
import 'package:hexatour/src/views/widgets/tabbar/tabs.dart';
import 'package:sizer/sizer.dart';

class ZakaatTabHomePage extends StatefulWidget {
  const ZakaatTabHomePage({super.key});

  @override
  State<ZakaatTabHomePage> createState() => _ZakaatTabHomePageState();
}

class _ZakaatTabHomePageState extends State<ZakaatTabHomePage>
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
          title: Text("Zakaat"),
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
                          child: Text("Wajibah"),
                        ),
                      ),
                      Tab(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text("Nafilah"),
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
        body: TabBarView(
          controller: tabController,
          children: [Wajibah(
            
          ), Nafilah()],
        ),
      ),
    );
  }
}
