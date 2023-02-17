import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/about_ctr.dart';
import '../../core/common/app_color.dart';
import '../../core/common/app_style.dart';
import '../../core/common/color.dart';
import '../../model/social_media.dart';
import 'widget/sponsoreAd.dart';

class SponsoredAdsView extends GetView<AboutCtrl> {
  const SponsoredAdsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: FutureBuilder<List<SocialMedia>>(
          future: controller.getSocialMedia(path: 'adGamesPlay'),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return const SizedBox();
                } else {
                  final moreApp = snapshot.data!;
                  bool isnan = false;
                  for (var element in moreApp) {
                    print("element ---------------------");
                    if ((element.active ?? false) == true) {
                      isnan = (element.active ?? false);
                    }
                  }
                  return isnan
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: AppStyle.listShadowDecoration.copyWith(
                            color: ColorChanged.tertiaryColor.withOpacity(0.75),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    "Sponsored",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.45),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      //fontFamily: AppFont.JollyGood
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Wrap(
                                  spacing: 13,
                                  runSpacing: 19,
                                  children: [
                                    for (int index = 0;
                                        index < moreApp.length;
                                        index++)
                                      moreApp[index].active!
                                          ? sponsoredAds(
                                              name: moreApp[index].name!,
                                              iconPath: moreApp[index].iconPath!,
                                              url: moreApp[index].url!,
                                            )
                                          : const SizedBox()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox();
                }
            }
          },
        ),
      ),
    );
  }
}
