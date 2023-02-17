import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/common/app_const.dart';
import '../../ads/fan/fan.dart';
import '../../core/common/app_color.dart';
import '../../core/common/app_icon.dart';
import '../../core/common/app_url.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/common/app_config.dart';
import '../../core/common/color.dart';
import '../../route.dart';
import '../../widget/message_result/message_bar.dart';

class ShareAppView extends StatefulWidget {
  const ShareAppView({Key? key}) : super(key: key);

  @override
  State<ShareAppView> createState() => _RateAppViewState();
}

class _RateAppViewState extends State<ShareAppView> {
  //final AddToFavourite _addToFavourite = Get.find<AddToFavourite>();
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
                color: ColorChanged.tertiaryColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: ColorChanged.primaryColor,
            title: const Text(
              'refer a friend',
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "let us know how we're doing please rate your experience using ${AppConfig.appName} wallpaper.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.greyLight,
                      fontSize: 22,
                      // fontFamily: AppFont.JollyGood
                  ),
                ),
              ),
              Image.asset(
                AppIcon.shareApp,
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenHeight / 4.1,
                fit: BoxFit.contain,
              ),
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color:  ColorChanged.tertiaryColor,
                    width: 2.0,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(
                          5.0) //                 <--- border radius here
                      ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "https://play.google.com/store...",
                          style: TextStyle(
                              color:  ColorChanged.tertiaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              // fontFamily: AppFont.JollyGood
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: const Color.fromRGBO(232, 246, 203, 1),
                          backgroundColor: ColorChanged.primaryColor,
                          onSurface: Colors.grey,
                        ),
                        onPressed: () {
                          var link =
                              '${AppUrls.playStore}${AppConfig.appPackageName}';
                          Clipboard.setData(ClipboardData(text: link))
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                createSnackBar(
                                    message: "Copied: $link",
                                    bgColors: ColorChanged.primaryColor,
                                    txtColors: Colors.white,
                                    second: 2));
                          });
                        },
                        child: const Text(
                          'Copy',
                          style: TextStyle(
                              color:  ColorChanged.tertiaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              // fontFamily: AppFont.JollyGood
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                  height: 40.h,
                  width: 95.w,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: const Color.fromRGBO(232, 246, 203, 1),
                      backgroundColor: ColorChanged.primaryColor,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      //Todo:fix text
                      Share.share('${AppConst.shareMsg} ${AppUrls.playStore}${AppConfig.appPackageName}');
                    },
                    child: SvgPicture.asset(
                      AppIcon.partager,
                      color:  ColorChanged.tertiaryColor,
                    ),
                  ))
            ],
          )),
    );
  }
}
