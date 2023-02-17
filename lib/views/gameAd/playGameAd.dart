import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../core/common/color.dart';
import '../../widget/items/items_list.dart';
import '../applovinmx/Widget/banner.dart';
import 'widget/gamesAdHorizontal.dart';
import '../../core/common/app_config.dart';
import 'widget/gamesAdVertical.dart';
import '../../controller/about_ctr.dart';
import '../../core/common/app_color.dart';
import '../../core/common/app_icon.dart';
import '../../model/social_media.dart';
import '../../route.dart';

class AdGameOnlineView extends GetView<AboutCtrl> {
  const AdGameOnlineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
            color: ColorChanged.tertiaryColor,
          ),
        ),
      ),
      //  bottomNavigationBar: getBanner(),
      // bottomNavigationBar:admobact==false? UnityAdsManager.bannerAd(bannerid):Container(width: 0,height: 0,),
      backgroundColor: AppColor.gameClr,
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
          "Play Games",
          style: TextStyle(
            //  color: Colors.white,
            color: ColorChanged.tertiaryColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            // fontFamily: AppFont.JollyGood
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBar: widgetBanner(),
      body: Container(
        width: ScreenUtil().screenWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppIcon.gameBgrd),
              fit: BoxFit.fill),
        ),
      //  physics: const BouncingScrollPhysics(),
        child: FutureBuilder<List<SocialMedia>>(
          future: controller.getSocialMedia(path: 'adGamesPlay'),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  print(snapshot.hasError);
                  return const Center(child: Text('Some error occurred!'));
                } else {
                  final moreApp = snapshot.data!;
                  bool isnan = false;
                  for (var element in moreApp) {
                    if ((element.active ?? false) == true) {
                      isnan = (element.active ?? false);
                    }
                  }
                  return isnan
                      ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Wrap(
                                  spacing: 45.w,
                                  runSpacing: 15.h,
                                  children: [
                                    for (int index = 0;
                                        index < moreApp.length;
                                        index++)
                                      moreApp[index].active!
                                          ? AppConfig.adGamesHr
                                              ? gamesAdHr(
                                                  name: moreApp[index].name!,
                                                  iconPath:
                                                      moreApp[index].iconPath!,
                                                  url: moreApp[index].url!,
                                                )
                                              : gamesAdVr(
                                                  name: moreApp[index].name!,
                                                  iconPath:
                                                      moreApp[index].iconPath!,
                                                  url: moreApp[index].url!,
                                                )
                                          : const SizedBox()
                                  ],
                                ),
                              ),
                              SizedBox(height: 60.h),
                            ],
                          ),
                        ),
                      )
                      : Container(
                        height: ScreenUtil().screenHeight,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppIcon.gameBgrd),
                                fit: BoxFit.cover),
                          ),
                          padding: const EdgeInsets.all(28.0),
                          child: Column(
                            children: [
                              emptyList(
                                  title: 'No Games Yet!',
                                  description:
                                      'We don\'t have Games now try later.',
                                  isClick: false),
                            ],
                          ));
                }
            }
          },
        ),
      ),
    ));
  }
}
