import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/common/app_color.dart';
import '../../../core/common/app_icon.dart';
import '../../../core/common/app_style.dart';
import '../../../core/common/color.dart';

Widget gamesAdHr(
    {required String iconPath,
    required String url,
    required String name}) {
  return GestureDetector(
    onTap: () async {
      await launchUrl(Uri.parse(url));
    },
    child: Container(
      height: 100.h,
      decoration: AppStyle.listShadowDecoration.copyWith(),
      padding: const EdgeInsets.all(5.0),
      width: ScreenUtil().screenWidth / 1.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
                height: 110.w,
                width: 105.w,
                imageUrl: url,
                placeholder: (context, url) => Container(
                      color: Color(0xfff5f8fd),
                    ),
                fit: BoxFit.cover),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: ColorChanged.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    //fontFamily: AppFont.JollyGood
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () async {
                          await launchUrl(Uri.parse(url));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: ColorChanged.primaryColor,
                          minimumSize: Size.zero, // Set this
                          padding: const EdgeInsets.all(2.0), // and this
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // <-- Radius
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2.0),
                              child: SvgPicture.asset(
                                AppIcon.play,
                                width: 26,
                                height: 26,
                                color: ColorChanged.tertiaryColor,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 2.0,
                              ),
                              child: Text(
                                "Play Now",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorChanged.tertiaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  //fontFamily: AppFont.JollyGood
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
