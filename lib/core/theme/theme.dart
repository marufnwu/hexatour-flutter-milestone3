import 'package:flutter/material.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

/// Defines app theme including text themes.
class ApplicationTheme {
  static ThemeData lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: ColorConst.kGreenColor,
    disabledColor: ColorConst.whiteColor,
    primarySwatch: ColorConst.primarySwatchColor,
    scaffoldBackgroundColor: ColorConst.whiteColor,
    colorScheme: const ColorScheme.light(),
    iconTheme: IconThemeData(color: ColorConst.whiteColor),

    appBarTheme: AppBarTheme(
        elevation: 0.5,
        titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: ColorConst.whiteColor),
        backgroundColor: ColorConst.whiteColor,
        iconTheme: IconThemeData(color: ColorConst.whiteColor, size: 3.5.h)),
   
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: ColorConst.blackColor,
        selectionColor: ColorConst.whiteColor),
    
    textTheme: TextTheme(

      displayLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: ColorConst.primaryTextColor),
     
      displayMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: ColorConst.primaryTextColor),
     
      displaySmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: ColorConst.primaryTextColor),
     
      headlineMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12.5.sp,
          fontWeight: FontWeight.w400,
          color: ColorConst.primaryTextColor),
      
      headlineSmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 11.sp,
          fontWeight: FontWeight.w300,
          color: ColorConst.primaryTextColor),
      titleLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 10.sp,
          fontWeight: FontWeight.w300,
          color: ColorConst.primaryTextColor),
      titleMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          color: ColorConst.textInputsubTitleColor),
      titleSmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 8.sp,
          fontWeight: FontWeight.w400,
          color: ColorConst.textInputsubTitleColor),
      bodyLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 11.sp,
          fontWeight: FontWeight.w400,
          color: ColorConst.blackColor),
      bodyMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 9.sp,
          fontWeight: FontWeight.w300,
          color: ColorConst.blackColor),
      labelLarge: TextStyle(
          fontFamily: 'Poppins',
          color: ColorConst.kGreenColor,
          fontSize: 12.sp),
    ),
  );
}
