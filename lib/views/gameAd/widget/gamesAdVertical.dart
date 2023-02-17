import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/common/app_color.dart';
import '../../../core/common/app_icon.dart';
import '../../../core/common/app_style.dart';
import '../../../core/common/color.dart';

Widget gamesAdVr(
    {required String iconPath,
      required String url,
      required String name}) {
  return GestureDetector(
    onTap: () async {
      await launchUrl(Uri.parse(url));
    },
    child: Container(
      decoration: AppStyle.listShadowDecoration,
      padding: const EdgeInsets.all(5.0),
      width: ScreenUtil().screenWidth/1.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
                height: ScreenUtil().screenHeight/7,
                width: ScreenUtil().screenWidth,
                imageUrl: url,
                placeholder: (context, url) => Container(
                  color: Color(0xfff5f8fd),
                ),
                fit: BoxFit.cover),
          ),
          SizedBox(height:1.5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    name,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: ColorChanged.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      //fontFamily: AppFont.JollyGood
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5.h),
              ElevatedButton(
                onPressed: () async {
                  await launchUrl(Uri.parse(url));
                },
                style: ElevatedButton.styleFrom(
                  primary: ColorChanged.primaryColor,
                  minimumSize: Size.zero, // Set this
                  padding: const EdgeInsets.all(3.0), // and this
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 4.0,top: 1),
                      child: Text(
                        "Play Now",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: ColorChanged.tertiaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          //fontFamily: AppFont.JollyGood
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      AppIcon.play,
                      width: 26,
                      height: 26,
                      color:ColorChanged.tertiaryColor,
                    ),
                  ],
                ),
              )

            ],
          ),
        ],
      ),
    ),
  );
}