import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_color.dart';
import 'color.dart';
class AppStyle {
  static BoxDecoration listShadowDecoration = BoxDecoration(

      boxShadow: [
        BoxShadow(
          color:Colors.black.withOpacity(0.07),
          spreadRadius: 0,
          blurRadius: 40,
          offset: const Offset(0, 10), // changes position of shadow
        ),
      ],
      color:ColorChanged.tertiaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)));

  static InputDecoration inputDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
      // borderSide: const BorderSide(color: AppColor.green2),
      borderRadius: BorderRadius.circular(100),
    ),
    // focusedBorder: OutlineInputBorder(
    //   borderSide: BorderSide(
    //       color: Colors.blue, width: 3.0),
    // ),
    fillColor: Colors.white,
    filled: true,
    contentPadding: EdgeInsets.all(16.h),
    labelStyle: TextStyle(
      fontSize: 15.sp,
    ),
    hintStyle: TextStyle(
        color: AppColor.blue1,
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
       // fontFamily: AppFont.JollyGood
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(100),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(100),
    ),
    // enabledBorder: UnderlineInputBorder(
    //   borderSide: const BorderSide(color: Colors.white),
    //   borderRadius: BorderRadius.circular(100),
    // ),
    errorBorder: UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(100),
    ),
  );
  static ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: AppColor.pypColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0.h)),

    backgroundColor: AppColor.pypColor,
  );
  // Text style
  static TextStyle textMedium15 =
      TextStyle(    fontWeight: FontWeight.w400,
          //fontFamily: AppFont.JollyGood,
          fontSize: 15.0.sp);
}
