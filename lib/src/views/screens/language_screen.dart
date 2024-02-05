import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/src/views/widgets/checkbox/checkbox.dart';
import 'package:sizer/sizer.dart';

import 'auth/login_page.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;
  List<Map<String, dynamic>> languages = [
    {"id": 0, "value": true, "name": "English"},
    {"id": 1, "value": false, "name": "عربي"}
  ];
  setLanguage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 249, 234),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                _activePage = value;
              });
            },
            children: [
              screenWidget(context),
              screen1Widget(context),
              screen2Widget(context, languages, setLanguage)
            ],
          ),
          if (_activePage != 2)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 12.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorConst.kGreenColor),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor: _activePage == index
                            ? ColorConst.kGreenColor
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

screenWidget(context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return SizedBox(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: Stack(
      children: [
        const Image(
          image: AssetImage('assets/images/2_0.png'),
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Positioned(
          top: 530,
          child: SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: const Image(
              image: AssetImage('assets/images/curve.png'),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        Positioned(
          top: 600,
          child: Column(children: [
            Text(
              'Explore SA ',
              style: textTheme.displayMedium?.copyWith(
                  color: ColorConst.blackColor,
                  fontSize: 15.5.sp,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                'Saudi Arabia offers a diverse range of experiences for visitors to explore.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorConst.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
            ),
          ]),
        )
      ],
    ),
  );
}

screen1Widget(context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return SizedBox(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: Stack(
      children: [

      
        const Image(
          image: AssetImage('assets/images/3_0.png'),
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Positioned(
          top: 530,
          child: SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: const Image(
              image: AssetImage('assets/images/curve.png'),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        Positioned(
          top: 603,
          child: Container(
            padding: EdgeInsets.only(left: 2.w, right: 2.w),
            child: Column(children: [
              Text(
                'Kaka made is easier for you ',
                style: textTheme.displayMedium?.copyWith(
                    color: ColorConst.blackColor,
                    fontSize: 15.5.sp,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 9,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  'Our Application everything have you need in Saudi Arabia.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorConst.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'),
                ),
              ),
            ]),
          ),
        )
      ],
    ),
  );
}

screen2Widget(context, languages, setLanguage) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return Stack(
    children: [
      Container(
        color: ColorConst.kGreenColor,
      ),
      Column(
        children: [
          Expanded(
            child: ShaderMask(
              blendMode: BlendMode.srcATop,
              shaderCallback: (Rect bounds) {
                return ColorConst.gradient.createShader(bounds);
              },
              child: SvgPicture.asset(
                "assets/images/l3.svg",
                fit: BoxFit.cover,
                width: double.infinity,
                colorBlendMode: BlendMode.srcATop,
              ),
            ),
          ),
          Expanded(
            child: ShaderMask(
              blendMode: BlendMode.srcATop,
              shaderCallback: (Rect bounds) {
                return ColorConst.gradient.createShader(bounds);
              },
              child: SvgPicture.asset(
                "assets/images/l3.svg",
                fit: BoxFit.cover,
                width: double.infinity,
                colorBlendMode: BlendMode.srcATop,
              ),
            ),
          ),
        ],
      ),
      Center(
        child: SingleChildScrollView(
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 2,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFB4E8B6),
                      blurRadius: 20.0,
                      offset: Offset(0.0, 10.0),
                      spreadRadius: 3.0,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ),
                  ]),
              width: 100.w,
              child: Column(
                children: [
                  SizedBox(height: 2.5.h),
                  Text(
                    'Choose your language',
                    style: textTheme.displayMedium?.copyWith(
                      fontSize: 15.sp,
                      color: ColorConst.blackColor,
                    ),
                  ),
                  for (int i = 0; i < languages.length; i++)
                    CheckBox(
                      style: textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                          color: ColorConst.blackColor),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onChanged: (value) {
                        for (int i = 0; i < languages.length; i++) {
                          languages[i]["value"] = false;
                        }
                        languages[i]["value"] = value;
                        setLanguage();
                        debugPrint(value.toString());
                      },
                      title: languages[i]["name"],
                      value: languages[i]["value"],
                    ),
                  SizedBox(height: 3.5.h),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorConst.kGreenColor),
                      shadowColor: MaterialStateProperty.all<Color>(
                          ColorConst.kGreenColor),
                      elevation: MaterialStateProperty.all<double>(13.0),
                      padding:
                          MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                              (Set<MaterialState> states) {
                        return const EdgeInsets.fromLTRB(45, 10, 56, 10);
                      }),
                    ),
                    onPressed: () {
                   Get.offAll(LoginPage());
                    },
                    child: Text(
                      "Continue",
                      textAlign: TextAlign.center,
                      style: textTheme.displayMedium?.copyWith(
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  )
                ],
              ),
            ),
          ),
        ),
        // )
      ),
    ],
  );
}
