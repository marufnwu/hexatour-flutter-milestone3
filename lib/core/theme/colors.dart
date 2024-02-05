import 'package:flutter/material.dart';

class ColorConst {
  static const mainColor = const Color(0xffFFDC5C);
  static const darkBlue = const Color(0xff0701BF);
  static const greyColor = const Color(0xff949494);
  static const lightYellow = const Color(0xffF1B142);
  static const redColor = Colors.red;
  static const transparentColor = Colors.transparent;
  static const greenColor = Color.fromARGB(255, 151, 204, 152);
  static const blueColor = Colors.blue;
  static const blackColor = Colors.black;
  static const primaryTextColor = const Color(0xffFFFFFF);
  static const textInputsubTitleColor = const Color(0xff7C7979);
  static const whiteShadow = Color(0xffF4F6F8);

  static const whiteColor = Colors.white;
  static MaterialColor primarySwatchColor = MaterialColor(0xFF00B598, color);

  static const notificationRead = const LinearGradient(colors: [
    Color.fromARGB(255, 248, 237, 143),
    Color.fromARGB(255, 226, 222, 189),
  ]);

  static const notificationUnRead = const LinearGradient(colors: [
    Color(0xffFFDC5C),
    Color.fromARGB(255, 248, 237, 143),
  ]);

  static const kSecondaryColor = Color(0xFF8B94BC);
  static const kGreenColor = Color.fromARGB(255, 158, 231, 159);
  static const kRedColor = Color(0xFFE92E30);
  static const kGrayColor = Color(0xFFC1C1C1);
  static const kBlackColor = Color(0xFF101010);
  static const kPrimaryGradient = LinearGradient(
    colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const double kDefaultPadding = 20.0;

  static const gradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.0041, 1.0795],
    colors: [Color(0xFFEAF2EB), Color(0xFF90EE90)],
    transform:
        GradientRotation(313.71 * 3.14159 / 180), // Convert degrees to radians
  );
}

Map<int, Color> color = {
  50: const Color.fromRGBO(0, 137, 123, 0.1),
  100: const Color.fromRGBO(0, 137, 123, 0.2),
  200: const Color.fromRGBO(0, 137, 123, 0.3),
  300: const Color.fromRGBO(0, 137, 123, 0.4),
  400: const Color.fromRGBO(0, 137, 123, 0.5),
  500: const Color.fromRGBO(0, 137, 123, 0.6),
  600: const Color.fromRGBO(0, 137, 123, 0.7),
  700: const Color.fromRGBO(0, 137, 123, 0.8),
  800: const Color.fromRGBO(0, 137, 123, 0.9),
  900: const Color.fromRGBO(0, 137, 123, 1),
};
