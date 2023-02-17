import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/common/app_color.dart';
import '../../core/common/app_icon.dart';
import '../../core/common/color.dart';

Widget emptyList({required String title,required String description,required bool isClick}){
  return Padding(
    padding: const EdgeInsets.only(left:20,right: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20.h,),
        SvgPicture.asset(
          AppIcon.emptyData,
          color:ColorChanged.tertiaryColor,
        ),
        SizedBox(height: 25.h,),
        Text(
          title,
          style: const TextStyle(
              color:ColorChanged.tertiaryColor,
              fontSize: 23,
              fontWeight: FontWeight.w400,
              // fontFamily: AppFont.JollyGood
          ),
        ),
         SizedBox(height: 25.h,),
         Text(
           description ,  //'Once you favorite a wallpapers , you\'ll see them here.'
          style: const TextStyle(
              color:ColorChanged.tertiaryColor,
              fontSize: 19,
              // fontFamily: AppFont.JollyGood
          ),
           textAlign: TextAlign.center,
        ),
        // SizedBox(height: 35.h,),
        // isClick?  InkWell(
        //   onTap: () {
        //     Get.back();
        //   },
        //   child: Text(
        //     'Add $title',
        //     textAlign: TextAlign.center,
        //     style: const TextStyle(
        //         color: AppColor.primaryColor,
        //         fontSize: 19,
        //         fontFamily: AppFont.knicknack),
        //   ),
        // ):const SizedBox(),
      ],
    ),
  );
}