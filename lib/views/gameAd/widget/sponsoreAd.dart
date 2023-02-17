import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/common/app_color.dart';
import '../../../core/common/color.dart';

Widget sponsoredAds(
    {required String iconPath,
      required String url,
      required String name}) {
  return GestureDetector(
    onTap: () async {
      await launchUrl(Uri.parse(url));
    },
    child: SizedBox(
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
                height: 50,
                width: 50,
                imageUrl: url,
                placeholder: (context, url) => Container(
                  color: Color(0xfff5f8fd),
                ),
                fit: BoxFit.cover),
          ),
          SizedBox(height:3.h),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ColorChanged.primaryColor,
              fontSize: 10,
              fontWeight: FontWeight.w500,
              //fontFamily: AppFont.JollyGood
            ),
          ),
        ],
      ),
    ),
  );
}