import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/views/screens/service/view_service_page.dart';

import '../../../controllers/servie_controller.dart';
import '../home/home_page.dart';

class ServiceSearchPage extends StatefulWidget {
  const ServiceSearchPage({Key? key}) : super(key: key);

  @override
  State<ServiceSearchPage> createState() => _ServiceSearchPageState();
}

class _ServiceSearchPageState extends State<ServiceSearchPage> {
  final serviceController = Get.find<ServiceController>();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: PreferredSize(
      preferredSize: Size.fromHeight(75),
      child: AppBar(
          backgroundColor: ColorConst.kGreenColor,
          flexibleSpace: FlexibleSpaceBar(
            expandedTitleScale: 1.5,
            titlePadding: EdgeInsets.only(left: 55, top: 28, bottom: 14),
            title: SizedBox(
              width: 286,
              child: TypeAheadFormField(
                suggestionsCallback: (pattern) async {
                  serviceController.services.clear();
                  if (pattern.length > 1) {
                    await Future.delayed(Duration(milliseconds: 200), () async {
                      await serviceController.serviceSearchs(
                        value: pattern,
                      );
                    });
                  }
                  print('jjjjjj');
                  List finalList = [];
                  serviceController.services.forEach((element) {
                    print(element);
                    finalList.add(element.serviceName);

                    print(finalList);
                  });

                  return finalList;
                },
                onSuggestionSelected: (value) async {
                  final object = serviceController.services
                      .where((p0) => p0.serviceName == value)
                      .first;
                  await serviceController.serviceDetail(id: object.id);
                  final data = serviceController.servicedata.value;
                  Get.to(ViewServicePage(
                    id: data.id,
                    name: data.serviceName!,
                    service_price: data.servicePrice!,
                    description: data.description!,
                    imagepath: data.images!,
                  ));
                },
                itemBuilder: (BuildContext context, itemData) {
                  return ListTile(
                    title: Text(itemData),
                  );
                },
                textFieldConfiguration: TextFieldConfiguration(
                  // scrollPadding:
                  //     EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  style: textTheme.headlineMedium!
                      .copyWith(color: ColorConst.blackColor),
                  decoration: InputDecoration(
                    hintText: 'Type to Search',
                    filled: true,
                    fillColor: Color.fromARGB(255, 255, 250, 250),
                    // label: Text(hint),
                    prefixIcon: Icon(
                      Icons.search,
                      color: ColorConst.blackColor,
                    ),
                    // suffixIcon: DropdownButtonHideUnderline(
                    //   child: DropdownButton(
                    //     // hint: Text('hooseNumber'),
                    //     items: serviceController.serviceCategory.map((item) {
                    //       print(item['id']);
                    //       return DropdownMenuItem(
                    //         value: item['id'],
                    //         child: Text(item['category_name']),
                    //       );
                    //     }).toList(),
                    //     onChanged: (newVal) {
                    //       // setState(() {
                    //       //   dropdownvalue = newVal;
                    //       // });
                    //     },
                    //     // value: dropdownvalue,
                    //   ),
                    // ),

                    border: InputBorder.none,
                    // enabledBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.white),
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                    hintStyle: textTheme.headlineMedium
                        ?.copyWith(color: ColorConst.blackColor),
                    labelStyle: textTheme.headlineMedium!
                        .copyWith(color: ColorConst.blackColor),
                  ),
                  controller: searchController,
                  cursorColor: ColorConst.blackColor,
                ),
              ),
            ),
          )),
    ));
  }
}
