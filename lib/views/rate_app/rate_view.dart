import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../ads/fan/fan.dart';
import '../../controller/favourite_ctr.dart';
import '../../core/common/app_color.dart';
import '../../core/common/app_icon.dart';
import '../../core/common/app_config.dart';
import '../../core/common/color.dart';
import '../../route.dart';

class RateAppView extends StatefulWidget {
  const RateAppView({Key? key}) : super(key: key);

  @override
  State<RateAppView> createState() => _RateAppViewState();
}

class _RateAppViewState extends State<RateAppView> {
  final AddToFavourite _addToFavourite = Get.find<AddToFavourite>();
  FANManager fANManager = FANManager();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorChanged.secondaryColor,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: FloatingActionButton(
              elevation: 0.0,
              backgroundColor: ColorChanged.primaryColor,
              onPressed: () {
                Navigator.pushNamed(context, NavigatorRoutes.homePage);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.w),
              ),
              child: const Icon(
                Icons.home,
                size: 30,
                color:  ColorChanged.tertiaryColor,
              ),
            ),
          ),
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
            ),
            leading: IconButton(
              icon: SvgPicture.asset(
                AppIcon.back,
                width: 35.w,
                height: 35.w,
                color:  ColorChanged.tertiaryColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: ColorChanged.primaryColor,
            title: const Text(
              'Rate Us',
              style: TextStyle(
                  color:  ColorChanged.tertiaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  // fontFamily: AppFont.JollyGood
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Rate Our App",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorChanged.primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    // fontFamily: AppFont.JollyGood
                ),
              ),
               Text(
                "let us know how we're diong \n please rate your experience using \n ${AppConfig.appName} wallpaper.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColor.greyLight,
                    fontSize: 25,
                    // fontFamily: AppFont.JollyGood
                ),
              ),
              Center(
                  child: RatingBar.builder(
                initialRating: 4,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                glowColor: Colors.amber,
                unratedColor: AppColor.grey,
                itemSize: 40,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0.h),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                  _addToFavourite.rating.value = rating;
                },
              )),
              SizedBox(
                  height: 40.h,
                  width: 120.w,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: const Color.fromRGBO(232, 246, 203, 1),
                      backgroundColor: ColorChanged.primaryColor,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      if (_addToFavourite.rating.value > 2) {
                        print("rate : ${_addToFavourite.rating.value}");
                        _addToFavourite.rateUs();
                      } else {
                        print("rate 2: ${_addToFavourite.rating.value}");
                      }
                    },
                    child: const Text(
                      'submit',
                      style: TextStyle(
                          color:  ColorChanged.tertiaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          // fontFamily: AppFont.JollyGood
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}
