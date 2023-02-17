import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/common/app_color.dart';
import '../../core/common/app_style.dart';
import '../../core/common/color.dart';

Widget compareInfo({required String title}) {
  return Container(
    constraints: const BoxConstraints(
      maxHeight: double.infinity,
    ),
    decoration: AppStyle.listShadowDecoration,
    padding:
    const EdgeInsets.only(left: 20.0, bottom: 24, right: 20, top: 24),
    margin:  const EdgeInsets.symmetric(vertical: 5),
    width: ScreenUtil().screenWidth,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height:5.w,),
        const Padding(
          padding: EdgeInsets.only(bottom: 5),
          child:Icon(
            Icons.close_sharp,
            size: 80,
            color:Colors.red,
          ),
        ),
        SizedBox(height:20.h,),
        Text(
          title,
          style: const TextStyle(
            color:ColorChanged.primaryColor,
            fontWeight: FontWeight.w300,
            // fontFamily: AppFont.JollyGood,
            fontSize: 18,
          ),
        ),
        SizedBox(height:20.h,),
        Center(
          child: SizedBox(
            height: 45.h,
            width: ScreenUtil().screenWidth / 1.13,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(49.0),
                  side: const BorderSide(
                      color: ColorChanged.primaryColor, width: 1),
                ),
                primary: Colors.white,
              ),
              onPressed: () async {
                Get.back();
              },
              child: const Text(
                "Ok",
                style: TextStyle(
                  color: ColorChanged.primaryColor,
                  fontSize: 17,
                  // fontFamily: AppFont.JollyGood,
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}