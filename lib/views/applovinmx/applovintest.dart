import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controller/applovin_ctr.dart';
import '../../core/common/app_color.dart';
import '../../core/common/app_icon.dart';
import '../../core/common/color.dart';
import '../../route.dart';

class ApplovinView extends GetView<AdsApplovinCtrl> {
  const ApplovinView({Key? key}) : super(key: key);

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
          child: Icon(
            Icons.home,
            size: 28.w,
            color: ColorChanged.tertiaryColor,
          ),
        ),
      ),
      bottomNavigationBar: GetBuilder<AdsApplovinCtrl>(
          builder: (aplController) => controller.bannerShowing()),
      // bottomNavigationBar:admobact==false? UnityAdsManager.bannerAd(bannerid):Container(width: 0,height: 0,),
      backgroundColor: ColorChanged.secondaryColor,
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
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              AppIcon.about,
              width: 22.w,
              height: 22.w,
              color: ColorChanged.tertiaryColor,
            ),
            onPressed: () {},
          )
        ],
        backgroundColor: ColorChanged.primaryColor,
        title: Text(
          "About",
          style: TextStyle(
            //  color: Colors.white,
            color: ColorChanged.tertiaryColor,
            fontSize: 23.sp,
            fontWeight: FontWeight.bold,
            // fontFamily: AppFont.JollyGood
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: GetBuilder<AdsApplovinCtrl>(
              builder: (aplController) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          aplController.showMediationDebuggerTest();
                        },
                        child: const Text("Mediation Debugger"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          aplController.interstitialAdShowing();
                        },
                        child: const Text("Interstitial"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          aplController.rewardedAdShowing();
                        },
                        child: const Text("Rewarded"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          aplController.programmaticMRecShowing();
                        },
                        child: const Text('Show Programmatic MREC'),
                      ),
                      aplController.mrecShowing(),
                      ElevatedButton(
                        onPressed: () async {
                          aplController.programmaticBannerShowing();
                        },
                        child: const Text('Show Programmatic Banner'),
                      ),
                      aplController.bannerShowing()
                    ],
                  )),
        ),
      ),
    ));
  }
}
