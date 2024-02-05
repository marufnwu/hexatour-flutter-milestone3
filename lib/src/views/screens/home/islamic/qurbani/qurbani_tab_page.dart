import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:get/get.dart';
import 'package:hexatour/src/controllers/islamic_controller.dart';
import 'package:hexatour/src/views/screens/home/islamic/qurbani/qurbani_tabbar_view/camel.dart';
import 'package:hexatour/src/views/screens/home/islamic/qurbani/qurbani_tabbar_view/goats.dart';
import 'package:hexatour/src/views/widgets/tabbar/tabs.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/theme/colors.dart';
import 'qurbani_tabbar_view/cow.dart';

class QurbaniTabPage extends StatefulWidget {
  final String? id;
  final String? qurbaniType;
  final String? description;
  final int? index;

  QurbaniTabPage({
    Key? key,
    required this.id,
    this.qurbaniType,
    // required this.imagepath,
    this.description,
    required this.index,

    //  this.price,
  }) : super(key: key);

  @override
  State<QurbaniTabPage> createState() => _QurbaniTabPageState();
}

class _QurbaniTabPageState extends State<QurbaniTabPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  final islamicController = Get.find<IslamicController>();

  @override
  void initState() {
    tabController = TabController(
      length: 3,
      vsync: this,
    );

    super.initState();
    print(widget.index);
    print('whatss happening');

    if (widget.qurbaniType == 'goat') {
      tabController.animateTo(1, duration: Duration(microseconds: 5));
    } else if (widget.qurbaniType == 'camel') {
      tabController.animateTo(2, duration: Duration(microseconds: 5));
    } else {
      tabController.animateTo(0, duration: Duration(microseconds: 5));
    }

    // islamicController.qurbaniType(widget.qurbaniType);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Qurbani"),
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
                          child: Text("Cow"),
                        ),
                      ),
                      Tab(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text("Goat"),
                        ),
                      ),
                      Tab(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text("Camel"),
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
          children: [
            Cow(
              qurbaniType: widget.qurbaniType,
              id: widget.id,
              description: widget.description,
            ),
            Goats(
              qurbaniType: widget.qurbaniType,
              id: widget.id,
              description: widget.description,
            ),
            Camel(
              qurbaniType: widget.qurbaniType,
              id: widget.id,
              description: widget.description,
            )
          ],
        ),
      ),
    );
  }
}
