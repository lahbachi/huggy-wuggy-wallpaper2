import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/about_ctr.dart';
import '../core/common/app_color.dart';
import '../core/common/app_const.dart';
import '../core/common/app_style.dart';
import '../core/common/app_url.dart';
import '../core/common/color.dart';
import '../core/common/url_changed.dart';

Widget popupMessage({required String title, required String description}) {
  final AboutCtrl aboutCtrl = Get.find<AboutCtrl>();
  return Container(
      constraints: const BoxConstraints(
        maxHeight: double.infinity,
      ),
      decoration: AppStyle.listShadowDecoration,
      padding:
          const EdgeInsets.only(left: 20.0, bottom: 24, right: 20, top: 24),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            title.isNotEmpty
                ? Text(
                    title,
                    style: const TextStyle(
                      fontSize: 21,
                      // fontFamily: AppFont.JollyGood,
                    ),
                  )
                : const SizedBox(),
            SizedBox(
              height: 14.h,
            ),
            description.isNotEmpty
                ? InkWell(
                    onTap: () {
                      aboutCtrl.launchUrl(AppChanged.pPolicyUrl);
                    },
                    child: Text(
                      description,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                        fontSize: 17,
                        // fontFamily: AppFont.JollyGood,
                      ),
                    ))
                : const SizedBox(),
            SizedBox(
              height: 37.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
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
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setBool(AppConst.agree, true);

                        Get.back();
                      },
                      child: const Text(
                        "I agree",
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
            )
          ]));
}
