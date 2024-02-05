import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexatour/src/views/screens/tours/tour_page.dart';
import 'package:hexatour/src/views/screens/tours/widgets/tour_widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/utils/constant.dart';
import '../../../controllers/tour_controller.dart';
import '../../widgets/custom_container/no_data_found.dart';
import '../../widgets/loader/loader.dart';
import '../../widgets/tabbar/tabs.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final tourController = Get.find<TourController>();

class AllTour extends StatefulWidget {
  AllTour({Key? key});

  State<AllTour> createState() => _AllTourState();
}

class _AllTourState extends State<AllTour> with TickerProviderStateMixin {
  late TabController tabController;
  List<String> images = [
    "https://t4.ftcdn.net/jpg/02/40/98/49/360_F_240984942_eZXNlIqQ0SRIMyIZMOqVYG3kAmKqpCPJ.jpg",
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
    "https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?cs=srgb&dl=pexels-pixabay-268533.jpg&fm=jpg"
  ];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    tourController.tours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConst.kGreenColor,
        title: Text('Exclusive Packages'),
        centerTitle: true,
        automaticallyImplyLeading: true,
        bottom: PreferredSize(
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
                child: CustomTabs(
                  tabController: tabController,
                  tabs: [
                    Tab(text: "ISLAMIC"),
                    Tab(text: "ADVENTURE"),
                  ],
                ),
              ),
            ],
          ),
          preferredSize: Size.fromHeight(5.h),
        ),
      ),
      body: TabBarView(controller: tabController, children: [
        IslamicTours(),
        AdventureTours(),
      ]),
    );
  }
}

class IslamicTours extends StatefulWidget {
  const IslamicTours({super.key});

  @override
  State<IslamicTours> createState() => _IslamicToursState();
}

class _IslamicToursState extends State<IslamicTours> {
  @override
  void initState() {
    
    super.initState();
    getIslamicTour();
  }

  getIslamicTour() {
    tourController.filterTours(type: TourType.islamic);
  }

  Widget build(BuildContext context) {
    return Obx(() => tourController.islamicTourLoader.value
        ? Loader()
        : tourController.islamicTourPackage.isEmpty
            ? NoDataFound('No Data Found', context)
            : Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(2.h),
                    itemCount: tourController.islamicTourPackage.length,
                    itemBuilder: (context, index) {
                      return exclusivepackage(
                        onTap: () async {
                          bool res = await tourController.tourdetail(
                              id: tourController.islamicTourPackage[index].id);
                          if (res) {
                            Get.to(TourdetailPage(
                                price: tourController.tourDetails.value.price
                                    .toString(),
                                no_of_person: tourController
                                    .tourDetails.value.noOfPerson
                                    .toString(),
                                description: tourController
                                    .tourDetails.value.description!,
                                id: tourController.tourDetails.value.id!,
                                imagepath:
                                    tourController.tourDetails.value.images!,
                                tourname:
                                    tourController.tourDetails.value.tourname!,
                                minimumBookingAmount: tourController
                                    .tourDetails.value.minimumBookingAmount
                                    .toString(),
                                duration: tourController
                                    .tourDetails.value.duration!));
                          }
                        },
                        context: context,
                        name: tourController.islamicTourPackage[index].tourname,
                        imagepath:
                            tourController.islamicTourPackage[index].images[0],
                      );

                      //
                    }),
              ));
  }
}

class AdventureTours extends StatefulWidget {
  const AdventureTours({super.key});

  @override
  State<AdventureTours> createState() => _AdventureToursState();
}

class _AdventureToursState extends State<AdventureTours> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int page = 1;

  @override
  void initState() {
    
    super.initState();
    getAdventureTour();
  }

  getAdventureTour() {
    tourController.filterTours(type: TourType.adventure, page: page);
  }

  void _onLoading() async {
    // page++;
    // await getAdventureTour();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => tourController.adventureTourLoader.value
        ? Loader()
        : tourController.adventureTourPackage.isEmpty
            ? NoDataFound('No Data Found', context)
            : Container(
                child: SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: false,
                  onLoading: _onLoading,
                  enablePullUp: true,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(2.h),
                      itemCount: tourController.adventureTourPackage.length,
                      itemBuilder: (context, index) {
                        return exclusivepackage(
                          onTap: () async {
                            bool res = await tourController.tourdetail(
                                id: tourController
                                    .adventureTourPackage[index].id);
                            if (res) {
                              Get.to(TourdetailPage(
                                  price: tourController.tourDetails.value.price
                                      .toString(),
                                  no_of_person: tourController
                                      .tourDetails.value.noOfPerson
                                      .toString(),
                                  description: tourController
                                      .tourDetails.value.description!,
                                  id: tourController.tourDetails.value.id!,
                                  imagepath:
                                      tourController.tourDetails.value.images!,
                                  tourname: tourController
                                      .tourDetails.value.tourname!,
                                  minimumBookingAmount: tourController
                                      .tourDetails.value.minimumBookingAmount
                                      .toString(),
                                  duration: tourController
                                      .tourDetails.value.duration!));
                            }
                          },
                          context: context,
                          name: tourController
                              .adventureTourPackage[index].tourname,
                          imagepath: tourController
                              .adventureTourPackage[index].images[0],
                        );

                        //
                      }),
                ),
              ));
  }
}
