import 'package:flutter/material.dart';
import 'package:hexatour/core/theme/colors.dart';

class CustomTabs extends StatelessWidget {
  final List<Widget> tabs;
  final Function(dynamic)? onTap;
  final TabController tabController;

  const CustomTabs(
      {required this.tabs, this.onTap, required this.tabController, super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return TabBar(
        indicatorColor: ColorConst.whiteColor,
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 3,
        isScrollable: true,
        labelStyle: theme.displaySmall,
        unselectedLabelStyle: theme.displaySmall,
        labelColor: ColorConst.whiteColor,
        unselectedLabelColor: Color(0xff6FC26F),
        tabs: tabs);
  }
}
