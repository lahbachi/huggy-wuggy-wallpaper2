import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/common/app_color.dart';
import '../../core/common/color.dart';

Widget menuItem({required String title, required String icon}) {
  return Container(
    margin:  const EdgeInsets.symmetric(vertical: 5),
    height: 50.h,
    width: ScreenUtil().screenWidth,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: ColorChanged.primaryColor,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width:25.w,),
       Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SvgPicture.asset(
            icon,
            width: 22,
            height: 22,
            color:ColorChanged.tertiaryColor,
          ),
        ),
        SizedBox(width:20.w,),
        Text(
          title,
          style: const TextStyle(
            color:ColorChanged.tertiaryColor,
            fontWeight: FontWeight.w500,
            // fontFamily: AppFont.JollyGood,
            fontSize: 20,
          ),
        ),
      ],
    ),
  );
}